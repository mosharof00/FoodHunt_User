// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<RestaurantModel> subCategoryModelFromJson(String str) =>
    List<RestaurantModel>.from(
        json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String subCategoryModelToJson(List<RestaurantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
  String? id;
  String? restaurantName;
  String? profile;
  String? coverImageUrl;
  String? address;
  double? latitude;
  double? longitude;
  double? distance;
  double? eta;
  dynamic totalRating;
  dynamic couponCode;
  dynamic discountType;
  dynamic discountValue;
  List<dynamic>? categories;

  RestaurantModel({
    this.id,
    this.restaurantName,
    this.profile,
    this.coverImageUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.distance,
    this.eta,
    this.totalRating,
    this.couponCode,
    this.discountType,
    this.discountValue,
    this.categories,
  });

  RestaurantModel copyWith({
    String? id,
    String? restaurantName,
    String? profile,
    String? coverImageUrl,
    String? address,
    double? latitude,
    double? longitude,
    double? distance,
    double? eta,
    dynamic totalRating,
    dynamic couponCode,
    dynamic discountType,
    dynamic discountValue,
    List<dynamic>? categories,
  }) =>
      RestaurantModel(
        id: id ?? this.id,
        restaurantName: restaurantName ?? this.restaurantName,
        profile: profile ?? this.profile,
        coverImageUrl: coverImageUrl ?? this.coverImageUrl,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        distance: distance ?? this.distance,
        eta: eta ?? this.eta,
        totalRating: totalRating ?? this.totalRating,
        couponCode: couponCode ?? this.couponCode,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        categories: categories ?? this.categories,
      );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        restaurantName: json["restaurant_name"],
        profile: json["profile"],
        coverImageUrl: json["cover_image_url"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        eta: json["eta"]?.toDouble(),
        totalRating: json["total_rating"],
        couponCode: json["coupon_code"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        categories: json["categories"] == null
            ? []
            : List<dynamic>.from(json["categories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_name": restaurantName,
        "profile": profile,
        "cover_image_url": coverImageUrl,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "eta": eta,
        "total_rating": totalRating,
        "coupon_code": couponCode,
        "discount_type": discountType,
        "discount_value": discountValue,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
      };
}
