// To parse this JSON data, do
//
//     final nearByOrderModel = nearByOrderModelFromJson(jsonString);

import 'dart:convert';

UserModel nearByOrderModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String nearByOrderModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? fullName;
  String? username;
  String? email;
  String? password;
  dynamic phone;
  dynamic profileImageUrl;
  dynamic address;
  String? status;
  dynamic preferences;
  dynamic promoCode;
  String? referralCode;
  dynamic referredBy;
  dynamic walletBalance;
  dynamic totalSpent;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bio;
  String? coverImage;

  UserModel({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.profileImageUrl,
    this.address,
    this.status,
    this.preferences,
    this.promoCode,
    this.referralCode,
    this.referredBy,
    this.walletBalance,
    this.totalSpent,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.coverImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        profileImageUrl: json["profile_image_url"],
        address: json["address"],
        status: json["status"],
        preferences: json["preferences"],
        promoCode: json["promo_code"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        walletBalance: json["wallet_balance"],
        totalSpent: json["total_spent"],
        userType: json["user_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bio: json["bio"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "profile_image_url": profileImageUrl,
        "address": address,
        "status": status,
        "preferences": preferences,
        "promo_code": promoCode,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "wallet_balance": walletBalance,
        "total_spent": totalSpent,
        "user_type": userType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bio": bio,
        "cover_image": coverImage,
      };
}
