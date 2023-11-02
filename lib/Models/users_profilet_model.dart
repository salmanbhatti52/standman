// // To parse this JSON data, do
// //
// //     final usersProfileModel = usersProfileModelFromJson(jsonString);

// import 'dart:convert';

// UsersProfileModel usersProfileModelFromJson(String str) => UsersProfileModel.fromJson(json.decode(str));

// String usersProfileModelToJson(UsersProfileModel data) => json.encode(data.toJson());

// class UsersProfileModel {
//   String? status;
//   Data? data;

//   UsersProfileModel({
//     this.status,
//     this.data,
//   });

//   factory UsersProfileModel.fromJson(Map<String, dynamic> json) => UsersProfileModel(
//     status: json["status"],
//     data: Data.fromJson(json["data"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": data!.toJson(),
//   };
// }

// class Data {
//   int? usersCustomersId;
//   String? oneSignalId;
//   String? usersCustomersType;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   String? password;
//   String? profilePic;
//   dynamic proofDocument;
//   dynamic validDocument;
//   String? messages;
//   String? notifications;
//   String? accountType;
//   String? countryCode;
//   String? rating;
//   String? socialAccType;
//   String? googleAccessToken;
//   dynamic verifyCode;
//   String? verifiedBadge;
//   dynamic dateExpiry;
//   DateTime? dateAdded;
//   String? status;

//   Data({
//     this.usersCustomersId,
//     this.oneSignalId,
//     this.usersCustomersType,
//     this.firstName,
//     this.rating,
//     this.lastName,
//     this.countryCode,
//     this.phone,
//     this.email,
//     this.password,
//     this.profilePic,
//     this.proofDocument,
//     this.validDocument,
//     this.messages,
//     this.notifications,
//     this.accountType,
//     this.socialAccType,
//     this.googleAccessToken,
//     this.verifyCode,
//     this.verifiedBadge,
//     this.dateExpiry,
//     this.dateAdded,
//     this.status,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     usersCustomersId: json["users_customers_id"],
//     oneSignalId: json["one_signal_id"],
//     usersCustomersType: json["users_customers_type"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     phone: json["phone"],
//     email: json["email"],
//     password: json["password"],
//     profilePic: json["profile_pic"],
//     countryCode: json["country_code"],
//     proofDocument: json["proof_document"],
//     rating: json["rating"],
//     validDocument: json["valid_document"],
//     messages: json["messages"],
//     notifications: json["notifications"],
//     accountType: json["account_type"],
//     socialAccType: json["social_acc_type"],
//     googleAccessToken: json["google_access_token"],
//     verifyCode: json["verify_code"],
//     verifiedBadge: json["verified_badge"],
//     dateExpiry: json["date_expiry"],
//     dateAdded: DateTime.parse(json["date_added"]),
//     status: json["status"],
//   );

//   Map<String, dynamic> toJson() => {
//     "users_customers_id": usersCustomersId,
//     "one_signal_id": oneSignalId,
//     "users_customers_type": usersCustomersType,
//     "first_name": firstName,
//     "last_name": lastName,
//     "phone": phone,
//     "email": email,
//     "password": password,
//     "profile_pic": profilePic,
//     "proof_document": proofDocument,
//     "country_code": countryCode,
//     "rating": rating,
//     "valid_document": validDocument,
//     "messages": messages,
//     "notifications": notifications,
//     "account_type": accountType,
//     "social_acc_type": socialAccType,
//     "google_access_token": googleAccessToken,
//     "verify_code": verifyCode,
//     "verified_badge": verifiedBadge,
//     "date_expiry": dateExpiry,
//     "date_added": dateAdded!.toIso8601String(),
//     "status": status,
//   };
// }
