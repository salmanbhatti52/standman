import 'dart:convert';

ForgotPasswordModel ForgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String customerForgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data : json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.otp,
    this.message,
  });

  int? otp;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otp: json["otp"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "message": message,
  };
}
