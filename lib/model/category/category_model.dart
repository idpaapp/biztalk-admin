// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<SingleCategory>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    ok: json["ok"],
    message: json["message"],
    data: List<SingleCategory>.from(json["data"].map((x) => SingleCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCategory {
  SingleCategory({
    this.id,
    this.title,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory SingleCategory.fromJson(Map<String, dynamic> json) => SingleCategory(
    id: json["_id"],
    title: json["title"],
    icon: json["icon"],
    createdAt:json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "icon": icon,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
