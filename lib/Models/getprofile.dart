// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

GetProfile getProfileFromJson(String str) => GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
    String? status;
    Data? data;

    GetProfile({
        this.status,
        this.data,
    });

    factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
    };
}

class Data {
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

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
