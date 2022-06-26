// To parse this JSON data, do
//
//     final mentorCalendarModel = mentorCalendarModelFromJson(jsonString);

import 'dart:convert';

MentorCalendarModel mentorCalendarModelFromJson(String str) => MentorCalendarModel.fromJson(json.decode(str));

String mentorCalendarModelToJson(MentorCalendarModel data) => json.encode(data.toJson());

class MentorCalendarModel {
  MentorCalendarModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<SingleDate>? data;

  factory MentorCalendarModel.fromJson(Map<String, dynamic> json) => MentorCalendarModel(
    ok: json["ok"],
    message: json["message"],
    data: List<SingleDate>.from(json["data"].map((x) => SingleDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleDate {
  SingleDate({
    this.id,
    this.date,
    this.start,
    this.end,
    this.formattedPrice,
    this.price,
    this.status,
    this.statusTitle,
  });

  String? id;
  String? date;
  String? start;
  String? end;
  String? formattedPrice;
  int? price;
  String? status;
  String? statusTitle;

  factory SingleDate.fromJson(Map<String, dynamic> json) => SingleDate(
    id: json["_id"],
    date: json["date"],
    start: json["start"],
    end: json["end"],
    formattedPrice: json["formattedPrice"],
    price: json["price"],
    status: json["status"],
    statusTitle: json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date":date,
    "start": start,
    "end": end,
    "formattedPrice": formattedPrice,
    "price": price,
    "status": status,
    "statusTitle": statusTitle,
  };
}
