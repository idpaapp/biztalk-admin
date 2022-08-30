// To parse this JSON data, do
//
//     final getAnswersModel = getAnswersModelFromJson(jsonString);

import 'dart:convert';

GetAnswersModel getAnswersModelFromJson(String str) => GetAnswersModel.fromJson(json.decode(str));

String getAnswersModelToJson(GetAnswersModel data) => json.encode(data.toJson());

class GetAnswersModel {
  GetAnswersModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  AnswersModel? data;

  factory GetAnswersModel.fromJson(Map<String, dynamic> json) => GetAnswersModel(
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : AnswersModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class AnswersModel {
  AnswersModel({
    this.answers,
    this.mentorFullName,
    this.userFullNameuserFullName,
    this.average,
  });

  Answers? answers;
  String? mentorFullName;
  String? userFullNameuserFullName;
  double? average;

  factory AnswersModel.fromJson(Map<String, dynamic> json) => AnswersModel(
    answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
    mentorFullName: json["mentorFullName"] == null ? null : json["mentorFullName"],
    userFullNameuserFullName: json["userFullNameuserFullName"] == null ? null : json["userFullNameuserFullName"],
    average: json["average"] == null ? null : json["average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "answers": answers == null ? null : answers!.toJson(),
    "mentorFullName": mentorFullName == null ? null : mentorFullName,
    "userFullNameuserFullName": userFullNameuserFullName == null ? null : userFullNameuserFullName,
    "average": average == null ? null : average,
  };
}

class Answers {
  Answers({
    this.singleAnswers,
    this.longAnswers,
  });

  List<SingleAnswer>? singleAnswers;
  List<LongAnswer>? longAnswers;

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
    singleAnswers: json["singleAnswers"] == null ? null : List<SingleAnswer>.from(json["singleAnswers"].map((x) => SingleAnswer.fromJson(x))),
    longAnswers: json["longAnswers"] == null ? null : List<LongAnswer>.from(json["longAnswers"].map((x) => LongAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "singleAnswers": singleAnswers == null ? null : List<dynamic>.from(singleAnswers!.map((x) => x.toJson())),
    "longAnswers": longAnswers == null ? null : List<dynamic>.from(longAnswers!.map((x) => x.toJson())),
  };
}

class LongAnswer {
  LongAnswer({
    this.questionText,
    this.description,
  });

  String? questionText;
  String? description;

  factory LongAnswer.fromJson(Map<String, dynamic> json) => LongAnswer(
    questionText: json["questionText"] == null ? null : json["questionText"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "questionText": questionText == null ? null : questionText,
    "description": description == null ? null : description,
  };
}

class SingleAnswer {
  SingleAnswer({
    this.questionText,
    this.answerTitle,
    this.score,
  });

  String? questionText;
  String? answerTitle;
  double? score;

  factory SingleAnswer.fromJson(Map<String, dynamic> json) => SingleAnswer(
    questionText: json["questionText"] == null ? null : json["questionText"],
    answerTitle: json["answerTitle"] == null ? null : json["answerTitle"],
    score: json["score"] == null ? null : json["score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "questionText": questionText == null ? null : questionText,
    "answerTitle": answerTitle == null ? null : answerTitle,
    "score": score == null ? null : score,
  };
}
