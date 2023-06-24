// To parse this JSON data, do
//
//     final getPreviousJobsEmployeeModel = getPreviousJobsEmployeeModelFromJson(jsonString);

import 'dart:convert';

GetPreviousJobsEmployeeModel getPreviousJobsEmployeeModelFromJson(String str) => GetPreviousJobsEmployeeModel.fromJson(json.decode(str));

String getPreviousJobsEmployeeModelToJson(GetPreviousJobsEmployeeModel data) => json.encode(data.toJson());

class GetPreviousJobsEmployeeModel {
  String? status;
  List<Datum>? data;

  GetPreviousJobsEmployeeModel({
    this.status,
    this.data,
  });

  factory GetPreviousJobsEmployeeModel.fromJson(Map<String, dynamic> json) => GetPreviousJobsEmployeeModel(
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
  String? totalPrice;
  PaymentGatewaysName? paymentGatewaysName;
  String? extraTimePrice;
  String? extraTimeTax;
  String? extraTimeServiceCharges;
  String? extraTime;
  PaymentStatus? paymentStatus;
  dynamic hiredUsersCustomersId;
  dynamic dateStartJob;
  DateTime? dateEndJob;
  DatumStatus? status;
  String? dateAdded;
  DateTime? dateModified;
  dynamic rating;
  double? distance;
  UsersCustomersData? usersCustomersData;
  List<dynamic>? employeeData;
  JobsRatings? jobsRatings;

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
    this.distance,
    this.usersCustomersData,
    this.employeeData,
    this.jobsRatings,
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
    tax: json["tax"],
    totalPrice: json["total_price"],
    paymentGatewaysName: paymentGatewaysNameValues.map[json["payment_gateways_name"]]!,
    extraTimePrice: json["extra_time_price"],
    extraTimeTax: json["extra_time_tax"],
    extraTimeServiceCharges: json["extra_time_service_charges"],
    extraTime: json["extra_time"],
    paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
    hiredUsersCustomersId: json["hired_users_customers_id"],
    dateStartJob: json["date_start_job"],
    dateEndJob: json["date_end_job"] == null ? null : DateTime.parse(json["date_end_job"]),
    status: datumStatusValues.map[json["status"]]!,
    dateAdded: json["date_added"],
    dateModified: DateTime.parse(json["date_modified"]),
    rating: json["rating"],
    distance: json["distance"]?.toDouble(),
    usersCustomersData: UsersCustomersData.fromJson(json["users_customers_data"]),
    employeeData: List<dynamic>.from(json["employee_data"].map((x) => x)),
    jobsRatings: json["jobs_ratings"] == null ? null : JobsRatings.fromJson(json["jobs_ratings"]),
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
    "payment_gateways_name": paymentGatewaysNameValues.reverse[paymentGatewaysName],
    "extra_time_price": extraTimePrice,
    "extra_time_tax": extraTimeTax,
    "extra_time_service_charges": extraTimeServiceCharges,
    "extra_time": extraTime,
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "hired_users_customers_id": hiredUsersCustomersId,
    "date_start_job": dateStartJob,
    "date_end_job": dateEndJob?.toIso8601String(),
    "status": datumStatusValues.reverse[status],
    "date_added": dateAdded,
    "date_modified": dateModified!.toIso8601String(),
    "rating": rating,
    "distance": distance,
    "users_customers_data": usersCustomersData!.toJson(),
    "employee_data": List<dynamic>.from(employeeData!.map((x) => x)),
    "jobs_ratings": jobsRatings?.toJson(),
  };
}

class JobsRatings {
  int? jobsRatingsId;
  int? usersCustomersId;
  int? employeeUsersCustomersId;
  int? jobsId;
  String? rating;
  String? comment;
  DateTime? dateAdded;
  JobsRatingsStatus? status;

  JobsRatings({
    this.jobsRatingsId,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
    this.rating,
    this.comment,
    this.dateAdded,
    this.status,
  });

