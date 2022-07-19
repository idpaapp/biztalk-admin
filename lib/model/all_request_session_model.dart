// To parse this JSON data, do
//
//     final allRequestSessionModel = allRequestSessionModelFromJson(jsonString);

import 'dart:convert';

AllRequestSessionModel allRequestSessionModelFromJson(String str) => AllRequestSessionModel.fromJson(json.decode(str));

String allRequestSessionModelToJson(AllRequestSessionModel data) => json.encode(data.toJson());

class AllRequestSessionModel {
  AllRequestSessionModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory AllRequestSessionModel.fromJson(Map<String, dynamic> json) => AllRequestSessionModel(
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
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
  });

  List<Doc>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docs: json["docs"] == null ? null : List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
    totalDocs: json["totalDocs"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? null : List<dynamic>.from(docs!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "limit": limit,
    "totalPages": totalPages,
    "page": page,
  };
}

class Doc {
  Doc({
    this.id,
    this.person,
    this.jobTitle,
    this.subject,
    this.status,
    this.statusTitle,
    this.meUser,
    this.createDate,
    this.type,
    this.description,
    this.date,
    this.time,
    this.profileImageUrl,
    this.request,
  });

  String? id;
  Person? person;
  String? jobTitle;
  Subject? subject;
  String? status;
  String? statusTitle;
  bool? meUser;
  String? createDate;
  String? type;
  String? description;
  String? date;
  Time? time;
  String? profileImageUrl;
  String? request;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"],
    person: json["person"] == null ? null : Person.fromJson(json["person"]),
    jobTitle: json["jobTitle"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    status: json["status"],
    statusTitle: json["statusTitle"],
    meUser: json["meUser"],
    createDate: json["createDate"],
    type: json["type"],
    description: json["description"],
    date: json["date"],
    time: json["time"] == null ? null : Time.fromJson(json["time"]),
    profileImageUrl: json["profileImageUrl"],
    request: json["request"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "person": person == null ? null : person!.toJson(),
    "jobTitle": jobTitle,
    "subject": subject == null ? null : subject!.toJson(),
    "status": status,
    "statusTitle": statusTitle,
    "meUser": meUser,
    "createDate": createDate,
    "type": type,
    "description": description,
    "date": date,
    "time": time == null ? null : time!.toJson(),
    "profileImageUrl": profileImageUrl,
    "request": request,
  };
}

class Person {
  Person({
    this.id,
    this.fullName,
    this.profileImageUrl,
    this.jobTitle,
    this.grade,
    this.gradeTitle,
    this.userType,
  });

  String? id;
  String? fullName;
  String? profileImageUrl;
  String? jobTitle;
  String? grade;
  String? gradeTitle;
  String? userType;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["_id"],
    fullName: json["fullName"],
    profileImageUrl: json["profileImageUrl"],
    jobTitle: json["jobTitle"],
    grade: json["grade"],
    gradeTitle: json["gradeTitle"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "profileImageUrl": profileImageUrl,
    "jobTitle": jobTitle,
    "grade": grade,
    "gradeTitle": gradeTitle,
    "userType": userType,
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

class Time {
  Time({
    this.id,
    this.start,
    this.end,
    this.formattedPrice,
    this.price,
    this.status,
    this.sessionTime,
    this.statusTitle,
  });

  String? id;
  String? start;
  String? end;
  String? formattedPrice;
  int? price;
  String? status;
  String? sessionTime;
  String? statusTitle;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json["_id"],
    start: json["start"],
    end: json["end"],
    formattedPrice: json["formattedPrice"],
    price: json["price"],
    status: json["status"],
    sessionTime: json["sessionTime"],
    statusTitle: json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "start": start,
    "end": end,
    "formattedPrice": formattedPrice,
    "price": price,
    "status": status,
    "sessionTime": sessionTime,
    "statusTitle": statusTitle,
  };
}
