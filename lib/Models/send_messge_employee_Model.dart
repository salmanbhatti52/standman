// To parse this JSON data, do
//
//     final sendMessgeEmployeeModel = sendMessgeEmployeeModelFromJson(jsonString);

import 'dart:convert';

SendMessgeEmployeeModel sendMessgeEmployeeModelFromJson(String str) => SendMessgeEmployeeModel.fromJson(json.decode(str));

String sendMessgeEmployeeModelToJson(SendMessgeEmployeeModel data) => json.encode(data.toJson());

class SendMessgeEmployeeModel {
  String? status;
  String? message;

  SendMessgeEmployeeModel({
    this.status,
    this.message,
  });

  factory SendMessgeEmployeeModel.fromJson(Map<String, dynamic> json) => SendMessgeEmployeeModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
