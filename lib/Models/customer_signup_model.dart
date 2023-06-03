import 'dart:convert';

CustomerSignupModel customerSignupModelFromJson(String str) => CustomerSignupModel.fromJson(json.decode(str));

String customerSignupModelToJson(CustomerSignupModel data) => json.encode(data.toJson());

class CustomerSignupModel {
  String? status;
  String? data;

  CustomerSignupModel({
    this.status,
    this.data,
  });

  factory CustomerSignupModel.fromJson(Map<String, dynamic> json) => CustomerSignupModel(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
