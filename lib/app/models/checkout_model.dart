// To parse this JSON data, do
//
//     final checkoutModel = checkoutModelFromJson(jsonString);

import 'dart:convert';


PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  String? url;
  String? referenceId;

  PaymentModel({
    this.url,
    this.referenceId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        url: json["url"],
        referenceId: json["referenceId"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "referenceId": referenceId,
      };
}

