// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  int? id;
  String? name;
  String? iconUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? active;

  CategoryModel({
    this.id,
    this.name,
    this.iconUrl,
    this.createdAt,
    this.updatedAt,
    this.active,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? iconUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? active,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        iconUrl: iconUrl ?? this.iconUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        active: active ?? this.active,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        iconUrl: json["icon_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_url": iconUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "active": active,
      };
}
