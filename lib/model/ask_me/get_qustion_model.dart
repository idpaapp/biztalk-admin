// To parse this JSON data, do
//
//     final getQuestionModel = getQuestionModelFromJson(jsonString);

import 'dart:convert';

GetQuestionModel getQuestionModelFromJson(String str) => GetQuestionModel.fromJson(json.decode(str));

String getQuestionModelToJson(GetQuestionModel data) => json.encode(data.toJson());

class GetQuestionModel {
  GetQuestionModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory GetQuestionModel.fromJson(Map<String, dynamic> json) => GetQuestionModel(
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
    this.questions,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Question>? questions;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
    hasNextPage: json["hasNextPage"] == null ? null : json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"] == null ? null : json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "questions": questions == null ? null : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
    "hasNextPage": hasNextPage == null ? null : hasNextPage,
    "hasPrevPage": hasPrevPage == null ? null : hasPrevPage,
  };
}

class Question {
  Question({
    this.id,
    this.title,
    this.question,
    this.status,
    this.statusTitle,
    this.answersCount,
    this.questioner,
    this.responder,
    this.dateTime,
  });

  String? id;
  String? title;
  String? question;
  String? status;
  String? statusTitle;
  int? answersCount;
  Questioner? questioner;
  Responder? responder;
  String? dateTime;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    question: json["question"] == null ? null : json["question"],
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    answersCount: json["answersCount"] == null ? null : json["answersCount"],
    questioner: json["questioner"] == null ? null : Questioner.fromJson(json["questioner"]),
    responder: json["responder"] == null ? null : Responder.fromJson(json["responder"]),
    dateTime: json["dateTime"] == null ? null : json["dateTime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "question": question == null ? null : question,
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "answersCount": answersCount == null ? null : answersCount,
    "questioner": questioner == null ? null : questioner!.toJson(),
    "responder": responder == null ? null : responder!.toJson(),
    "dateTime": dateTime == null ? null : dateTime,
  };
}

class Questioner {
  Questioner({
    this.id,
    this.fullName,
  });

  String? id;
  String? fullName;

  factory Questioner.fromJson(Map<String, dynamic> json) => Questioner(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
  };
}

class Responder {
  Responder({
    this.id,
    this.answer,
    this.userAnswer,
  });

  String? id;
  String? answer;
  Questioner? userAnswer;

  factory Responder.fromJson(Map<String, dynamic> json) => Responder(
    id: json["_id"] == null ? null : json["_id"],
    answer: json["answer"] == null ? null : json["answer"],
    userAnswer: json["userAnswer"] == null ? null : Questioner.fromJson(json["userAnswer"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "answer": answer == null ? null : answer,
    "userAnswer": userAnswer == null ? null : userAnswer!.toJson(),
  };
}