  factory JobsRatings.fromJson(Map<String, dynamic> json) => JobsRatings(
    jobsRatingsId: json["jobs_ratings_id"],
    usersCustomersId: json["users_customers_id"],
    employeeUsersCustomersId: json["employee_users_customers_id"],
    jobsId: json["jobs_id"],
    rating: json["rating"],
    comment: json["comment"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: jobsRatingsStatusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "jobs_ratings_id": jobsRatingsId,
    "users_customers_id": usersCustomersId,
    "employee_users_customers_id": employeeUsersCustomersId,
    "jobs_id": jobsId,
    "rating": rating,
    "comment": comment,
    "date_added": dateAdded!.toIso8601String(),
    "status": jobsRatingsStatusValues.reverse[status],
  };
}

enum JobsRatingsStatus { ACTIVE }

final jobsRatingsStatusValues = EnumValues({
  "Active": JobsRatingsStatus.ACTIVE
});

enum PaymentGatewaysName { G_PAY }

final paymentGatewaysNameValues = EnumValues({
  "GPay": PaymentGatewaysName.G_PAY
});

enum PaymentStatus { PAID }

final paymentStatusValues = EnumValues({
  "Paid": PaymentStatus.PAID
});

enum DatumStatus { COMPLETED }

final datumStatusValues = EnumValues({
  "Completed": DatumStatus.COMPLETED
});

class UsersCustomersData {
  int? usersCustomersId;
  String? oneSignalId;
  FirstName usersCustomersType;
  FirstName firstName;
  LastName lastName;
  String phone;
  Email email;
  Password password;
  ProfilePic profilePic;
  dynamic proofDocument;
  dynamic validDocument;
  Messages messages;
  Messages notifications;
  AccountType accountType;
  SocialAccType socialAccType;
  String googleAccessToken;
  dynamic verifyCode;
  CountryCode countryCode;
  VerifiedBadge verifiedBadge;
  dynamic dateExpiry;
  String walletAmount;
  String rating;
  DateTime dateAdded;
  JobsRatingsStatus status;

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
    this.verifyCode,
    required this.countryCode,
    required this.verifiedBadge,
    this.dateExpiry,
    required this.walletAmount,
    required this.rating,
    required this.dateAdded,
    required this.status,
  });

  factory UsersCustomersData.fromJson(Map<String, dynamic> json) => UsersCustomersData(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
    usersCustomersType: firstNameValues.map[json["users_customers_type"]]!,
    firstName: firstNameValues.map[json["first_name"]]!,
    lastName: lastNameValues.map[json["last_name"]]!,
    phone: json["phone"],
    email: emailValues.map[json["email"]]!,
    password: passwordValues.map[json["password"]]!,
    profilePic: profilePicValues.map[json["profile_pic"]]!,
    proofDocument: json["proof_document"],
    validDocument: json["valid_document"],
    messages: messagesValues.map[json["messages"]]!,
    notifications: messagesValues.map[json["notifications"]]!,
    accountType: accountTypeValues.map[json["account_type"]]!,
    socialAccType: socialAccTypeValues.map[json["social_acc_type"]]!,
    googleAccessToken: json["google_access_token"],
    verifyCode: json["verify_code"],
    countryCode: countryCodeValues.map[json["country_code"]]!,
    verifiedBadge: verifiedBadgeValues.map[json["verified_badge"]]!,
    dateExpiry: json["date_expiry"],
    walletAmount: json["wallet_amount"],
    rating: json["rating"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: jobsRatingsStatusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "users_customers_id": usersCustomersId,
    "one_signal_id": oneSignalId,
    "users_customers_type": firstNameValues.reverse[usersCustomersType],
    "first_name": firstNameValues.reverse[firstName],
    "last_name": lastNameValues.reverse[lastName],
    "phone": phone,
    "email": emailValues.reverse[email],
    "password": passwordValues.reverse[password],
    "profile_pic": profilePicValues.reverse[profilePic],
    "proof_document": proofDocument,
    "valid_document": validDocument,
    "messages": messagesValues.reverse[messages],
    "notifications": messagesValues.reverse[notifications],
    "account_type": accountTypeValues.reverse[accountType],
    "social_acc_type": socialAccTypeValues.reverse[socialAccType],
    "google_access_token": googleAccessToken,
    "verify_code": verifyCode,
    "country_code": countryCodeValues.reverse[countryCode],
    "verified_badge": verifiedBadgeValues.reverse[verifiedBadge],
    "date_expiry": dateExpiry,
    "wallet_amount": walletAmount,
    "rating": rating,
    "date_added": dateAdded.toIso8601String(),
    "status": jobsRatingsStatusValues.reverse[status],
  };
}

enum AccountType { SIGNUP_WITH_APP }

final accountTypeValues = EnumValues({
  "SignupWithApp": AccountType.SIGNUP_WITH_APP
});

enum CountryCode { PK }

final countryCodeValues = EnumValues({
  "PK": CountryCode.PK
});

enum Email { CUSTOMER_GMAIL_COM, MUGHEESMALIK101_GMAIL_COM }

final emailValues = EnumValues({
  "customer@gmail.com": Email.CUSTOMER_GMAIL_COM,
  "mugheesmalik101@gmail.com": Email.MUGHEESMALIK101_GMAIL_COM
});

enum FirstName { CUSTOMER, MUGHEES }

final firstNameValues = EnumValues({
  "Customer": FirstName.CUSTOMER,
  "Mughees": FirstName.MUGHEES
});

enum LastName { SIDE, MALIK }

final lastNameValues = EnumValues({
  "Malik": LastName.MALIK,
  "Side": LastName.SIDE
});

enum Messages { YES }

final messagesValues = EnumValues({
  "Yes": Messages.YES
});

enum Password { EBC2_D1_B00_BA2_D4687_EC8_D8_DBF0_E0_C3_AB, C0_A18_C5_A5_A29_A31_A6_BA178_F430_C24_A2_A }

final passwordValues = EnumValues({
  "c0a18c5a5a29a31a6ba178f430c24a2a": Password.C0_A18_C5_A5_A29_A31_A6_BA178_F430_C24_A2_A,
  "ebc2d1b00ba2d4687ec8d8dbf0e0c3ab": Password.EBC2_D1_B00_BA2_D4687_EC8_D8_DBF0_E0_C3_AB
});

enum ProfilePic { UPLOADS_USERS_CUSTOMERS_1686375344_JPEG, UPLOADS_USERS_CUSTOMERS_1686566787_JPEG }

final profilePicValues = EnumValues({
  "uploads/users_customers/1686375344.jpeg": ProfilePic.UPLOADS_USERS_CUSTOMERS_1686375344_JPEG,
  "uploads/users_customers/1686566787.jpeg": ProfilePic.UPLOADS_USERS_CUSTOMERS_1686566787_JPEG
});

enum SocialAccType { NONE }

final socialAccTypeValues = EnumValues({
  "None": SocialAccType.NONE
});

enum VerifiedBadge { NO }

final verifiedBadgeValues = EnumValues({
  "No": VerifiedBadge.NO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
