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
    this.user,
    this.mentor,
    this.subject,
    this.status,
    this.description,
    this.statusTitle,
    this.meUser,
    this.createDate,
    this.type,
    this.date,
    this.time,
    this.profileImageUrl,
    this.request,
    this.fromNow,
  });

  String? id;
  Mentor? user;
  Mentor? mentor;
  Subject? subject;
  String? status;
  String? description;
  String? statusTitle;
  bool? meUser;
  String? createDate;
  String? type;
  String? date;
  Time? time;
  String? profileImageUrl;
  String? request;
  String? fromNow;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"] == null ? null : json["_id"],
    user: json["user"] == null ? null : Mentor.fromJson(json["user"]),
    mentor: json["mentor"] == null ? null : Mentor.fromJson(json["mentor"]),
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    status: json["status"] == null ? null : json["status"],
    description: json["description"] == null ? null : json["description"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    meUser: json["meUser"] == null ? null : json["meUser"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    type: json["type"] == null ? null : json["type"],
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : Time.fromJson(json["time"]),
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    request: json["request"] == null ? null : json["request"],
    fromNow: json["fromNow"] == null ? null : json["fromNow"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "user": user == null ? null : user!.toJson(),
    "mentor": mentor == null ? null : mentor!.toJson(),
    "subject": subject == null ? null : subject!.toJson(),
    "status": status == null ? null : status,
    "description": description == null ? null : description,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "meUser": meUser == null ? null : meUser,
    "createDate": createDate == null ? null : createDate,
    "type": type == null ? null : type,
    "date": date == null ? null : date,
    "time": time == null ? null : time!.toJson(),
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "request": request == null ? null : request,
    "fromNow": fromNow == null ? null : fromNow,
  };
}

class Mentor {
  Mentor({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.profileImageUrl,
    this.jobTitle,
    this.grade,
    this.userType,
  });

  String? id;
  String? fullName;
  String? phoneNumber;
  String? profileImageUrl;
  String? jobTitle;
  String? grade;
  String? userType;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    grade: json["grade"] == null ? null : json["grade"],
    userType: json["userType"] == null ? null : json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "jobTitle": jobTitle == null ? null : jobTitle,
    "grade": grade == null ? null : grade,
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
