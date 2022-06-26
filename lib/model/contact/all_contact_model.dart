// To parse this JSON data, do
//
//     final allContactModel = allContactModelFromJson(jsonString);

import 'dart:convert';

AllContactModel allContactModelFromJson(String str) => AllContactModel.fromJson(json.decode(str));

String allContactModelToJson(AllContactModel data) => json.encode(data.toJson());

class AllContactModel {
  AllContactModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Contact>? data;

  factory AllContactModel.fromJson(Map<String, dynamic> json) => AllContactModel(
    ok: json["ok"],
    message: json["message"],
    data: List<Contact>.from(json["data"].map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Contact {
  Contact({
    this.id,
    this.title,
    this.logo,
    this.value,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? logo;
  String? value;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["_id"],
    title: json["title"],
    logo: json["logo"],
    value: json["value"],
    link: json["link"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "logo": logo,
    "value": value,
    "link": link,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
