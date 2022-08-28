// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());

class ReportListModel {
  ReportListModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
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
    this.report,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Report>? report;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    report: json["report"] == null ? null : List<Report>.from(json["report"].map((x) => Report.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "report": report == null ? null : List<dynamic>.from(report!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class Report {
  Report({
    this.id,
    this.plaintiff,
    this.accused,
    this.createdAt,
    this.subject,
    this.text,
    this.status,
    this.statusTitle,
  });

  String? id;
  Accused? plaintiff;
  Accused? accused;
  String? createdAt;
  Subject? subject;
  String? text;
  String? status;
  String? statusTitle;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["_id"],
    plaintiff: json["plaintiff"] == null ? null : Accused.fromJson(json["plaintiff"]),
    accused: json["accused"] == null ? null : Accused.fromJson(json["accused"]),
    createdAt: json["createdAt"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    text: json["text"],
    status: json["status"],
    statusTitle: json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "plaintiff": plaintiff == null ? null : plaintiff!.toJson(),
    "accused": accused == null ? null : accused!.toJson(),
    "createdAt": createdAt,
    "subject": subject == null ? null : subject!.toJson(),
    "text": text,
    "status": status,
    "statusTitle": statusTitle,
  };
}

class Accused {
  Accused({
    this.id,
    this.fullName,
    this.userName,
    this.userType,
    this.phoneNumber,
    this.profileImageUrl,
    this.reportCounter,
  });

  String? id;
  String? fullName;
  String? userName;
  String? userType;
  String? phoneNumber;
  String? profileImageUrl;
  int? reportCounter;

  factory Accused.fromJson(Map<String, dynamic> json) => Accused(
    id: json["_id"],
    reportCounter: json["reportCounter"],
    fullName: json["fullName"],
    userName: json["userName"],
    userType: json["userType"],
    phoneNumber: json["phoneNumber"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reportCounter": reportCounter,
    "fullName": fullName,
    "userName": userName,
    "userType": userType,
    "phoneNumber": phoneNumber,
    "profileImageUrl": profileImageUrl,
  };
}

class Subject {
  Subject({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}
