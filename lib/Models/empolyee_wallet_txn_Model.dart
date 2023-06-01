// To parse this JSON data, do
//
//     final employeewalletTxnModel = employeewalletTxnModelFromJson(jsonString);

import 'dart:convert';

EmployeewalletTxnModel employeewalletTxnModelFromJson(String str) => EmployeewalletTxnModel.fromJson(json.decode(str));

String employeewalletTxnModelToJson(EmployeewalletTxnModel data) => json.encode(data.toJson());

class EmployeewalletTxnModel {
  String? status;
  Data? data;

  EmployeewalletTxnModel({
    this.status,
    this.data,
  });

  factory EmployeewalletTxnModel.fromJson(Map<String, dynamic> json) => EmployeewalletTxnModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? earning;
  String? withdraw;
  List<TransactionHistory>? transactionHistory;

  Data({
   this.earning,
   this.withdraw,
   this.transactionHistory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    earning: json["earning"],
    withdraw: json["withdraw"],
    transactionHistory: List<TransactionHistory>.from(json["transaction_history"].map((x) => TransactionHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "earning": earning,
    "withdraw": withdraw,
    "transaction_history": List<dynamic>.from(transactionHistory!.map((x) => x.toJson())),
  };
}

class TransactionHistory {
  int? walletTxnsId;
  int? usersCustomersId;
  int? employeeUsersCustomersId;
  int? jobsId;
  String? txnType;
  String? totalAmount;
  String? tax;
  String? serviceCharges;
  String? standmanAmount;
  DateTime? dateTime;
  String? dateAdded;
  dynamic dateModified;
  String? status;
  String? narration;
  UserData? userData;
  TxnDetail? txnDetail;

  TransactionHistory({
    this.walletTxnsId,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
    this.txnType,
    this.totalAmount,
    this.tax,
    this.serviceCharges,
    this.standmanAmount,
    this.dateTime,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.narration,
    this.userData,
    this.txnDetail,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
    walletTxnsId: json["wallet_txns_id"],
    usersCustomersId: json["users_customers_id"],
    employeeUsersCustomersId: json["employee_users_customers_id"],
    jobsId: json["jobs_id"],
    txnType: json["txn_type"],
    totalAmount: json["total_amount"],
    tax: json["tax"],
    serviceCharges: json["service_charges"],
    standmanAmount: json["standman_amount"],
    dateTime: DateTime.parse(json["date_time"]),
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
    status: json["status"],
    narration: json["narration"],
    userData: UserData.fromJson(json["user_data"]),
    txnDetail: TxnDetail.fromJson(json["txn_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "wallet_txns_id": walletTxnsId,
    "users_customers_id": usersCustomersId,
    "employee_users_customers_id": employeeUsersCustomersId,
    "jobs_id": jobsId,
    "txn_type": txnType,
    "total_amount": totalAmount,
    "tax": tax,
    "service_charges": serviceCharges,
    "standman_amount": standmanAmount,
    "date_time": dateTime!.toIso8601String(),
    "date_added": dateAdded,
    "date_modified": dateModified,
    "status": status,
    "narration": narration,
    "user_data": userData!.toJson(),
    "txn_detail": txnDetail!.toJson(),
  };
}

class TxnDetail {
  String? userName;
  String? date;
  String? totalPrice;
  String? previousPrice;
  String?  extraServiceCharges;
  String? bookedTime;
  String? bookedClose;
  String?  extraPrice;
  String?  extraTime;

  TxnDetail({
    this.userName,
    this.date,
    this.totalPrice,
    this.previousPrice,
    this.extraServiceCharges,
    this.bookedTime,
    this.bookedClose,
    this.extraPrice,
    this.extraTime,
  });

  factory TxnDetail.fromJson(Map<String, dynamic> json) => TxnDetail(
    userName: json["user_name"],
    date: json["date"],
    totalPrice: json["total_price"],
    previousPrice: json["previous_price"],
    extraServiceCharges: json["extra_service_charges"],
    bookedTime: json["booked_time"],
    bookedClose: json["booked_close"],
    extraPrice: json["extra_price"],
    extraTime: json["extra_time"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "date": date,
    "total_price": totalPrice,
    "previous_price": previousPrice,
    "extra_service_charges": extraServiceCharges,
    "booked_time": bookedTime,
    "booked_close": bookedClose,
    "extra_price": extraPrice,
    "extra_time": extraTime,
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
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}
