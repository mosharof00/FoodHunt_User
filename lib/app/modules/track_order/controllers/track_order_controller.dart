import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:food_hunt_user/Helper/logger.dart';
import 'package:food_hunt_user/app/models/driver_model.dart';
import 'package:food_hunt_user/appConfig.dart';

import '../../../../gen/colors.gen.dart';
import '../../../models/order_model.dart';
import '../views/track_order_view.dart';

class TrackOrderController extends GetxController {
  late Order order;
  final driver = DriverTrackingModel().obs;
  final isDriverInitializing = 100.obs;

  Rx<LatLng?> driverLocation = Rx<LatLng?>(null);
  GoogleMapController? mapController;
  late LatLng deliveryLocation;

  /// ETA related variables
  // var estimatedArrivalTime = ''.obs;
  // var distanceRemaining = ''.obs;

  /// Reactive variables for markers and polylines
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs;

  /// Custom marker icons
  BitmapDescriptor? driverMarkerIcon;
  BitmapDescriptor? destinationMarkerIcon;

  Timer? _locationUpdateTimer;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments['order'] != null) {
      order = Get.arguments['order'];
      deliveryLocation = LatLng(order.latitude!, order.longitude!);
      loadCustomMarkers();
      fetchDriverLocation();
      startDriverLocationUpdates();
    } else {
      Log.e('order not found');
    }
  }

  Future<void> loadCustomMarkers() async {
    driverMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(75, 75)),
      'assets/images/driver_map_location_icon.png',
    );

    destinationMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/images/delivery_map_location_icon.png',
    );
    updateMarkers();
  }

  void startDriverLocationUpdates() {
    // Poll driver location every 5 seconds
    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => fetchDriverLocation(),
    );
  }

  Future<void> fetchDriverLocation() async {
    try {
      if (isDriverInitializing.value == 100) {
        isDriverInitializing.value = 1;
      }
      final response = await Supabase.instance.client
          .from('drivers') // Replace 'driver' with the actual table name
          .select(
              'id, full_name, driver_image_url, phone, vehicle_type, current_order_delivery_eta, current_latitude, current_longitude')
          .eq('id', order.deliveryDriverId)
          .single();
      Log.i(response);
      if (driver.value.id == null) {
        driver.value = DriverTrackingModel.fromJson(response);
      }
      final double lat = response['current_latitude'];
      final double lng = response['current_longitude'];
      driverLocation.value = LatLng(lat, lng);
      Log.i('Driver : ${driverLocation.value}');
      updateMarkers();
      drawPath();
      if (isDriverInitializing.value == 1) {
        isDriverInitializing.value = 0;
      }
    } catch (e) {
      if (isDriverInitializing.value == 1) {
        isDriverInitializing.value = 2;
      }
      Log.e('Error fetching driver location: $e');
    }
  }

  void updateMarkers() {
    if (driverLocation.value == null) return;

    markers.value = {
      Marker(
          markerId: const MarkerId('driver'),
          position: driverLocation.value!,
          icon: driverMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Driver'),
          onTap: () {
            getInfoDialog();
          }),
      Marker(
        markerId: const MarkerId('destination'),
        position: deliveryLocation,
        icon: destinationMarkerIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Delivery Location'),
      ),
    };
  }

  Future<void> drawPath() async {
    if (driverLocation.value == null) return;

    final String apiKey = AppConfig.GOOGLE_API_KEY;
    final String origin =
        '${driverLocation.value!.latitude},${driverLocation.value!.longitude}';
    final String destination =
        '${deliveryLocation.latitude},${deliveryLocation.longitude}';

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final points = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> path = decodePolyline(points);
        final routes = data['routes'] as List;

        polylines.value = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: ColorName.primaryColor,
            points: path,
            width: 4,
          ),
        };

        ///  for distance and ETA calculation
        // if (routes.isNotEmpty) {
        //   final leg = routes[0]['legs'][0];
        //
        //   // Get duration in traffic if available, otherwise use regular duration
        //   final duration = leg['duration_in_traffic'] ?? leg['duration'];
        //   final distance = leg['distance'];
        //
        //   // Update the reactive variables
        //   estimatedArrivalTime.value = duration['text'];
        //   distanceRemaining.value = distance['text'];
        //
        //   // Calculate and format arrival time
        //   final int seconds = duration['value'];
        //   final arrivalTime = DateTime.now().add(Duration(seconds: seconds));
        //   final formattedTime = DateFormat('hh:mm a').format(arrivalTime);
        //
        //   estimatedArrivalTime.value = formattedTime;
        // }
      }
    } catch (e) {
      Log.e('Error drawing path: $e');
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  @override
  void onClose() {
    _locationUpdateTimer?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
