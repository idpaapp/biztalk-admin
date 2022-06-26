// To parse this JSON data, do
//
//     final singleReportModel = singleReportModelFromJson(jsonString);

import 'dart:convert';

SingleReportModel singleReportModelFromJson(String str) => SingleReportModel.fromJson(json.decode(str));

String singleReportModelToJson(SingleReportModel data) => json.encode(data.toJson());

class SingleReportModel {
  SingleReportModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory SingleReportModel.fromJson(Map<String, dynamic> json) => SingleReportModel(
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
    this.senderType,
    this.sender,
    this.msg,
    this.date,
    this.time,
  });

  String? id;
  String? senderType;
  Sender? sender;
  String? msg;
  String? date;
  String? time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    senderType: json["senderType"],
    sender: Sender.fromJson(json["sender"]),
    msg: json["msg"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "senderType": senderType,
    "sender": sender!.toJson(),
    "msg": msg,
    "date": date,
    "time": time,
  };
}

class Sender {
  Sender({
    this.id,
    this.fullName,
    this.profileImageUrl,
  });

  String? id;
  String? fullName;
  String? profileImageUrl;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    fullName: json["fullName"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "profileImageUrl": profileImageUrl,
  };
}
