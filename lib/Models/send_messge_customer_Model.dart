import 'dart:convert';

SendMessgeCustomerModel sendMessgeCustomerModelFromJson(String str) => SendMessgeCustomerModel.fromJson(json.decode(str));

String sendMessgeCustomerModelToJson(SendMessgeCustomerModel data) => json.encode(data.toJson());

class SendMessgeCustomerModel {
  String? status;
  String? message;

  SendMessgeCustomerModel({
    this.status,
    this.message,
  });

  factory SendMessgeCustomerModel.fromJson(Map<String, dynamic> json) => SendMessgeCustomerModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
