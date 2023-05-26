// To parse this JSON data, do
//
//     final updateMessgeModel = updateMessgeModelFromJson(jsonString);

import 'dart:convert';

UpdateMessgeModel updateMessgeModelFromJson(String str) => UpdateMessgeModel.fromJson(json.decode(str));

String updateMessgeModelToJson(UpdateMessgeModel data) => json.encode(data.toJson());

class UpdateMessgeModel {
  String? status;
  String? message;

  UpdateMessgeModel({
    this.status,
    this.message,
  });

  factory UpdateMessgeModel.fromJson(Map<String, dynamic> json) => UpdateMessgeModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
