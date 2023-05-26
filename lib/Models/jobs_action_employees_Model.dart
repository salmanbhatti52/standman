import 'dart:convert';

JobsActionEmployeesModel jobsActionEmployeesModelFromJson(String str) => JobsActionEmployeesModel.fromJson(json.decode(str));

String jobsActionEmployeesModelToJson(JobsActionEmployeesModel data) => json.encode(data.toJson());

class JobsActionEmployeesModel {
  JobsActionEmployeesModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory JobsActionEmployeesModel.fromJson(Map<String, dynamic> json) => JobsActionEmployeesModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
