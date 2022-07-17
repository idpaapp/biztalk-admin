import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/get_option_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

class DocumentRepository {
  Future<Either<Failure, DocumentsModel>> getDocument(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}profile/getAdditionalData/$id',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = documentsModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //************************************************  confirm additisional
  Future<Either<Failure, EditModel>> confirmAdditional(String id,Map<String,dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.patch, '${GlobalInfo.baseURL}profile/confirmAdditionalData/$id',
            needAuth: true,body: body);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //************************************** get option
  Future<Either<Failure, GetOptionModel>> getOption(String type) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}getOptions?type=$type',
            needAuth: true);
        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        var encode = jsonEncode(response);

        var data = getOptionModelFromJson(encode);

        return data.success == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //********************************************* create work
  Future<Either<Failure, EditModel>> createWorkExperience(
      Map<String, dynamic> body,String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}profile/addExperience/$id',
            needAuth: true, body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }


  //********************************************* edit work
  Future<Either<Failure, EditModel>> editWorkExperience(
      Map<String, dynamic> body,String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/editExperience/$id/$itemId',
            needAuth: true, body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
  //********************************************* delete work
  Future<Either<Failure, EditModel>>deleteWorkExperience(String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}profile/deleteExperience/$id/$itemId',
            needAuth: true,body: {});

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //********************************************* delete education
  Future<Either<Failure, EditModel>>deleteEducation(String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}profile/deleteEducation/$id/$itemId',
            needAuth: true,body: {});

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }



  //********************************************* create education
  Future<Either<Failure, EditModel>> createEducation(
      Map<String, dynamic> body,String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}profile/addEducation/$id',
            needAuth: true, body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //********************************************* edit education
  Future<Either<Failure, EditModel>> editEducation(
      Map<String, dynamic> body,String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/editEducation/$id/$itemId',
            needAuth: true, body: body);


        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {

        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
  //******************************
  Future<Either<Failure, EditModel>> createAchive(
      Map<String, dynamic> body,String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}profile/addAchievements/$id',
            needAuth: true, body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  } //******************************
  Future<Either<Failure, EditModel>> editAchive(
      Map<String, dynamic> body,String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/editAchievements/$id/$itemId',
            needAuth: true, body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        print(response);

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {

        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
  //********************************************* delete education
  Future<Either<Failure, EditModel>>deleteAchievement(String id,String itemId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}profile/deleteAchievements/$id/$itemId',
            needAuth: true,body: {});

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  } //********************************************* delete education
  Future<Either<Failure, EditModel>>changeDateANdTime(String id,Map<String,String >body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}sessions/changeSessionTime/$id',
            needAuth: true,body: body);

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

}
