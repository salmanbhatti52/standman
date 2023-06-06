import 'dart:convert';

UnreadedMessagesModel unreadedMessagesModelFromJson(String str) => UnreadedMessagesModel.fromJson(json.decode(str));

String unreadedMessagesModelToJson(UnreadedMessagesModel data) => json.encode(data.toJson());

class UnreadedMessagesModel {
  String? status;
  int? data;

  UnreadedMessagesModel({
    this.status,
    this.data,
  });

  factory UnreadedMessagesModel.fromJson(Map<String, dynamic> json) => UnreadedMessagesModel(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
