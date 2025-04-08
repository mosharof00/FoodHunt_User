import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


class DistanceHelper {
  /// Get distance in meters between two locations
  static double getDistanceInMeters({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Get ETA in minutes based on an assumed speed (e.g., 40 km/h for a bike)
  static double getETA({
    required double totalMiter,
    required double speedKmh, // Default speed in km/h (adjust as needed)
  }) {
    // Convert speed from km/h to meters per second (m/s)
    double speedMs = (speedKmh * 1000) / 3600; // 1 km/h = 1000/3600 m/s

    // Calculate ETA in seconds
    double etaSeconds = totalMiter / speedMs;

    // Convert to minutes
    double etaMinutes = etaSeconds / 60;
    return etaMinutes; // Returns ETA in minutes
  }


  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return "${distanceInMeters.toStringAsFixed(0)} m"; // Show in meters without decimals
    } else {
      double distanceInKm = distanceInMeters / 1000; // Convert to kilometers
      return "${distanceInKm.toStringAsFixed(2)} km"; // Format to 2 decimal places
    }
  }



 static String deliveryBy({required double totalMinutes}) {
   DateTime now = DateTime.now();

   // Add the total minutes to the current time
   DateTime newTime = now.add(Duration(minutes: totalMinutes.toInt()));

   // Format the time as "h:mm a" (e.g., "8:22 PM")
   return DateFormat('h:mm a').format(newTime);
  }


}
