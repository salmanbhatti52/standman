import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  String? status;
  List<Datum>? data;

  NotificationsModel({
    this.status,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
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
  int? notificationsId;
  int? bookingsId;
  int? sendersId;
  int? receiversId;
  String? message;
  String? dateAdded;
  DateTime? dateModified;
  String? status;
  NotificationSender? notificationSender;

  Datum({
    this.notificationsId,
    this.bookingsId,
    this.sendersId,
    this.receiversId,
    this.message,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.notificationSender,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    notificationsId: json["notifications_id"],
    bookingsId: json["bookings_id"],
    sendersId: json["senders_id"],
    receiversId: json["receivers_id"],
    message: json["message"],
    dateAdded: json["date_added"],
    dateModified: DateTime.parse(json["date_modified"]),
    status: json["status"],
    notificationSender: NotificationSender.fromJson(json["notification_sender"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications_id": notificationsId,
    "bookings_id": bookingsId,
    "senders_id": sendersId,
    "receivers_id": receiversId,
    "message": message,
    "date_added": dateAdded,
    "date_modified": dateModified!.toIso8601String(),
    "status": status,
    "notification_sender": notificationSender!.toJson(),
  };
}

class NotificationSender {
  String? firstName;
  String? lastName;
  String? profilePic;

  NotificationSender({
    this.firstName,
    this.lastName,
    this.profilePic,
  });

  factory NotificationSender.fromJson(Map<String, dynamic> json) => NotificationSender(
    firstName: json["first_name"],
    lastName: json["last_name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "profile_pic": profilePic,
  };
}
