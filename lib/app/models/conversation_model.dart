// To parse this JSON data, do
//
//     final conversationsModel = conversationsModelFromJson(jsonString);

import 'dart:convert';

List<ConversationsModel> conversationsModelFromJson(String str) => List<ConversationsModel>.from(json.decode(str).map((x) => ConversationsModel.fromJson(x)));

String conversationsModelToJson(List<ConversationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationsModel {
  ConversationModel? rowToJson;

  ConversationsModel({
    this.rowToJson,
  });

  factory ConversationsModel.fromJson(Map<String, dynamic> json) => ConversationsModel(
    rowToJson: json["row_to_json"] == null ? null : ConversationModel.fromJson(json["row_to_json"]),
  );

  Map<String, dynamic> toJson() => {
    "row_to_json": rowToJson?.toJson(),
  };
}

class ConversationModel {
  String? id;
  String? user1;
  String? user2;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isGroup;
  bool? isSeen;
  bool? isTyping;
  dynamic lastMessage;
  dynamic note;
  dynamic user1Role;
  dynamic user2Role;

  ConversationModel({
    this.id,
    this.user1,
    this.user2,
    this.createdAt,
    this.updatedAt,
    this.isGroup,
    this.isSeen,
    this.isTyping,
    this.lastMessage,
    this.note,
    this.user1Role,
    this.user2Role,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["id"],
    user1: json["user1"],
    user2: json["user2"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isGroup: json["is_group"],
    isSeen: json["is_seen"],
    isTyping: json["is_typing"],
    lastMessage: json["last_message"],
    note: json["note"],
    user1Role: json["user1_role"],
    user2Role: json["user2_role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user1": user1,
    "user2": user2,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_group": isGroup,
    "is_seen": isSeen,
    "is_typing": isTyping,
    "last_message": lastMessage,
    "note": note,
    "user1_role": user1Role,
    "user2_role": user2Role,
  };
}
