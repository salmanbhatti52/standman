import 'dart:convert';

JobsPriceModel jobsPriceModelFromJson(String str) => JobsPriceModel.fromJson(json.decode(str));

String jobsPriceModelToJson(JobsPriceModel data) => json.encode(data.toJson());

class JobsPriceModel {
  String? status;
  Data? data;

  JobsPriceModel({
    this.status,
    this.data,
  });

  factory JobsPriceModel.fromJson(Map<String, dynamic> json) => JobsPriceModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? price;
  String? serviceCharges;
  String? tax;
  String? totalPrice;

  Data({
    this.price,
    this.serviceCharges,
    this.tax,
    this.totalPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    price: json["price"],
    serviceCharges: json["service_charges"],
    tax: json["tax"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "service_charges": serviceCharges,
    "tax": tax,
    "total_price": totalPrice,
  };
}
