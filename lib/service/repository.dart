import 'dart:convert';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import '../model/login/login_model.dart';
import '../resources/global_info.dart';
import 'http_service.dart';
import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/login/login_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';

class Repository{


  //*********************** login


  Future<Either<Failure, LoginModel>> login(String number, String password) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}login',
            needAuth: true,body:{
          "phone": number,
          "password":password
        } );
        var encode = jsonEncode(response);

        var data = loginModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }




}