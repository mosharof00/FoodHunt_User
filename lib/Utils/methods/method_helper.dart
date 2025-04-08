import 'package:flutter/material.dart';

import '../../Helper/helper_utils.dart';

class MethodHelper {
  static double getDeliveryCharge(double distanceInMeters) {
    double distanceInMiles =
        distanceInMeters / 1609.34; // Convert meters to miles
    double baseCharge = 3.0; // Minimum charge
    double extraCharge =
        (distanceInMiles > 1) ? (distanceInMiles - 1) * 1.5 : 0.0;

    return double.parse((baseCharge + extraCharge).toStringAsFixed(2));
  }

  static String getETA(
      {required double distanceInMeters, required double eta}) {
    double etaInMinutes =
        eta; // The ETA you received from the response is already in minutes

    // Ensure a minimum of 5 minutes for very short distances
    int minEta = etaInMinutes < 5 ? 5 : etaInMinutes.floor();
    int maxEta = (etaInMinutes * 1.5).ceil(); // Maximum time is 1.5x of min ETA

    return '$minEta-$maxEta mins';
  }



 static Color getOrderStatusColor(String status, {bool isForText = true}) {
    Color color;

    switch (status) {
      case OrderStatus.pending:
        color = Colors.orange;
        break;
      case OrderStatus.cooking:
        color = Colors.blue;
        break;
      case OrderStatus.waitingPickUp:
        color = Colors.purple;
        break;
      case OrderStatus.pickedUp:
        color = Colors.green;
        break;
      case OrderStatus.delivered:
        color = Colors.teal;
        break;
      case OrderStatus.canceled:
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
        break;
    }

    return isForText ? color : color.withAlpha(50);
  }


// String getOffer(double regularPrice, double? discountValue, String? discountType) {
  //   if (discountValue == null || discountValue == 0 || regularPrice == 0) {
  //     return '0.0%'; // No discount
  //   }
  //
  //   double discountPercentage;
  //
  //   if (discountType == 'percentage') {
  //     discountPercentage = discountValue; // Directly use the percentage
  //   } else if (discountType == 'fixed') {
  //     discountPercentage = (discountValue / regularPrice) * 100; // Convert fixed discount to percentage
  //   } else {
  //     return '0.0%'; // Unknown discount type
  //   }
  //
  //   return '${discountPercentage.toStringAsFixed(1)}%';
  // }
}
