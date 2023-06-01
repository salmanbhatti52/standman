// To parse this JSON data, do
//
//     final addJobRatingModel = addJobRatingModelFromJson(jsonString);

import 'dart:convert';

AddJobRatingModel addJobRatingModelFromJson(String str) => AddJobRatingModel.fromJson(json.decode(str));

String addJobRatingModelToJson(AddJobRatingModel data) => json.encode(data.toJson());

class AddJobRatingModel {
  String? status;
  Message? message;

  AddJobRatingModel({
    this.status,
    this.message,
  });

  factory AddJobRatingModel.fromJson(Map<String, dynamic> json) => AddJobRatingModel(
    status: json["status"],
    message: Message.fromJson(json["message"]),
    // data: json["data"] != null ? List<Data>.from(json["data"].map((x) => Datum.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message!.toJson(),
  };
}

class Message {
  int? jobsRatingsId;
  String? usersCustomersId;
  String? employeeUsersCustomersId;
  String? jobsId;
  String? rating;
  String? comment;
  DateTime? dateAdded;
  String? status;

  Message({
    this.jobsRatingsId,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
    this.rating,
    this.comment,
    this.dateAdded,
    this.status,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    jobsRatingsId: json["jobs_ratings_id"],
    usersCustomersId: json["users_customers_id"],
    employeeUsersCustomersId: json["employee_users_customers_id"],
    jobsId: json["jobs_id"],
    rating: json["rating"],
    comment: json["comment"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "jobs_ratings_id": jobsRatingsId,
    "users_customers_id": usersCustomersId,
    "employee_users_customers_id": employeeUsersCustomersId,
    "jobs_id": jobsId,
    "rating": rating,
    "comment": comment,
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}
