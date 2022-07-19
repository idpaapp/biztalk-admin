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
    this.works,
    this.educations,
    this.achievements,
  });

  List<Work>? works;
  List<Education>? educations;
  List<Achievement>? achievements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    works: json["works"] == null ? null : List<Work>.from(json["works"].map((x) => Work.fromJson(x))),
    educations: json["educations"] == null ? null : List<Education>.from(json["educations"].map((x) => Education.fromJson(x))),
    achievements: json["achievements"] == null ? null : List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "works": works == null ? null : List<dynamic>.from(works!.map((x) => x.toJson())),
    "educations": educations == null ? null : List<dynamic>.from(educations!.map((x) => x.toJson())),
    "achievements": achievements == null ? null : List<dynamic>.from(achievements!.map((x) => x.toJson())),
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
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
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
    "attachments": attachments == null ? null : List<Attachment>.from(attachments!.map((x) => x)),
  };
}

class Education {
  Education({
    this.id,
    this.school,
    this.schoolTitle,
    this.degree,
    this.startYear,
    this.endYear,
    this.activityYear,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
    this.currentCourse,
  });

  String? id;
  School? school;
  String? schoolTitle;
  String? degree;
  String? startYear;
  String? endYear;
  String? activityYear;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;
  bool? currentCourse;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"],
    school: json["school"] == null ? null : School.fromJson(json["school"]),
    schoolTitle: json["schoolTitle"],
    degree: json["degree"],
    startYear: json["startYear"],
    endYear: json["endYear"],
    activityYear: json["activityYear"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    verificationStatus: json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
    currentCourse: json["currentCourse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "school": school == null ? null : school!.toJson(),
    "schoolTitle": schoolTitle,
    "degree": degree,
    "startYear": startYear,
    "endYear": endYear,
    "activityYear": activityYear,
    "status": status,
    "statusTitle": statusTitle,
    "verificationStatus": verificationStatus,
    "verificationStatusTitle": verificationStatusTitle,
    "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x)),
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "slug": slug,
    "imageUrl": imageUrl,
    "type": type,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
    company: json["company"] == null ? null : School.fromJson(json["company"]),
    companyTitle: json["companyTitle"],
    startYear: json["startYear"],
    endYear: json["endYear"],
    activityYear: json["activityYear"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    verificationStatus: json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
    currentPosition: json["currentPosition"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "company": company == null ? null : company!.toJson(),
    "companyTitle": companyTitle,
    "startYear": startYear,
    "endYear": endYear,
    "activityYear": activityYear,
    "status": status,
    "statusTitle": statusTitle,
    "verificationStatus": verificationStatus,
    "verificationStatusTitle": verificationStatusTitle,
    "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x)),
    "currentPosition": currentPosition,
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

