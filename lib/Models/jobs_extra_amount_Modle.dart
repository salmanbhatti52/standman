// To parse this JSON data, do
//
//     final jobsExtraAmount = jobsExtraAmountFromJson(jsonString);

import 'dart:convert';

JobsExtraAmount jobsExtraAmountFromJson(String str) => JobsExtraAmount.fromJson(json.decode(str));

String jobsExtraAmountToJson(JobsExtraAmount data) => json.encode(data.toJson());

class JobsExtraAmount {
  String? status;
  Message? message;

  JobsExtraAmount({
    this.status,
    this.message,
  });

  factory JobsExtraAmount.fromJson(Map<String, dynamic> json) => JobsExtraAmount(
    status: json["status"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message!.toJson(),
  };
}

class Message {
  String? payment;
  String? previousAmount;
  String? extraAmount;
  String? serviceCharges;
  String? tax;
  String? bookedTime;
  String? bookedClose;
  int? extraTime;
  int? usersCustomersId;
  int? employeeUsersCustomersId;
  int? jobsId;

  Message({
    this.payment,
    this.previousAmount,
    this.extraAmount,
    this.serviceCharges,
    this.tax,
    this.bookedTime,
    this.bookedClose,
    this.extraTime,
    this.usersCustomersId,
    this.employeeUsersCustomersId,
    this.jobsId,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    payment: json["payment"],
    previousAmount: json["previous_amount"],
    extraAmount: json["extra_amount"],
    serviceCharges: json["service_charges"],
    tax: json["tax"],
    bookedTime: json["booked_time"],
    bookedClose: json["booked_close"],
    extraTime: json["extra_time"],
    usersCustomersId: json["users_customers_id"],
    employeeUsersCustomersId: json["employee_users_customers_id"],
    jobsId: json["jobs_id"],
  );

  Map<String, dynamic> toJson() => {
    "payment": payment,
    "previous_amount": previousAmount,
    "extra_amount": extraAmount,
    "service_charges": serviceCharges,
    "tax": tax,
    "booked_time": bookedTime,
    "booked_close": bookedClose,
    "extra_time": extraTime,
    "users_customers_id": usersCustomersId,
    "employee_users_customers_id": employeeUsersCustomersId,
    "jobs_id": jobsId,
  };
}
