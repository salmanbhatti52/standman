// To parse this JSON data, do
//
//     final jobsCreateModel = jobsCreateModelFromJson(jsonString);

import 'dart:convert';

JobsCreateModel jobsCreateModelFromJson(String str) =>
    JobsCreateModel.fromJson(json.decode(str));

String jobsCreateModelToJson(JobsCreateModel data) =>
    json.encode(data.toJson());

class JobsCreateModel {
  String? status;
  String? message;
  Data? data;

  JobsCreateModel({
    this.status,
    this.message,
    this.data,
  });

  factory JobsCreateModel.fromJson(Map<String, dynamic> json) =>
      JobsCreateModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? jobsId;
  int? usersCustomersId;
  String? location;
  String? lattitude;
  String? longitude;
  String? image;
  String? name;
  DateTime? jobDate;
  String? startTime;
  String? endTime;
  String? description;
  String? price;
  String? serviceCharges;
  String? tax;
  String? totalPrice;
  dynamic extraTimePrice;
  dynamic extraTimeServiceCharges;
  dynamic extraTimeTax;
  dynamic extraTime;
  String? paymentStatus;
  int? paymentGatewaysId;
  dynamic hiredUsersCustomersId;
  dynamic dateStartJob;
  dynamic dateEndJob;
  dynamic rating;
  DateTime? dateAdded;
  dynamic dateModified;
  String? status;
  UsersCustomersData? usersCustomersData;

  Data({
    this.jobsId,
    this.usersCustomersId,
    this.location,
    this.lattitude,
    this.longitude,
    this.image,
    this.name,
    this.jobDate,
    this.startTime,
    this.endTime,
    this.description,
    this.price,
    this.serviceCharges,
    this.tax,
    this.totalPrice,
    this.extraTimePrice,
    this.extraTimeServiceCharges,
    this.extraTimeTax,
    this.extraTime,
    this.paymentStatus,
    this.paymentGatewaysId,
    this.hiredUsersCustomersId,
    this.dateStartJob,
    this.dateEndJob,
    this.rating,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.usersCustomersData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        jobsId: json["jobs_id"],
        usersCustomersId: json["users_customers_id"],
        location: json["location"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        image: json["image"],
        name: json["name"],
        // String? jobDateStr = json["job_date"];
        jobDate: json["job_date"] != null
            ? DateTime.parse(json["job_date"])
            : DateTime.now(),
        // jobDate: DateTime.parse(json["job_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        description: json["description"],
        price: json["price"],
        serviceCharges: json["service_charges"],
        tax: json["tax"],
        totalPrice: json["total_price"],
        extraTimePrice: json["extra_time_price"],
        extraTimeServiceCharges: json["extra_time_service_charges"],
        extraTimeTax: json["extra_time_tax"],
        extraTime: json["extra_time"],
        paymentStatus: json["payment_status"],
        paymentGatewaysId: json["payment_gateways_id"],
        hiredUsersCustomersId: json["hired_users_customers_id"],
        dateStartJob: json["date_start_job"],
        dateEndJob: json["date_end_job"],
        rating: json["rating"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
        usersCustomersData:
            UsersCustomersData.fromJson(json["users_customers_data"]),
      );

  Map<String, dynamic> toJson() => {
        "jobs_id": jobsId,
        "users_customers_id": usersCustomersId,
        "location": location,
        "lattitude": lattitude,
        "longitude": longitude,
        "image": image,
        "name": name,
        "job_date":
            "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
        "price": price,
        "service_charges": serviceCharges,
        "tax": tax,
        "total_price": totalPrice,
        "extra_time_price": extraTimePrice,
        "extra_time_service_charges": extraTimeServiceCharges,
        "extra_time_tax": extraTimeTax,
        "extra_time": extraTime,
        "payment_status": paymentStatus,
        "payment_gateways_id": paymentGatewaysId,
        "hired_users_customers_id": hiredUsersCustomersId,
        "date_start_job": dateStartJob,
        "date_end_job": dateEndJob,
        "rating": rating,
        "date_added": dateAdded!.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
        "users_customers_data": usersCustomersData!.toJson(),
      };
}

class UsersCustomersData {
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
  String? accountVerified;
  String? countryCode;
  String? verifiedBadge;
  dynamic dateExpiry;
  String? walletAmount;
  int? jobRadius;
  String? rating;
  DateTime? dateAdded;
  String? status;

  UsersCustomersData({
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
    this.accountVerified,
    this.countryCode,
    this.verifiedBadge,
    this.dateExpiry,
    this.walletAmount,
    this.jobRadius,
    this.rating,
    this.dateAdded,
    this.status,
  });

  factory UsersCustomersData.fromJson(Map<String, dynamic> json) =>
      UsersCustomersData(
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
        accountVerified: json["account_verified"],
        countryCode: json["country_code"],
        verifiedBadge: json["verified_badge"],
        dateExpiry: json["date_expiry"],
        walletAmount: json["wallet_amount"],
        jobRadius: json["job_radius"],
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
        "account_verified": accountVerified,
        "country_code": countryCode,
        "verified_badge": verifiedBadge,
        "date_expiry": dateExpiry,
        "wallet_amount": walletAmount,
        "job_radius": jobRadius,
        "rating": rating,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
      };
}
