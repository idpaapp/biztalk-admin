// To parse this JSON data, do
//
//     final newDocumentModel = newDocumentModelFromJson(jsonString);

import 'dart:convert';

NewDocumentModel newDocumentModelFromJson(String str) => NewDocumentModel.fromJson(json.decode(str));

String newDocumentModelToJson(NewDocumentModel data) => json.encode(data.toJson());

class NewDocumentModel {
  NewDocumentModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory NewDocumentModel.fromJson(Map<String, dynamic> json) => NewDocumentModel(
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.fullName,
    this.userName,
  });

  String? id;
  String? fullName;
  String? userName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    userName: json["userName"] == null ? null : json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "userName": userName == null ? null : userName,
  };
}
