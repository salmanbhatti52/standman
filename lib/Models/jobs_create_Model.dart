import 'dart:convert';

JobsCreateModel jobsCreateModelFromJson(String str) => JobsCreateModel.fromJson(json.decode(str));

String jobsCreateModelToJson(JobsCreateModel data) => json.encode(data.toJson());

class JobsCreateModel {
  String? status;
  String? message;
  Data? data;

  JobsCreateModel({
    this.status,
    this.message,
    this.data,
  });

  factory JobsCreateModel.fromJson(Map<String, dynamic> json) => JobsCreateModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    // data: Data.fromJson(json["data"]),
    data : json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
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
  String? tax;
  int? totalPrice;
  String? paymentGatewaysName;
  dynamic extraTimePrice;
  dynamic extraTimeTax;
  dynamic extraTimeServiceCharges;
  dynamic extraTime;
  String? paymentStatus;
  dynamic hiredUsersCustomersId;
  dynamic dateStartJob;
  dynamic dateEndJob;
  String? status;
  DateTime? dateAdded;
  DateTime? dateModified;
  dynamic rating;
  UsersCustomersData? usersCustomersData;
  List<dynamic>? usersEmployeeData;

  Data({
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
    this.tax,
    this.totalPrice,
    this.paymentGatewaysName,
    this.extraTimePrice,
    this.extraTimeTax,
    this.extraTimeServiceCharges,
    this.extraTime,
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    tax: json["tax"],
    totalPrice: json["total_price"],
    paymentGatewaysName: json["payment_gateways_name"],
    extraTimePrice: json["extra_time_price"],
    extraTimeTax: json["extra_time_tax"],
    extraTimeServiceCharges: json["extra_time_service_charges"],
    extraTime: json["extra_time"],
    paymentStatus: json["payment_status"],
    hiredUsersCustomersId: json["hired_users_customers_id"],
    dateStartJob: json["date_start_job"],
    dateEndJob: json["date_end_job"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
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
    "tax": tax,
    "total_price": totalPrice,
    "payment_gateways_name": paymentGatewaysName,
    "extra_time_price": extraTimePrice,
    "extra_time_tax": extraTimeTax,
    "extra_time_service_charges": extraTimeServiceCharges,
    "extra_time": extraTime,
    "payment_status": paymentStatus,
    "hired_users_customers_id": hiredUsersCustomersId,
    "date_start_job": dateStartJob,
    "date_end_job": dateEndJob,
    "status": status,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "rating": rating,
    "users_customers_data": usersCustomersData!.toJson(),
    "users_employee_data": List<dynamic>.from(usersEmployeeData!.map((x) => x)),
  };
}

class UsersCustomersData {
  int? usersCustomersId;
  String oneSignalId;
  String usersCustomersType;
  String firstName;
  String lastName;
  String phone;
  String email;
  String password;
  String profilePic;
  dynamic proofDocument;
  dynamic validDocument;
  String messages;
  String notifications;
  String accountType;
  String socialAccType;
  String googleAccessToken;
  String verifyCode;
  String countryCode;
  String verifiedBadge;
  dynamic dateExpiry;
  String walletAmount;
  int jobRadius;
  String rating;
  DateTime dateAdded;
  String status;

  UsersCustomersData({
    required this.usersCustomersId,
    required this.oneSignalId,
    required this.usersCustomersType,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
    this.proofDocument,
    this.validDocument,
    required this.messages,
    required this.notifications,
    required this.accountType,
    required this.socialAccType,
    required this.googleAccessToken,
    required this.verifyCode,
    required this.countryCode,
    required this.verifiedBadge,
    this.dateExpiry,
    required this.walletAmount,
    required this.jobRadius,
    required this.rating,
    required this.dateAdded,
    required this.status,
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
    "country_code": countryCode,
    "verified_badge": verifiedBadge,
    "date_expiry": dateExpiry,
    "wallet_amount": walletAmount,
    "job_radius": jobRadius,
    "rating": rating,
    "date_added": dateAdded.toIso8601String(),
    "status": status,
  };
}
