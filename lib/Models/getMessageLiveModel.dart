// To parse this JSON data, do
//
//     final getMessageLiveModel = getMessageLiveModelFromJson(jsonString);

import 'dart:convert';

GetMessageLiveModel getMessageLiveModelFromJson(String str) => GetMessageLiveModel.fromJson(json.decode(str));

String getMessageLiveModelToJson(GetMessageLiveModel data) => json.encode(data.toJson());

class GetMessageLiveModel {
  String? status;
  List<Datum>? data;

  GetMessageLiveModel({
    this.status,
    this.data,
  });

  factory GetMessageLiveModel.fromJson(Map<String, dynamic> json) => GetMessageLiveModel(
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
  dynamic verifyCode;
  String? countryCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  String? walletAmount;
  String? rating;
  String? dateAdded;
  String? status;
  int? usersSystemId;
  int? usersSystemRolesId;
  String? mobile;
  String? city;
  String? address;
  String? userImage;
  String? isDeleted;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

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
    this.countryCode,
    this.verifiedBadge,
    this.dateExpiry,
    this.walletAmount,
    this.rating,
    this.dateAdded,
    this.status,
    this.usersSystemId,
    this.usersSystemRolesId,
    this.mobile,
    this.city,
    this.address,
    this.userImage,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
    countryCode: json["country_code"],
    verifiedBadge: json["verified_badge"],
    dateExpiry: json["date_expiry"],
    walletAmount: json["wallet_amount"],
    rating: json["rating"],
    dateAdded: json["date_added"],
    status: json["status"],
    usersSystemId: json["users_system_id"],
    usersSystemRolesId: json["users_system_roles_id"],
    mobile: json["mobile"],
    city: json["city"],
    address: json["address"],
    userImage: json["user_image"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
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
    "country_code": countryCode,
    "verified_badge": verifiedBadge,
    "date_expiry": dateExpiry,
    "wallet_amount": walletAmount,
    "rating": rating,
    "date_added": dateAdded,
    "status": status,
    "users_system_id": usersSystemId,
    "users_system_roles_id": usersSystemRolesId,
    "mobile": mobile,
    "city": city,
    "address": address,
    "user_image": userImage,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
