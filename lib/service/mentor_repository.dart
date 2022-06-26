import 'dart:convert';

import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/contact/mentor_contact_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/tv/mentor_tv_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';

class MentorRepository {
  Future<Either<Failure, MentorContactModel>> getMentorContacts(
      String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}profile/contacts/$id',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = mentorContactModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //********************************* get mentor tvs
  Future<Either<Failure, MentorTvsModel>> getMentorTvs(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}profile/tvs/$id',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = mentorTvsModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

//****************************************** update tv
  Future<Either<Failure, EditModel>> updateTv(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/tv/$userId',
            needAuth: true, body: body);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

//****************************************** update tv
  Future<Either<Failure, EditModel>> updateContact(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/contact/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //****************************************** Create tv
  Future<Either<Failure, EditModel>> createTv(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}profile/tv/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //****************************************** Create contact

  Future<Either<Failure, EditModel>> createContact(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}profile/contact/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //******************* delete contact
  Future<Either<Failure, EditModel>> deleteContact(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}profile/contact/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //******************* delete tv
  Future<Either<Failure, EditModel>> deleteTv(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}profile/tv/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //******************* delete tv
  Future<Either<Failure, EditModel>> confirmTvOrContact(
      Map<String, dynamic> body, String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.patch, '${GlobalInfo.baseURL}profile/confirmTvContact/$userId',
            needAuth: true, body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
}
