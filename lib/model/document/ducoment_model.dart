// To parse this JSON data, do
//
//     final documentsModel = documentsModelFromJson(jsonString);

import 'dart:convert';

DocumentsModel documentsModelFromJson(String str) => DocumentsModel.fromJson(json.decode(str));

String documentsModelToJson(DocumentsModel data) => json.encode(data.toJson());

class DocumentsModel {
  DocumentsModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory DocumentsModel.fromJson(Map<String, dynamic> json) => DocumentsModel(
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
    this.works,
    this.educations,
    this.achievements,
  });

  List<Work>? works;
  List<Education>? educations;
  List<Achievement>? achievements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    works: List<Work>.from(json["works"].map((x) => Work.fromJson(x))),
    educations: List<Education>.from(json["educations"].map((x) => Education.fromJson(x))),
    achievements: List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "works": List<dynamic>.from(works!.map((x) => x.toJson())),
    "educations": List<dynamic>.from(educations!.map((x) => x.toJson())),
    "achievements": List<dynamic>.from(achievements!.map((x) => x.toJson())),
  };
}

class Achievement {
  Achievement({
    this.id,
    this.title,
    this.place,
    this.year,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
  });

  String? id;
  String? title;
  String? place;
  String? year;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json["id"],
    title: json["title"],
    place: json["place"],
    year: json["year"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    verificationStatus: json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"],
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "place": place,
    "year": year,
    "status": status,
    "statusTitle": statusTitle,
    "verificationStatus": verificationStatus,
    "verificationStatusTitle": verificationStatusTitle,
    "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class Attachment {
  Attachment({
    this.fileUrl,
    this.id,
  });

  String? fileUrl;
  String? id;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    fileUrl: json["fileUrl"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "fileUrl": fileUrl,
    "_id": id,
  };
}

class Education {
  Education({
    this.id,
    this.school,
    this.schoolTitle,
    this.startYear,
    this.endYear,
    this.activityYear,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
    this.currentCourse,
    this.degree
  });

  String? id;
  School? school;
  String? schoolTitle;
  String? startYear;
  String? endYear;
  String? activityYear;
  bool? status;
  String? statusTitle;
  String? degree;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;
  bool? currentCourse;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"],
    degree: json["degree"],
    school: School.fromJson(json["school"]),
    schoolTitle: json["schoolTitle"],
    startYear: json["startYear"],
    endYear: json["endYear"],
    activityYear: json["activityYear"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    verificationStatus: json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"],
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    currentCourse: json["currentCourse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "degree": degree,
    "school": school!.toJson(),
    "schoolTitle": schoolTitle,
    "startYear": startYear,
    "endYear": endYear,
    "activityYear": activityYear,
    "status": status,
    "statusTitle": statusTitle,
    "verificationStatus": verificationStatus,
    "verificationStatusTitle": verificationStatusTitle,
    "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "currentCourse": currentCourse,
  };
}

class School {
  School({
    this.id,
    this.title,
    this.slug,
    this.imageUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? slug;
  String? imageUrl;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory School.fromJson(Map<String, dynamic> json) => School(
    id: json["_id"],
    title: json["title"],
    slug: json["slug"],
    imageUrl: json["imageUrl"],
    type: json["type"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "slug": slug,
    "imageUrl": imageUrl,
    "type": type,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class Work {
  Work({
    this.id,
    this.job,
    this.company,
    this.companyTitle,
    this.startYear,
    this.endYear,
    this.activityYear,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
    this.currentPosition,
  });

  String? id;
  String? job;
  School? company;
  String? companyTitle;
  String? startYear;
  String? endYear;
  String? activityYear;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;
  bool? currentPosition;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    id: json["id"],
    job: json["job"],
    company: School.fromJson(json["company"]),
    companyTitle: json["companyTitle"],
    startYear: json["startYear"],
    endYear: json["endYear"],
    activityYear: json["activityYear"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    verificationStatus: json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"],
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    currentPosition: json["currentPosition"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "company": company!.toJson(),
    "companyTitle": companyTitle,
    "startYear": startYear,
    "endYear": endYear,
    "activityYear": activityYear,
    "status": status,
    "statusTitle": statusTitle,
    "verificationStatus": verificationStatus,
    "verificationStatusTitle": verificationStatusTitle,
    "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "currentPosition": currentPosition,
  };
}
