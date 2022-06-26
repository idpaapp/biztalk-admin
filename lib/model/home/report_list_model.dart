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
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
    hasNextPage: json["hasNextPage"] == null ? null : json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"] == null ? null : json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "report": report == null ? null : List<dynamic>.from(report!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
    "hasNextPage": hasNextPage == null ? null : hasNextPage,
    "hasPrevPage": hasPrevPage == null ? null : hasPrevPage,
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
    id: json["_id"] == null ? null : json["_id"],
    plaintiff: json["plaintiff"] == null ? null : Accused.fromJson(json["plaintiff"]),
    accused: json["accused"] == null ? null : Accused.fromJson(json["accused"]),
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    text: json["text"] == null ? null : json["text"],
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "plaintiff": plaintiff == null ? null : plaintiff!.toJson(),
    "accused": accused == null ? null : accused!.toJson(),
    "createdAt": createdAt == null ? null : createdAt,
    "subject": subject == null ? null : subject!.toJson(),
    "text": text == null ? null : text,
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
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
  });

  String? id;
  String? fullName;
  String? userName;
  String? userType;
  String? phoneNumber;
  String? profileImageUrl;

  factory Accused.fromJson(Map<String, dynamic> json) => Accused(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    userName: json["userName"] == null ? null : json["userName"],
    userType: json["userType"] == null ? null : json["userType"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "userName": userName == null ? null : userName,
    "userType": userType == null ? null : userType,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
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
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
  };
}
