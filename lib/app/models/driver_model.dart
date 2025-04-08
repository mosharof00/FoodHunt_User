// To parse this JSON data, do
//
//     final driverTrackingModel = driverTrackingModelFromJson(jsonString);

import 'dart:convert';

DriverTrackingModel driverTrackingModelFromJson(String str) =>
    DriverTrackingModel.fromJson(json.decode(str));

String driverTrackingModelToJson(DriverTrackingModel data) =>
    json.encode(data.toJson());

class DriverTrackingModel {
  String? id;
  String? fullName;
  String? driverImageUrl;
  String? phone;
  String? vehicleType;
  double? currentOrderDeliveryEta;
  double? currentLatitude;
  double? currentLongitude;

  DriverTrackingModel({
    this.id,
    this.fullName,
    this.driverImageUrl,
    this.phone,
    this.vehicleType,
    this.currentOrderDeliveryEta,
    this.currentLatitude,
    this.currentLongitude,
  });

  factory DriverTrackingModel.fromJson(Map<String, dynamic> json) =>
      DriverTrackingModel(
        id: json["id"],
        fullName: json["full_name"],
        driverImageUrl: json["driver_image_url"],
        phone: json["phone"],
        vehicleType: json["vehicle_type"],
        currentOrderDeliveryEta: json["current_order_delivery_eta"]?.toDouble(),
        currentLatitude: json["current_latitude"]?.toDouble(),
        currentLongitude: json["current_longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "driver_image_url": driverImageUrl,
        "phone": phone,
        "vehicle_type": vehicleType,
        "current_order_delivery_eta": currentOrderDeliveryEta,
        "current_latitude": currentLatitude,
        "current_longitude": currentLongitude,
      };
}
