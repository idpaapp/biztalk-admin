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
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
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
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
    hasNextPage: json["hasNextPage"] == null ? null : json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"] == null ? null : json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "tvs": tvs == null ? null : List<dynamic>.from(tvs!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
    "hasNextPage": hasNextPage == null ? null : hasNextPage,
    "hasPrevPage": hasPrevPage == null ? null : hasPrevPage,
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
    userId: json["userId"] == null ? null : json["userId"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    userName: json["userName"] == null ? null : json["userName"],
    tvId: json["tvId"] == null ? null : json["tvId"],
    tvTitle: json["tvTitle"] == null ? null : json["tvTitle"],
    tvLogo: json["tvLogo"] == null ? null : json["tvLogo"],
    tvLink: json["tvLink"] == null ? null : json["tvLink"],
    tvUserName: json["tvUserName"] == null ? null : json["tvUserName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "fullName": fullName == null ? null : fullName,
    "userName": userName == null ? null : userName,
    "tvId": tvId == null ? null : tvId,
    "tvTitle": tvTitle == null ? null : tvTitle,
    "tvLogo": tvLogo == null ? null : tvLogo,
    "tvLink": tvLink == null ? null : tvLink,
    "tvUserName": tvUserName == null ? null : tvUserName,
  };
}
