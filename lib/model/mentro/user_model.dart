// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        ok: json["ok"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.profile,
    this.requests,
  });

  Profile? profile;
  List<Request>? requests;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profile: Profile.fromJson(json["profile"]),
        requests: List<Request>.from(
            json["requests"].map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile!.toJson(),
        "requests": List<dynamic>.from(requests!.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
    this.id,
    this.fullName,
    this.userName,
    this.phone,
    this.profile,
    this.cashOutPending,
    this.newAccount,
    this.isConfirmDocs,
    this.status,
    this.statusTitle,
  });

  String? id;
  String? fullName;
  String? userName;
  String? phone;
  dynamic profile;
  String? cashOutPending;
  String? status;
  String? statusTitle;
  bool? newAccount;
  bool? isConfirmDocs;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        statusTitle: json["statusTitle"],
        status: json["status"],
        fullName: json["fullName"],
        userName: json["userName"],
        phone: json["phone"],
        profile: json["profile"],
        cashOutPending: json["cashOutPending"],
        newAccount: json["newAccount"],
        isConfirmDocs: json["isConfirmDocs"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "statusTitle": statusTitle,
        "fullName": fullName,
        "userName": userName,
        "phone": phone,
        "profile": profile,
        "cashOutPending": cashOutPending,
        "newAccount": newAccount,
        "isConfirmDocs": isConfirmDocs,
      };
}

class Request {
  Request({
    this.id,
    this.subject,
    this.requestOwnerName,
    this.description,
    this.status,
    this.statusTitle,
    this.createdAt,
    this.date,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? subject;
  String? requestOwnerName;
  String? description;
  String? status;
  String? statusTitle;
  String? createdAt;
  dynamic date;
  dynamic startTime;
  dynamic endTime;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["_id"],
        subject: json["subject"],
        requestOwnerName: json["requestOwnerName"],
        description: json["description"],
        status: json["status"],
        statusTitle: json["statusTitle"],
        createdAt: json["createdAt"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject,
        "requestOwnerName": requestOwnerName,
        "description": description,
        "status": status,
        "statusTitle": statusTitle,
        "createdAt": createdAt,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
      };
}
