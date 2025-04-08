// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

List<PaymentMethodModel> paymentMethodModelFromJson(String str) =>
    List<PaymentMethodModel>.from(
        json.decode(str).map((x) => PaymentMethodModel.fromJson(x)));

String paymentMethodModelToJson(List<PaymentMethodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodModel {
  String? id;
  String? name;
  String? type;
  String? apiKey;
  String? secretKey;
  String? webhookUrl;
  List<String>? currencySupported;
  bool? active;
  bool? testMode;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentMethodModel({
    this.id,
    this.name,
    this.type,
    this.apiKey,
    this.secretKey,
    this.webhookUrl,
    this.currencySupported,
    this.active,
    this.testMode,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        apiKey: json["api_key"],
        secretKey: json["secret_key"],
        webhookUrl: json["webhook_url"],
        currencySupported: json["currency_supported"] == null
            ? []
            : List<String>.from(json["currency_supported"]!.map((x) => x)),
        active: json["active"],
        testMode: json["test_mode"],
        logoUrl: json["logo_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "api_key": apiKey,
        "secret_key": secretKey,
        "webhook_url": webhookUrl,
        "currency_supported": currencySupported == null
            ? []
            : List<dynamic>.from(currencySupported!.map((x) => x)),
        "active": active,
        "test_mode": testMode,
        "logo_url": logoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
