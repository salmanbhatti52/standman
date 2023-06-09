// To parse this JSON data, do
//
//     final employeeSignupModel = employeeSignupModelFromJson(jsonString);

import 'dart:convert';

EmployeeSignupModel employeeSignupModelFromJson(String str) => EmployeeSignupModel.fromJson(json.decode(str));

String employeeSignupModelToJson(EmployeeSignupModel data) => json.encode(data.toJson());

class EmployeeSignupModel {
  String? status;
  String? message;
  String? data;

  EmployeeSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeSignupModel.fromJson(Map<String, dynamic> json) => EmployeeSignupModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
