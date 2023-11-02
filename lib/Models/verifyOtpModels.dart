// To parse this JSON data, do
//
//     final verifyOtpModels = verifyOtpModelsFromJson(jsonString);

import 'dart:convert';

VerifyOtpModels verifyOtpModelsFromJson(String str) =>
    VerifyOtpModels.fromJson(json.decode(str));

String verifyOtpModelsToJson(VerifyOtpModels data) =>
    json.encode(data.toJson());

class VerifyOtpModels {
  String? status;
  String? message;

  VerifyOtpModels({
    this.status,
    this.message,
  });

  factory VerifyOtpModels.fromJson(Map<String, dynamic> json) =>
      VerifyOtpModels(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
