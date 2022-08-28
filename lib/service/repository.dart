import 'dart:convert';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/model/get_all_bank_model.dart';
import 'package:biztalk_panel_admin/model/iban_inquiry_model.dart';
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
import 'package:http/http.dart' as http;

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
//********************************************* check sheba
  Future<Either<Failure, IbanInquiryModel>> checkIban(
      String sheba) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var headers = {'Authorization': 'Bearer 25ac89d2972346aba400f2fd9d4cd06e'};

        var request = http.MultipartRequest(
            'POST', Uri.parse('https://api.zibal.ir/v1/subMerchant/ibanInquiry'));
        request.fields.addAll(
            {'bankAccount': sheba});


        request.headers.addAll(headers);
        http.Response response =
        await http.Response.fromStream(await request.send());

        var data = ibanInquiryModelFromJson(response.body);

        return data.result == 1
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

//**************************************** get bank

  Future<Either<Failure, AllBankModel>> getBanks() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}getOptions?type=bank',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = allBankModelFromJson(encode);

        return data.success == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

}