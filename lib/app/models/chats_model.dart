// To parse this JSON data, do
//
//     final chatsModel = chatsModelFromJson(jsonString);

import 'dart:convert';

List<ChatsModel> chatsModelFromJson(String str) => List<ChatsModel>.from(json.decode(str).map((x) => ChatsModel.fromJson(x)));

String chatsModelToJson(List<ChatsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatsModel {
  ChatModel? rowToJson;

  ChatsModel({
    this.rowToJson,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
    rowToJson: json["row_to_json"] == null ? null : ChatModel.fromJson(json["row_to_json"]),
  );

  Map<String, dynamic> toJson() => {
    "row_to_json": rowToJson?.toJson(),
  };
}

class ChatModel {
  String? id;
  String? conversationId;
  String? senderId;
  String? receiverId;
  String? content;
  DateTime? createdAt;
  bool? isRead;
  List<String>? fileUrls;

  ChatModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.content,
    this.createdAt,
    this.isRead,
    this.fileUrls,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["id"],
    conversationId: json["conversation_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    content: json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isRead: json["is_read"],
    fileUrls: json["file_urls"] == null ? [] : List<String>.from(json["file_urls"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "is_read": isRead,
    "file_urls": fileUrls == null ? [] : List<dynamic>.from(fileUrls!.map((x) => x)),
  };
}
