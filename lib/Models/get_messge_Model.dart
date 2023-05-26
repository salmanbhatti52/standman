// To parse this JSON data, do
//
//     final getMessgeModel = getMessgeModelFromJson(jsonString);

import 'dart:convert';

GetMessgeModel getMessgeModelFromJson(String str) => GetMessgeModel.fromJson(json.decode(str));

String getMessgeModelToJson(GetMessgeModel data) => json.encode(data.toJson());

class GetMessgeModel {
  String? status;
  List<Datum>? data;

  GetMessgeModel({
    this.status,
    this.data,
  });

  factory GetMessgeModel.fromJson(Map<String, dynamic> json) => GetMessgeModel(
    status: json["status"],
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
    // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? senderType;
  String? date;
  String? time;
  String? msgType;
  String? message;
  UsersData? usersData;

  Datum({
    this.senderType,
    this.date,
    this.time,
    this.msgType,
    this.message,
    this.usersData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    senderType: json["sender_type"],
    date: json["date"],
    time: json["time"],
    msgType: json["msgType"],
    message: json["message"],
    usersData: UsersData.fromJson(json["users_data"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_type": senderType,
    "date": date,
    "time": time,
    "msgType": msgType,
    "message": message,
    "users_data": usersData!.toJson(),
  };
}

class UsersData {
  int? usersCustomersId;
  String? oneSignalId;
  String? usersCustomersType;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? profilePic;
  dynamic proofDocument;
  dynamic validDocument;
  String? messages;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  String? verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  DateTime? dateAdded;
  String? status;

  UsersData({
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
    this.dateAdded,
    this.status,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
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
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}
