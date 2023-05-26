import 'dart:convert';

ChatStartUserModel chatStartUserModelFromJson(String str) => ChatStartUserModel.fromJson(json.decode(str));

String chatStartUserModelToJson(ChatStartUserModel data) => json.encode(data.toJson());

class ChatStartUserModel {
  String? status;
  String? message;

  ChatStartUserModel({
    this.status,
    this.message,
  });

  factory ChatStartUserModel.fromJson(Map<String, dynamic> json) => ChatStartUserModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
