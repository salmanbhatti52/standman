import 'dart:convert';

UpdateProfileEmployeeModel updateProfileEmployeeModelFromJson(String str) => UpdateProfileEmployeeModel.fromJson(json.decode(str));

String updateProfileEmployeeModelToJson(UpdateProfileEmployeeModel data) => json.encode(data.toJson());

class UpdateProfileEmployeeModel {
  UpdateProfileEmployeeModel({
   this.status,
    this.message,
   this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory UpdateProfileEmployeeModel.fromJson(Map<String, dynamic> json) => UpdateProfileEmployeeModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    'message': message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.usersCustomersId,
    this.oneSignalId,
    this.usersCustomersType,
    this.fullName,
    this.phone,
    this.email,
    this.password,
    this.profilePic,
    this.proofDocument,
    // this.validDocument,
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
  String? proofDocument;
  // String? validDocument;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  String? verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  DateTime? dateAdded;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
    usersCustomersType: json["users_customers_type"],
    fullName: json["full_name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    profilePic: json["profile_pic"],
    proofDocument: json["proof_document"],
    // validDocument: json["valid_document"],
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
    // "valid_document": validDocument,
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
