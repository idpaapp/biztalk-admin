// To parse this JSON data, do
//
//     final allBankModel = allBankModelFromJson(jsonString);

import 'dart:convert';

AllBankModel allBankModelFromJson(String str) => AllBankModel.fromJson(json.decode(str));

String allBankModelToJson(AllBankModel data) => json.encode(data.toJson());

class AllBankModel {
  AllBankModel({
    this.message,
    this.data,
    this.status,
    this.success,
    this.description,
  });

  String? message;
  List<Datum>? data;
  int? status;
  bool? success;
  Description? description;

  factory AllBankModel.fromJson(Map<String, dynamic> json) => AllBankModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    success: json["success"] == null ? null : json["success"],
    description: json["description"] == null ? null : Description.fromJson(json["description"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status == null ? null : status,
    "success": success == null ? null : success,
    "description": description == null ? null : description!.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.slug,
  });

  String? id;
  String? title;
  String? slug;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
  };
}

class Description {
  Description({
    this.detail,
    this.summary,
  });

  String? detail;
  String? summary;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    detail: json["detail"] == null ? null : json["detail"],
    summary: json["summary"] == null ? null : json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail == null ? null : detail,
    "summary": summary == null ? null : summary,
  };
}
