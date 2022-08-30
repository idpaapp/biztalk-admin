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
  Data? data;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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
    this.data,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
    this.userSurveyAverage,
  });

  List<Datum>? data;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;
  double? userSurveyAverage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
    hasNextPage: json["hasNextPage"] == null ? null : json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"] == null ? null : json["hasPrevPage"],
    userSurveyAverage: json["userSurveyAverage"] == null ? null : json["userSurveyAverage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
    "hasNextPage": hasNextPage == null ? null : hasNextPage,
    "hasPrevPage": hasPrevPage == null ? null : hasPrevPage,
    "userSurveyAverage": userSurveyAverage == null ? null : userSurveyAverage,
  };
}

class Datum {
  Datum({
    this.surveyAnswerId,
    this.fullName,
    this.createDate,
    this.comment,
    this.surveyQuestionAverage,
  });

  String? surveyAnswerId;
  String? fullName;
  String? createDate;
  String? comment;
  double? surveyQuestionAverage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    surveyAnswerId: json["surveyAnswerId"] == null ? null : json["surveyAnswerId"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    comment: json["comment"] == null ? null : json["comment"],
    surveyQuestionAverage: json["surveyQuestionAverage"] == null ? null : json["surveyQuestionAverage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "surveyAnswerId": surveyAnswerId == null ? null : surveyAnswerId,
    "fullName": fullName == null ? null : fullName,
    "createDate": createDate == null ? null : createDate,
    "comment": comment == null ? null : comment,
    "surveyQuestionAverage": surveyQuestionAverage == null ? null : surveyQuestionAverage,
  };
}
