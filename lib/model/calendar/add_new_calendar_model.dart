// To parse this JSON data, do
//
//     final addNewCalendarModel = addNewCalendarModelFromJson(jsonString);

import 'dart:convert';

AddNewCalendarModel addNewCalendarModelFromJson(String str) => AddNewCalendarModel.fromJson(json.decode(str));

String addNewCalendarModelToJson(AddNewCalendarModel data) => json.encode(data.toJson());

class AddNewCalendarModel {
  AddNewCalendarModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory AddNewCalendarModel.fromJson(Map<String, dynamic> json) => AddNewCalendarModel(
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
    this.date,
    this.mentor,
    this.time,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? date;
  String? mentor;
  Time? time;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    date: json["date"],
    mentor: json["mentor"],
    time: Time.fromJson(json["time"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "mentor": mentor,
    "time": time!.toJson(),
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class Time {
  Time({
    this.price,
    this.inReservation,
    this.formattedPrice,
    this.status,
    this.start,
    this.end,
  });

  int? price;
  dynamic inReservation;
  String? formattedPrice;
  String? status;
  String? start;
  String? end;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    price: json["price"],
    inReservation: json["inReservation"],
    formattedPrice: json["formattedPrice"],
    status: json["status"],
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "inReservation": inReservation,
    "formattedPrice": formattedPrice,
    "status": status,
    "start": start,
    "end": end,
  };
}
