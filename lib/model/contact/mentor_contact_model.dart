// To parse this JSON data, do
//
//     final mentorContactModel = mentorContactModelFromJson(jsonString);

import 'dart:convert';

MentorContactModel mentorContactModelFromJson(String str) => MentorContactModel.fromJson(json.decode(str));

String mentorContactModelToJson(MentorContactModel data) => json.encode(data.toJson());

class MentorContactModel {
  MentorContactModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory MentorContactModel.fromJson(Map<String, dynamic> json) => MentorContactModel(
    ok: json["ok"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userName,
    this.status,
    this.statusTitle,
    this.contactTitle,
    this.contactName,
    this.contactLink,
    this.contactLogo,
  });

  String? id;
  String? userName;
  bool? status;
  String? statusTitle;
  String? contactTitle;
  String? contactName;
  String? contactLink;
  String? contactLogo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userName: json["userName"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    contactTitle: json["contactTitle"],
    contactName: json["contactName"],
    contactLink: json["contactLink"],
    contactLogo: json["contactLogo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "status": status,
    "statusTitle": statusTitle,
    "contactTitle": contactTitle,
    "contactName": contactName,
    "contactLink": contactLink,
    "contactLogo": contactLogo,
  };
}
