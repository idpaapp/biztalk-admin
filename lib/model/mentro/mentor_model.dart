// To parse this JSON data, do
//
//     final mentorModel = mentorModelFromJson(jsonString);

import 'dart:convert';

MentorModel mentorModelFromJson(String str) => MentorModel.fromJson(json.decode(str));

String mentorModelToJson(MentorModel data) => json.encode(data.toJson());

class MentorModel {
  MentorModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory MentorModel.fromJson(Map<String, dynamic> json) => MentorModel(
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
    this.profile,
    this.requests,
  });

  Profile? profile;
  List<Request>? requests;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profile: Profile.fromJson(json["profile"]),
    requests: List<Request>.from(json["requests"].map((x) => Request.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile!.toJson(),
    "requests": List<dynamic>.from(requests!.map((x) => x.toJson())),
  };
}

class Profile {
  Profile({
    this.id,
    this.fullName,
    this.userName,
    this.phone,
    this.profile,
    this.cashOutPending,
    this.newAccount,
    this.isConfirmDocs,
    this.grade,
    this.gradeTitle,
    this.jobTitle,
    this.skills,
    this.description,
    this.videoUrl,
    this.status,
    this.statusTitle,
  });

  String? id;
  String? fullName;
  String? userName;
  String? phone;
  dynamic profile;
  String? cashOutPending;
  bool? newAccount;
  bool? isConfirmDocs;
  String? grade;
  String? gradeTitle;
  dynamic jobTitle;
  String? status;
  String? statusTitle;
  List<Skill>? skills;
  dynamic description;
  dynamic videoUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    statusTitle: json["statusTitle"],
    status: json["status"],
    fullName: json["fullName"],
    userName: json["userName"],
    phone: json["phone"],
    profile: json["profile"],
    cashOutPending: json["cashOutPending"],
    newAccount: json["newAccount"],
    isConfirmDocs: json["isConfirmDocs"],
    grade: json["grade"],
    gradeTitle: json["gradeTitle"],
    jobTitle: json["jobTitle"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    description: json["description"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "statusTitle": statusTitle,
    "fullName": fullName,
    "userName": userName,
    "phone": phone,
    "profile": profile,
    "cashOutPending": cashOutPending,
    "newAccount": newAccount,
    "isConfirmDocs": isConfirmDocs,
    "grade": grade,
    "gradeTitle": gradeTitle,
    "jobTitle": jobTitle,
    "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
    "description": description,
    "videoUrl": videoUrl,
  };
}

class Skill {
  Skill({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}

class Request {
  Request({
    this.id,
    this.subject,
    this.requestOwnerName,
    this.description,
    this.status,
    this.statusTitle,
    this.createdAt,
    this.date,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? subject;
  String? requestOwnerName;
  String? description;
  String? status;
  String? statusTitle;
  String? createdAt;
  dynamic date;
  dynamic startTime;
  dynamic endTime;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["_id"],
    subject: json["subject"],
    requestOwnerName: json["requestOwnerName"],
    description: json["description"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    createdAt: json["createdAt"],
    date: json["date"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subject": subject,
    "requestOwnerName": requestOwnerName,
    "description": description,
    "status": status,
    "statusTitle": statusTitle,
    "createdAt": createdAt,
    "date": date,
    "startTime": startTime,
    "endTime": endTime,
  };
}
