// To parse this JSON data, do
//
//     final createOffCodeModel = createOffCodeModelFromJson(jsonString);

import 'dart:convert';

CreateOffCodeModel createOffCodeModelFromJson(String str) => CreateOffCodeModel.fromJson(json.decode(str));

String createOffCodeModelToJson(CreateOffCodeModel data) => json.encode(data.toJson());

class CreateOffCodeModel {
  CreateOffCodeModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory CreateOffCodeModel.fromJson(Map<String, dynamic> json) => CreateOffCodeModel(
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
    this.title,
    this.code,
    this.discountPercent,
    this.topPrice,
    this.discountPrice,
    this.useForType,
    this.useForId,
    this.used,
    this.startDate,
    this.expireDate,
    this.id,
    this.usedIds,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? title;
  String? code;
  int? discountPercent;
  int? topPrice;
  int? discountPrice;
  String? useForType;
  String? useForId;
  bool? used;
  String? startDate;
  String? expireDate;
  String? id;
  List<dynamic>? usedIds;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    code: json["code"],
    discountPercent: json["discountPercent"],
    topPrice: json["topPrice"],
    discountPrice: json["discountPrice"],
    useForType: json["useForType"],
    useForId: json["useForId"],
    used: json["used"],
    startDate: json["startDate"],
    expireDate: json["expireDate"],
    id: json["_id"],
    usedIds: List<dynamic>.from(json["usedIds"].map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt:json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "code": code,
    "discountPercent": discountPercent,
    "topPrice": topPrice,
    "discountPrice": discountPrice,
    "useForType": useForType,
    "useForId": useForId,
    "used": used,
    "startDate": startDate,
    "expireDate": expireDate,
    "_id": id,
    "usedIds": List<dynamic>.from(usedIds!.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
