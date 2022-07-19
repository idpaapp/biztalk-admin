// To parse this JSON data, do
//
//     final tvListModel = tvListModelFromJson(jsonString);

import 'dart:convert';

TvListModel tvListModelFromJson(String str) => TvListModel.fromJson(json.decode(str));

String tvListModelToJson(TvListModel data) => json.encode(data.toJson());

class TvListModel {
  TvListModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory TvListModel.fromJson(Map<String, dynamic> json) => TvListModel(
    ok: json["ok"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.tvs,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Tv>? tvs;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tvs: json["tvs"] == null ? null : List<Tv>.from(json["tvs"].map((x) => Tv.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "tvs": tvs == null ? null : List<dynamic>.from(tvs!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class Tv {
  Tv({
    this.userId,
    this.fullName,
    this.userName,
    this.tvId,
    this.tvTitle,
    this.tvLogo,
    this.tvLink,
    this.tvUserName,
  });

  String? userId;
  String? fullName;
  String? userName;
  String? tvId;
  String? tvTitle;
  String? tvLogo;
  String? tvLink;
  String? tvUserName;

  factory Tv.fromJson(Map<String, dynamic> json) => Tv(
    userId: json["userId"],
    fullName: json["fullName"],
    userName: json["userName"],
    tvId: json["tvId"],
    tvTitle: json["tvTitle"],
    tvLogo: json["tvLogo"],
    tvLink: json["tvLink"],
    tvUserName: json["tvUserName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "userName": userName,
    "tvId": tvId,
    "tvTitle": tvTitle,
    "tvLogo": tvLogo,
    "tvLink": tvLink,
    "tvUserName": tvUserName,
  };
}
