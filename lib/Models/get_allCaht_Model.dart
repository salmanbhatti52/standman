// To parse this JSON data, do
//
//     final getAllCahtModel = getAllCahtModelFromJson(jsonString);

import 'dart:convert';

GetAllCahtModel getAllCahtModelFromJson(String str) => GetAllCahtModel.fromJson(json.decode(str));

String getAllCahtModelToJson(GetAllCahtModel data) => json.encode(data.toJson());

class GetAllCahtModel {
  String? status;
  List<Datum>? data;

  GetAllCahtModel({
    this.status,
    this.data,
  });

  factory GetAllCahtModel.fromJson(Map<String, dynamic> json) => GetAllCahtModel(
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
  int? senderId;
  int? receiverId;
  String? date;
  String? status;
  String? messageType;
  String? lastMessage;
  UserData? userData;

  Datum({
    this.senderId,
    this.receiverId,
    this.date,
    this.status,
    this.messageType,
    this.lastMessage,
    this.userData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    date: json["date"],
    status: json["status"],
    messageType: json["message_type"],
    lastMessage: json["last_message"],
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "receiver_id": receiverId,
    "date": date,
    "status": status,
    "message_type": messageType,
    "last_message": lastMessage,
    "user_data": userData!.toJson(),
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
  dynamic proofDocument;
  dynamic validDocument;
  String? messages;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  dynamic verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  String? walletAmount;
  String? rating;
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
    this.rating,
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
    rating: json["rating"],
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
    "rating": rating,
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}
