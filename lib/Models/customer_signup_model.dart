import 'dart:convert';

CustomerSignupModel customerSignupModelFromJson(String str) => CustomerSignupModel.fromJson(json.decode(str));

String customerSignupModelToJson(CustomerSignupModel data) => json.encode(data.toJson());

class CustomerSignupModel {
  String? status;
  String? message;
  String? data;

  CustomerSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerSignupModel.fromJson(Map<String, dynamic> json) => CustomerSignupModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
