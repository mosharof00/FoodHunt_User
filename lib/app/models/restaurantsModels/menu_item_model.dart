// To parse this JSON data, do
//
//     final menuItemModel = menuItemModelFromJson(jsonString);

import 'dart:convert';

List<MenuItemModel> menuItemModelFromJson(String str) =>
    List<MenuItemModel>.from(
        json.decode(str).map((x) => MenuItemModel.fromJson(x)));

String menuItemModelToJson(List<MenuItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItemModel {
  String? id;
  String? restaurantId;
  int? category;
  String? name;
  String? description;
  dynamic basePrice;
  Map<String, dynamic>? sizePrices;
  List<AddOn>? addOns;
  String? availableStart;
  String? availableEnd;
  String? imageUrl;
  bool? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic ratings;
  int? numberOfRatings;

  MenuItemModel({
    this.id,
    this.restaurantId,
    this.category,
    this.name,
    this.description,
    this.basePrice,
    this.sizePrices,
    this.addOns,
    this.availableStart,
    this.availableEnd,
    this.imageUrl,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.ratings,
    this.numberOfRatings,
  });

  MenuItemModel copyWith({
    String? id,
    String? restaurantId,
    int? category,
    String? name,
    String? description,
    dynamic basePrice,
    Map<String, dynamic>? sizePrices,
    List<AddOn>? addOns,
    String? availableStart,
    String? availableEnd,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic ratings,
    int? numberOfRatings,
  }) =>
      MenuItemModel(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        category: category ?? this.category,
        name: name ?? this.name,
        description: description ?? this.description,
        basePrice: basePrice ?? this.basePrice,
        sizePrices: sizePrices ?? this.sizePrices,
        addOns: addOns ?? this.addOns,
        availableStart: availableStart ?? this.availableStart,
        availableEnd: availableEnd ?? this.availableEnd,
        imageUrl: imageUrl ?? this.imageUrl,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ratings: ratings ?? this.ratings,
        numberOfRatings: numberOfRatings ?? this.numberOfRatings,
      );

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        basePrice: json["base_price"],
        sizePrices: json["size_prices"] != null
            ? Map<String, dynamic>.from(json["size_prices"])
            : null,
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        availableStart: json["available_start"],
        availableEnd: json["available_end"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        ratings: json["ratings"],
        numberOfRatings: json["number_of_ratings"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "category": category,
        "name": name,
        "description": description,
        "base_price": basePrice,
        "size_prices": sizePrices,
        "add_ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "available_start": availableStart,
        "available_end": availableEnd,
        "image_url": imageUrl,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "ratings": ratings,
        "number_of_ratings": numberOfRatings,
      };
}

class AddOn {
  String? name;
  String? image;
  double? price;

  AddOn({
    this.name,
    this.image,
    this.price,
  });

  AddOn copyWith({
    String? name,
    String? image,
    double? price,
  }) =>
      AddOn(
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
      );

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        name: json["name"],
        image: json["image"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
      };
}
