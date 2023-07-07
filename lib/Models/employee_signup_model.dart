// To parse this JSON data, do
//
//     final employeeSignupModel = employeeSignupModelFromJson(jsonString);

import 'dart:convert';

EmployeeSignupModel employeeSignupModelFromJson(String str) => EmployeeSignupModel.fromJson(json.decode(str));

String employeeSignupModelToJson(EmployeeSignupModel data) => json.encode(data.toJson());

class EmployeeSignupModel {
  String? status;
  String? message;
  Data? data;

  EmployeeSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeSignupModel.fromJson(Map<String, dynamic> json) => EmployeeSignupModel(
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
