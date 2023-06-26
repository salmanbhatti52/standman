// To parse this JSON data, do
//
//     final chatStartwithAdminModel = chatStartwithAdminModelFromJson(jsonString);

import 'dart:convert';

ChatStartwithAdminModel chatStartwithAdminModelFromJson(String str) => ChatStartwithAdminModel.fromJson(json.decode(str));

String chatStartwithAdminModelToJson(ChatStartwithAdminModel data) => json.encode(data.toJson());

class ChatStartwithAdminModel {
  String? status;
  String? message;

  ChatStartwithAdminModel({
    this.status,
    this.message,
  });

  factory ChatStartwithAdminModel.fromJson(Map<String, dynamic> json) => ChatStartwithAdminModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
