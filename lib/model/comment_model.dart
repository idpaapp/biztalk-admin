// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  CommentsModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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
    this.fullName,
    this.createDate,
    this.average,
  });

  String? fullName;
  String? createDate;
  double? average;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    fullName: json["fullName"] == null ? null : json["fullName"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    average: json["average"] == null ? null : json["average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName == null ? null : fullName,
    "createDate": createDate == null ? null : createDate,
    "average": average == null ? null : average,
  };
}
