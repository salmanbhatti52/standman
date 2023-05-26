import 'dart:convert';

SystemSettingsModel systemSettingsModelFromJson(String str) => SystemSettingsModel.fromJson(json.decode(str));

String systemSettingsModelToJson(SystemSettingsModel data) => json.encode(data.toJson());

class SystemSettingsModel {
  String? status;
  List<Datum>? data;

  SystemSettingsModel({
    this.status,
    this.data,
  });

  factory SystemSettingsModel.fromJson(Map<String, dynamic> json) => SystemSettingsModel(
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
  int? systemSettingsId;
  String? type;
  String? description;

  Datum({
    this.systemSettingsId,
    this.type,
    this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    systemSettingsId: json["system_settings_id"],
    type: json["type"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "system_settings_id": systemSettingsId,
    "type": type,
    "description": description,
  };
}
