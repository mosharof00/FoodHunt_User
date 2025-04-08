// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:food_hunt_user/app/models/restaurantsModels/menu_item_model.dart';


List<Order> orderModelFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderModelToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int? id;
  String? userId;
  String? restaurantId;
  dynamic deliveryDriverId;
  String? orderStatus;
  dynamic subtotal;
  double? discount;
  String? promoCode;
  double? finalPrice;
  String? paymentStatus;
  String? paymentMethod;
  dynamic deliveryFee;
  dynamic tip;
  String? address;
  double? latitude;
  double? longitude;
  String? specialInstructions;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? paymentMethodLogo;
  double? total;
  double? serviceCharge;
  List<OrderItem>? orderItems;
  String? deliveryProof;
  int? itemQty;
  String? restaurantName;
  String? restaurantProfileImage;

  Order({
    this.id,
    this.userId,
    this.restaurantId,
    this.deliveryDriverId,
    this.orderStatus,
    this.subtotal,
    this.discount,
    this.promoCode,
    this.finalPrice,
    this.paymentStatus,
    this.paymentMethod,
    this.deliveryFee,
    this.tip,
    this.address,
    this.latitude,
    this.longitude,
    this.specialInstructions,
    this.createdAt,
    this.updatedAt,
    this.paymentMethodLogo,
    this.total,
    this.serviceCharge,
    this.orderItems,
    this.deliveryProof,
    this.itemQty,
    this.restaurantName,
    this.restaurantProfileImage,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        deliveryDriverId: json["delivery_driver_id"],
        orderStatus: json["order_status"],
        subtotal: json["subtotal"],
        discount: json["discount"]?.toDouble(),
        promoCode: json["promo_code"],
        finalPrice: json["final_price"]?.toDouble(),
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        deliveryFee: json["delivery_fee"],
        tip: json["tip"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        specialInstructions: json["special_instructions"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        paymentMethodLogo: json["payment_method_logo"],
        total: json["total"]?.toDouble(),
        serviceCharge: json["service_charge"]?.toDouble(),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        deliveryProof: json["delivery_proof"],
        itemQty: json["item_qty"],
        restaurantName: json["restaurant_name"],
        restaurantProfileImage: json["restaurant_profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "restaurant_id": restaurantId,
        "delivery_driver_id": deliveryDriverId,
        "order_status": orderStatus,
        "subtotal": subtotal,
        "discount": discount,
        "promo_code": promoCode,
        "final_price": finalPrice,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "delivery_fee": deliveryFee,
        "tip": tip,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "special_instructions": specialInstructions,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "payment_method_logo": paymentMethodLogo,
        "total": total,
        "service_charge": serviceCharge,
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "delivery_proof": deliveryProof,
        "item_qty": itemQty,
        "restaurant_name": restaurantName,
        "restaurant_profile_image": restaurantProfileImage,
      };
}

class OrderItem {
  int? id;
  String? name;
  Map<String, dynamic>? size;
  String? image;
  dynamic total;
  List<AddOn>? addOn;
  int? orderId;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic totalPrice;
  String? menuItemId;
  dynamic itemDiscount;
  String? restaurantId;
  dynamic pricePerUnit;
  String? specialInstructions;

  OrderItem({
    this.id,
    this.name,
    this.size,
    this.image,
    this.total,
    this.addOn,
    this.orderId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.totalPrice,
    this.menuItemId,
    this.itemDiscount,
    this.restaurantId,
    this.pricePerUnit,
    this.specialInstructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        name: json["name"],
        size: json["size"] != null
            ? Map<String, dynamic>.from(json["size"])
            : null,
        image: json["image"],
        total: json["total"],
        addOn: json["add_on"] == null
            ? []
            : List<AddOn>.from(json["add_on"]!.map((x) => AddOn.fromJson(x))),
        orderId: json["order_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalPrice: json["total_price"],
        menuItemId: json["menu_item_id"],
        itemDiscount: json["item_discount"],
        restaurantId: json["restaurant_id"],
        pricePerUnit: json["price_per_unit"],
        specialInstructions: json["special_instructions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "image": image,
        "total": total,
        "add_on": addOn == null
            ? []
            : List<dynamic>.from(addOn!.map((x) => x.toJson())),
        "order_id": orderId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_price": totalPrice,
        "menu_item_id": menuItemId,
        "item_discount": itemDiscount,
        "restaurant_id": restaurantId,
        "price_per_unit": pricePerUnit,
        "special_instructions": specialInstructions,
      };
}
