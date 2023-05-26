import 'dart:convert';

EmployeeSigninModel employeeSigninModelFromJson(String str) => EmployeeSigninModel.fromJson(json.decode(str));

String employeeSigninModelToJson(EmployeeSigninModel data) => json.encode(data.toJson());

class EmployeeSigninModel {
  EmployeeSigninModel({
   this.status,
    this.message,
   this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory EmployeeSigninModel.fromJson(Map<String, dynamic> json) => EmployeeSigninModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    // data: Data.fromJson(json["data"]),
    data : json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
   this.usersCustomersId,
   this.oneSignalId,
   this.usersCustomersType,
   this.fullName,
   this.phone,
   this.email,
   this.password,
   this.profilePic,
   this.proofDocument,
   this.validDocument,
   this.notifications,
   this.accountType,
   this.socialAccType,
   this.googleAccessToken,
   this.verifyCode,
   this.verifiedBadge,
   this.dateExpiry,
   this.dateAdded,
   this.status,
  });

  int? usersCustomersId;
  String? oneSignalId;
  String? usersCustomersType;
  String? fullName;
  String? phone;
  String? email;
  String? password;
  String? profilePic;
  dynamic proofDocument;
  dynamic validDocument;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  dynamic verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  DateTime? dateAdded;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
    usersCustomersType: json["users_customers_type"],
    fullName: json["full_name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    profilePic: json["profile_pic"],
    proofDocument: json["proof_document"],
    validDocument: json["valid_document"],
    notifications: json["notifications"],
    accountType: json["account_type"],
    socialAccType: json["social_acc_type"],
    googleAccessToken: json["google_access_token"],
    verifyCode: json["verify_code"],
    verifiedBadge: json["verified_badge"],
    dateExpiry: json["date_expiry"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_customers_id": usersCustomersId,
    "one_signal_id": oneSignalId,
    "users_customers_type": usersCustomersType,
    "full_name": fullName,
    "phone": phone,
    "email": email,
    "password": password,
    "profile_pic": profilePic,
    "proof_document": proofDocument,
    "valid_document": validDocument,
    "notifications": notifications,
    "account_type": accountType,
    "social_acc_type": socialAccType,
    "google_access_token": googleAccessToken,
    "verify_code": verifyCode,
    "verified_badge": verifiedBadge,
    "date_expiry": dateExpiry,
    "date_added": dateAdded?.toIso8601String(),
    "status": status,
  };
}
