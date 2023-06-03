// To parse this JSON data, do
//
//     final allRatingsModel = allRatingsModelFromJson(jsonString);

import 'dart:convert';

AllRatingsModel allRatingsModelFromJson(String str) => AllRatingsModel.fromJson(json.decode(str));

String allRatingsModelToJson(AllRatingsModel data) => json.encode(data.toJson());

class AllRatingsModel {
  String? status;
  List<Datum>? data;

  AllRatingsModel({
    this.status,
    this.data,
  });

  factory AllRatingsModel.fromJson(Map<String, dynamic> json) => AllRatingsModel(
    status: json["status"],
    // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? jobsRatingsId;
  int? usersCustomersId;
  int? employeeUsersCustomersId;
  int? jobsId;
  String? rating;
  String? comment;
  DateTime? dateAdded;
  String? status;
  CustomerData? customerData;

  Datum({
    this.jobsRatingsId,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
    this.rating,
    this.comment,
    this.dateAdded,
    this.status,
    this.customerData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobsRatingsId: json["jobs_ratings_id"],
    usersCustomersId: json["users_customers_id"],
    employeeUsersCustomersId: json["employee_users_customers_id"],
    jobsId: json["jobs_id"],
    rating: json["rating"],
    comment: json["comment"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
    customerData: CustomerData.fromJson(json["customer_data"]),
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
    "customer_data": customerData!.toJson(),
  };
}

class CustomerData {
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

  CustomerData({
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

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
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
