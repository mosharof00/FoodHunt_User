// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

List<Coupon> couponsModelFromJson(String str) =>
    List<Coupon>.from(json.decode(str).map((x) => Coupon.fromJson(x)));

String couponsModelToJson(List<Coupon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coupon {
  String? id;
  String? code;
  String? discountType;
  int? discountValue;
  DateTime? validFrom;
  DateTime? validTo;
  int? minOrderValue;
  int? maxDiscount;
  String? restaurantId;
  int? usageLimit;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Coupon({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.validFrom,
    this.validTo,
    this.minOrderValue,
    this.maxDiscount,
    this.restaurantId,
    this.usageLimit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Coupon copyWith({
    String? id,
    String? code,
    String? discountType,
    int? discountValue,
    DateTime? validFrom,
    DateTime? validTo,
    int? minOrderValue,
    int? maxDiscount,
    String? restaurantId,
    int? usageLimit,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Coupon(
        id: id ?? this.id,
        code: code ?? this.code,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
        minOrderValue: minOrderValue ?? this.minOrderValue,
        maxDiscount: maxDiscount ?? this.maxDiscount,
        restaurantId: restaurantId ?? this.restaurantId,
        usageLimit: usageLimit ?? this.usageLimit,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        code: json["code"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        validFrom: json["valid_from"] == null
            ? null
            : DateTime.parse(json["valid_from"]),
        validTo:
            json["valid_to"] == null ? null : DateTime.parse(json["valid_to"]),
        minOrderValue: json["min_order_value"],
        maxDiscount: json["max_discount"],
        restaurantId: json["restaurant_id"],
        usageLimit: json["usage_limit"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount_type": discountType,
        "discount_value": discountValue,
        "valid_from": validFrom?.toIso8601String(),
        "valid_to": validTo?.toIso8601String(),
        "min_order_value": minOrderValue,
        "max_discount": maxDiscount,
        "restaurant_id": restaurantId,
        "usage_limit": usageLimit,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
