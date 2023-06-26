// To parse this JSON data, do
//
//     final searchCustomerJobsModel = searchCustomerJobsModelFromJson(jsonString);

import 'dart:convert';

SearchCustomerJobsModel searchCustomerJobsModelFromJson(String str) => SearchCustomerJobsModel.fromJson(json.decode(str));

String searchCustomerJobsModelToJson(SearchCustomerJobsModel data) => json.encode(data.toJson());

class SearchCustomerJobsModel {
  String? status;
  List<Datum>? data;

  SearchCustomerJobsModel({
    this.status,
    this.data,
  });

  factory SearchCustomerJobsModel.fromJson(Map<String, dynamic> json) => SearchCustomerJobsModel(
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
  int? jobsId;
  int? usersCustomersId;
  String? name;
  String? image;
  String? location;
  String? longitude;
  String? lattitude;
  DateTime? startDate;
  String? startTime;
  String? endTime;
  String? description;
  String? price;
  String? serviceCharges;
  String? totalPrice;
  String? paymentGatewaysName;
  String? paymentStatus;
  dynamic hiredUsersCustomersId;
  dynamic dateStartJob;
  dynamic dateEndJob;
  String? status;
  String? dateAdded;
  DateTime? dateModified;
  dynamic rating;
  UsersCustomersData? usersCustomersData;
  List<dynamic>? usersEmployeeData;

  Datum({
    this.jobsId,
    this.usersCustomersId,
    this.name,
    this.image,
    this.location,
    this.longitude,
    this.lattitude,
    this.startDate,
    this.startTime,
    this.endTime,
    this.description,
    this.price,
    this.serviceCharges,
    this.totalPrice,
    this.paymentGatewaysName,
    this.paymentStatus,
    this.hiredUsersCustomersId,
    this.dateStartJob,
    this.dateEndJob,
    this.status,
    this.dateAdded,
    this.dateModified,
    this.rating,
    this.usersCustomersData,
    this.usersEmployeeData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobsId: json["jobs_id"],
    usersCustomersId: json["users_customers_id"],
    name: json["name"],
    image: json["image"],
    location: json["location"],
    longitude: json["longitude"],
    lattitude: json["lattitude"],
    startDate: DateTime.parse(json["start_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    description: json["description"],
    price: json["price"],
    serviceCharges: json["service_charges"],
    totalPrice: json["total_price"],
    paymentGatewaysName: json["payment_gateways_name"],
    paymentStatus: json["payment_status"],
    hiredUsersCustomersId: json["hired_users_customers_id"],
    dateStartJob: json["date_start_job"],
    dateEndJob: json["date_end_job"],
    status: json["status"],
    dateAdded: json["date_added"],
    dateModified: DateTime.parse(json["date_modified"]),
    rating: json["rating"],
    usersCustomersData: UsersCustomersData.fromJson(json["users_customers_data"]),
    usersEmployeeData: List<dynamic>.from(json["users_employee_data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "jobs_id": jobsId,
    "users_customers_id": usersCustomersId,
    "name": name,
    "image": image,
    "location": location,
    "longitude": longitude,
    "lattitude": lattitude,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "description": description,
    "price": price,
    "service_charges": serviceCharges,
    "total_price": totalPrice,
    "payment_gateways_name": paymentGatewaysName,
    "payment_status": paymentStatus,
    "hired_users_customers_id": hiredUsersCustomersId,
    "date_start_job": dateStartJob,
    "date_end_job": dateEndJob,
    "status": status,
    "date_added": dateAdded,
    "date_modified": dateModified!.toIso8601String(),
    "rating": rating,
    "users_customers_data": usersCustomersData!.toJson(),
    "users_employee_data": List<dynamic>.from(usersEmployeeData!.map((x) => x)),
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
  dynamic verifyCode;
  String? verifiedBadge;
  dynamic dateExpiry;
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
    this.verifiedBadge,
    this.dateExpiry,
    this.dateAdded,
    this.status,
  });

  factory UsersCustomersData.fromJson(Map<String, dynamic> json) => UsersCustomersData(
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
