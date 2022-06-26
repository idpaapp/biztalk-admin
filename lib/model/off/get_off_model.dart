// To parse this JSON data, do
//
//     final getOffModel = getOffModelFromJson(jsonString);

import 'dart:convert';

GetOffModel getOffModelFromJson(String str) => GetOffModel.fromJson(json.decode(str));

String getOffModelToJson(GetOffModel data) => json.encode(data.toJson());

class GetOffModel {
  GetOffModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<SingleOff>? data;

  factory GetOffModel.fromJson(Map<String, dynamic> json) => GetOffModel(
    ok: json["ok"],
    message: json["message"],
    data: List<SingleOff>.from(json["data"].map((x) => SingleOff.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleOff {
  SingleOff({
    this.id,
    this.title,
    this.code,
    this.discountPercent,
    this.topPrice,
    this.discountPrice,
    this.used,
    this.useForType,
    this.useForTypeTitle,
    this.useFor,
    this.startDate,
    this.expireDate,
  });

  String? id;
  String? title;
  String? code;
  int? discountPercent;
  int? topPrice;
  int? discountPrice;
  bool? used;
  String? useForType;
  String? useForTypeTitle;
  UseFor? useFor;
  String? startDate;
  String? expireDate;

  factory SingleOff.fromJson(Map<String, dynamic> json) => SingleOff(
    id: json["_id"],
    title: json["title"],
    code: json["code"],
    discountPercent: json["discountPercent"] == null ? null : json["discountPercent"],
    topPrice: json["topPrice"] == null ? null : json["topPrice"],
    discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
    used: json["used"],
    useForType: json["useForType"],
    useForTypeTitle: json["useForTypeTitle"],
    useFor: json["useFor"] == null ? null : UseFor.fromJson(json["useFor"]),
    startDate: json["startDate"],
    expireDate: json["expireDate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "code": code,
    "discountPercent": discountPercent == null ? null : discountPercent,
    "topPrice": topPrice == null ? null : topPrice,
    "discountPrice": discountPrice == null ? null : discountPrice,
    "used": used,
    "useForType": useForType,
    "useForTypeTitle": useForTypeTitle,
    "useFor": useFor == null ? null : useFor!.toJson(),
    "startDate": startDate,
    "expireDate": expireDate,
  };
}

class UseFor {
  UseFor({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory UseFor.fromJson(Map<String, dynamic> json) => UseFor(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}
