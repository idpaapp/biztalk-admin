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
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    limit: json["limit"] == null ? null : json["limit"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? null : List<dynamic>.from(docs!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "limit": limit == null ? null : limit,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
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
    id: json["_id"] == null ? null : json["_id"],
    person: json["person"] == null ? null : Person.fromJson(json["person"]),
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    meUser: json["meUser"] == null ? null : json["meUser"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : Time.fromJson(json["time"]),
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    request: json["request"] == null ? null : json["request"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "person": person == null ? null : person!.toJson(),
    "jobTitle": jobTitle == null ? null : jobTitle,
    "subject": subject == null ? null : subject!.toJson(),
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "meUser": meUser == null ? null : meUser,
    "createDate": createDate == null ? null : createDate,
    "type": type == null ? null : type,
    "description": description == null ? null : description,
    "date": date == null ? null : date,
    "time": time == null ? null : time!.toJson(),
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "request": request == null ? null : request,
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
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    grade: json["grade"] == null ? null : json["grade"],
    gradeTitle: json["gradeTitle"] == null ? null : json["gradeTitle"],
    userType: json["userType"] == null ? null : json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "jobTitle": jobTitle == null ? null : jobTitle,
    "grade": grade == null ? null : grade,
    "gradeTitle": gradeTitle == null ? null : gradeTitle,
    "userType": userType == null ? null : userType,
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
    id: json["_id"] == null ? null : json["_id"],
    start: json["start"] == null ? null : json["start"],
    end: json["end"] == null ? null : json["end"],
    formattedPrice: json["formattedPrice"] == null ? null : json["formattedPrice"],
    price: json["price"] == null ? null : json["price"],
    status: json["status"] == null ? null : json["status"],
    sessionTime: json["sessionTime"] == null ? null : json["sessionTime"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "start": start == null ? null : start,
    "end": end == null ? null : end,
    "formattedPrice": formattedPrice == null ? null : formattedPrice,
    "price": price == null ? null : price,
    "status": status == null ? null : status,
    "sessionTime": sessionTime == null ? null : sessionTime,
    "statusTitle": statusTitle == null ? null : statusTitle,
  };
}
