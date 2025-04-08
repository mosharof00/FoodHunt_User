
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Helper/logger.dart';


class LocationService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String> getAddressFromLatLng() async {
    try {
      Position position = await determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      HelperUtils.latitude = position.latitude;
      HelperUtils.longitude = position.longitude;
      Log.i(
          'Latitude: ${HelperUtils.latitude}  Longitude: ${HelperUtils.longitude}');

      Placemark place = placemarks[0];
      return "${place.street}, ${place.locality}, ${place.country}";
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<AddressModel?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        return AddressModel(
          address: address,
          latitude: latitude,
          longitude: longitude,
        );
      } else {
        return null;
      }
    } catch (e) {
      Log.e('Error: $e');
      return null;
    }
  }

  static double getDistanceInMeters(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    // double distanceInKm = distanceInMeters / 1000; // Convert meters to KM
    return distanceInMeters;
  }
}

class AddressModel {
  AddressModel({this.address, this.latitude, this.longitude});
  final String? address;
  final double? latitude;
  final double? longitude;
}
// Future<Position> getCurrentLocation() async {
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     throw Exception('Location services are disabled');
//   }
//
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       throw Exception('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     throw Exception('Location permissions are permanently denied');
//   }
//
//
//
//   return await Geolocator.getCurrentPosition();
// }
