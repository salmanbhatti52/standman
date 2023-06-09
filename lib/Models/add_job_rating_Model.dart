// To parse this JSON data, do
//
//     final addJobRatingModel = addJobRatingModelFromJson(jsonString);

import 'dart:convert';

AddJobRatingModel addJobRatingModelFromJson(String str) => AddJobRatingModel.fromJson(json.decode(str));

String addJobRatingModelToJson(AddJobRatingModel data) => json.encode(data.toJson());

class AddJobRatingModel {
  String? status;
  Data? data;

  AddJobRatingModel({
    this.status,
    this.data,
  });

  factory AddJobRatingModel.fromJson(Map<String, dynamic> json) => AddJobRatingModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  JobRated? jobRated;
  UserData? userData;

  Data({
    this.jobRated,
    this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    jobRated: JobRated.fromJson(json["job_rated"]),
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "job_rated": jobRated!.toJson(),
    "user_data": userData!.toJson(),
  };
}

class JobRated {
  int? jobsRatingsId;
  int? usersCustomersId;
  int? employeeUsersCustomersId;
  int? jobsId;
  String? rating;
  String? comment;
  DateTime? dateAdded;
  String?  status;

  JobRated({
    this.jobsRatingsId,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
    this.rating,
    this.comment,
    this.dateAdded,
    this.status,
  });

  factory JobRated.fromJson(Map<String, dynamic> json) => JobRated(
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

class UserData {
  int? usersCustomersId;
  String? oneSignalId;
  String? usersCustomersType;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? profilePic;
  String? proofDocument;
  String? validDocument;
  String? messages;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  dynamic verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  String? walletAmount;
  DateTime? dateAdded;
  String? status;

  UserData({
    this.usersCustomersId,
    this.oneSignalId,
    this.usersCustomersType,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.profilePic,
    this.proofDocument,
    this.validDocument,
    this.messages,
    this.notifications,
    this.accountType,
    this.socialAccType,
    this.googleAccessToken,
    this.verifyCode,
    this.verifiedBadge,
    this.dateExpiry,
    this.walletAmount,
    this.dateAdded,
    this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
    usersCustomersType: json["users_customers_type"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    profilePic: json["profile_pic"],
    proofDocument: json["proof_document"],
    validDocument: json["valid_document"],
    messages: json["messages"],
    notifications: json["notifications"],
    accountType: json["account_type"],
    socialAccType: json["social_acc_type"],
    googleAccessToken: json["google_access_token"],
    verifyCode: json["verify_code"],
    verifiedBadge: json["verified_badge"],
    dateExpiry: json["date_expiry"],
    walletAmount: json["wallet_amount"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_customers_id": usersCustomersId,
    "one_signal_id": oneSignalId,
    "users_customers_type": usersCustomersType,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "password": password,
    "profile_pic": profilePic,
    "proof_document": proofDocument,
    "valid_document": validDocument,
    "messages": messages,
    "notifications": notifications,
    "account_type": accountType,
    "social_acc_type": socialAccType,
    "google_access_token": googleAccessToken,
    "verify_code": verifyCode,
    "verified_badge": verifiedBadge,
    "date_expiry": dateExpiry,
    "wallet_amount": walletAmount,
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}
