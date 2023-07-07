// To parse this JSON data, do
//
//     final customerSignupModel = customerSignupModelFromJson(jsonString);

import 'dart:convert';

CustomerSignupModel customerSignupModelFromJson(String str) => CustomerSignupModel.fromJson(json.decode(str));

String customerSignupModelToJson(CustomerSignupModel data) => json.encode(data.toJson());

class CustomerSignupModel {
  String? status;
  String? message;
  Data? data;

  CustomerSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerSignupModel.fromJson(Map<String, dynamic> json) => CustomerSignupModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data : json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? message;
  Otpdetails? otpdetails;

  Data({
    this.message,
    this.otpdetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    otpdetails: Otpdetails.fromJson(json["otpdetails"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "otpdetails": otpdetails!.toJson(),
  };
}

class Otpdetails {
  int? otp;
  String? message;

  Otpdetails({
    this.otp,
    this.message,
  });

  factory Otpdetails.fromJson(Map<String, dynamic> json) => Otpdetails(
    otp: json["otp"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "message": message,
  };
}
