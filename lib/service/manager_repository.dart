import 'dart:convert';
import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/comment_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/get_answers_model.dart';
import 'package:biztalk_panel_admin/model/home/all_banner_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';


class ManagerRepository{
  //***************************************** create banner
  Future<Either<Failure, EditModel>> createBanner(
      Map<String,dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}banner',
            needAuth: true,body:body );
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }  //***************************************** create banner
  Future<Either<Failure, EditModel>> editBanner( String id,Map<String,dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}banner/$id',
            needAuth: true,body:body );
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //***************************************** get banner
  Future<Either<Failure, AllBannerModel>> getBanners() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}banner',
            needAuth: true );
        var encode = jsonEncode(response);

        var data = allBannerModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //***************************************** delete banner
  Future<Either<Failure, EditModel>> deleteBanner(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}banner/$id',
            needAuth: true ,body: {});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
//***************************************** delete banner
  Future<Either<Failure, CommentsModel>> getComment(int page,String mentorId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}survey/reports/$page/$mentorId',
            needAuth: true ,body: {});
        var encode = jsonEncode(response);

        var data = commentsModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }//***************************************** get answers
  Future<Either<Failure, GetAnswersModel>> getAnswers(String answerId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}survey/singleReports/$answerId',
            needAuth: true );
        var encode = jsonEncode(response);

        var data = getAnswersModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
}