// To parse this JSON data, do
//
//     final getOptionModel = getOptionModelFromJson(jsonString);

import 'dart:convert';

GetOptionModel getOptionModelFromJson(String str) => GetOptionModel.fromJson(json.decode(str));

String getOptionModelToJson(GetOptionModel data) => json.encode(data.toJson());

class GetOptionModel {
  GetOptionModel({
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

  factory GetOptionModel.fromJson(Map<String, dynamic> json) => GetOptionModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    success: json["success"],
    description: Description.fromJson(json["description"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "success": success,
    "description": description!.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.slug,
    this.imageUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? slug;
  String? imageUrl;
  String? type;
  String? createdAt;
  String? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    slug: json["slug"],
    imageUrl: json["imageUrl"],
    type: json["type"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "slug": slug,
    "imageUrl": imageUrl,
    "type": type,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
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
    detail: json["detail"],
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
    "summary": summary,
  };
}
