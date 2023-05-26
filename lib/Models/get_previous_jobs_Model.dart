import 'dart:convert';

GetPreviousJobsModel getPreviousJobsModelFromJson(String str) => GetPreviousJobsModel.fromJson(json.decode(str));

String getPreviousJobsModelToJson(GetPreviousJobsModel data) => json.encode(data.toJson());

class GetPreviousJobsModel {
  GetPreviousJobsModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory GetPreviousJobsModel.fromJson(Map<String, dynamic> json) => GetPreviousJobsModel(
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
  });

  int? jobsId;
  int? usersCustomersId;
  String? name;
  String? image;
  String? location;
  String? longitude;
  String? lattitude;
  DateTime? startDate;
  String? startTime;
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
  DateTime? dateAdded;
  DateTime? dateModified;
  dynamic rating;

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
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: DateTime.parse(json["date_modified"]),
    rating: json["rating"],
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
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "rating": rating,
  };
}
