// To parse this JSON data, do
//
//     final mentorTvsModel = mentorTvsModelFromJson(jsonString);

import 'dart:convert';

MentorTvsModel mentorTvsModelFromJson(String str) => MentorTvsModel.fromJson(json.decode(str));

String mentorTvsModelToJson(MentorTvsModel data) => json.encode(data.toJson());

class MentorTvsModel {
  MentorTvsModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory MentorTvsModel.fromJson(Map<String, dynamic> json) => MentorTvsModel(
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
    this.rePublish,
    this.rePublishTitle,
    this.status,
    this.statusTitle,
    this.tvTitle,
    this.tvName,
    this.tvLink,
    this.tvLogo,
  });

  String? id;
  String? userName;
  bool? rePublish;
  String? rePublishTitle;
  bool? status;
  String? statusTitle;
  String? tvTitle;
  String? tvName;
  String? tvLink;
  String? tvLogo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userName: json["userName"],
    rePublish: json["rePublish"],
    rePublishTitle: json["rePublishTitle"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    tvTitle: json["tvTitle"],
    tvName: json["tvName"],
    tvLink: json["tvLink"],
    tvLogo: json["tvLogo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "rePublish": rePublish,
    "rePublishTitle": rePublishTitle,
    "status": status,
    "statusTitle": statusTitle,
    "tvTitle": tvTitle,
    "tvName": tvName,
    "tvLink": tvLink,
    "tvLogo": tvLogo,
  };
}
