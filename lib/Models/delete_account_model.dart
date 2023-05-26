import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) => json.encode(data.toJson());

class DeleteAccountModel {
  DeleteAccountModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
