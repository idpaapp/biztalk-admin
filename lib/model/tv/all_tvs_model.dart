// To parse this JSON data, do
//
//     final allTvsModel = allTvsModelFromJson(jsonString);

import 'dart:convert';

AllTvsModel allTvsModelFromJson(String str) => AllTvsModel.fromJson(json.decode(str));

String allTvsModelToJson(AllTvsModel data) => json.encode(data.toJson());

class AllTvsModel {
  AllTvsModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Tvs>? data;

  factory AllTvsModel.fromJson(Map<String, dynamic> json) => AllTvsModel(
    ok: json["ok"],
    message: json["message"],
    data: List<Tvs>.from(json["data"].map((x) => Tvs.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Tvs {
  Tvs({
    this.id,
    this.logo,
    this.title,
    this.value,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? logo;
  String? title;
  String? value;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory Tvs.fromJson(Map<String, dynamic> json) => Tvs(
    id: json["_id"],
    logo: json["logo"],
    title: json["title"],
    value: json["value"],
    link: json["link"],
    createdAt:json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "logo": logo,
    "title": title,
    "value": value,
    "link": link,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v == null ? null : v,
  };
}
