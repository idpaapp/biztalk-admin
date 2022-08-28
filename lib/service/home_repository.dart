import 'dart:convert';
import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/ask_me/get_mentor_for_ask_model.dart';
import 'package:biztalk_panel_admin/model/ask_me/get_qustion_model.dart';
import 'package:biztalk_panel_admin/model/category/category_model.dart';
import 'package:biztalk_panel_admin/model/contact/all_contact_model.dart';
import 'package:biztalk_panel_admin/model/document/new_document_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/home/change_profile_model.dart';
import 'package:biztalk_panel_admin/model/home/check_list_model.dart';
import 'package:biztalk_panel_admin/model/home/info_home_model.dart';
import 'package:biztalk_panel_admin/model/home/report_list_model.dart';
import 'package:biztalk_panel_admin/model/home/request_list_model.dart';
import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/model/home/single_report_model.dart';
import 'package:biztalk_panel_admin/model/home/tv_list_model.dart';
import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/model/mentro/user_model.dart';
import 'package:biztalk_panel_admin/model/off/create_off_model.dart';
import 'package:biztalk_panel_admin/model/off/get_off_model.dart';
import 'package:biztalk_panel_admin/model/remote_config_model.dart';
import 'package:biztalk_panel_admin/model/transaction/not_verify_account_model.dart';
import 'package:biztalk_panel_admin/model/transaction/transaction_model.dart';
import 'package:biztalk_panel_admin/model/tv/all_tvs_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<Either<Failure, HomeInfoModel>> getInfoHome() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}home/info',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = homeInfoModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //***************************************************
  Future<Either<Failure, UsersHomeModel>> getUserHome(
      {int? page, String? mobile, String? status, String? type}) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/users?page=$page';
        if (type != null) {
          url += "&type=$type";
        }
        if (status != null) {
          url += "&status=$status";
        }
        if (mobile != null) {
          url += "&search=$mobile";
        }

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = usersHomeModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  Future<Either<Failure, MentorModel>> getMentor(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(RequestType.get,
            '${GlobalInfo.baseURL}profile/getMentorProfile/$id',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = mentorModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  Future<Either<Failure, UserModel>> getUser(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}profile/getUserProfile/$id',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = userModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //*************************** get category
  Future<Either<Failure, CategoryModel>> getCategory() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}getCategories',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = categoryModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //*************************** get tvs
  Future<Either<Failure, AllTvsModel>> getAllTvs() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}getTvs',
            needAuth: true);

        var encode = jsonEncode(response);

        var data = allTvsModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //*************************** get contact

  Future<Either<Failure, AllContactModel>> getAllContact() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}getContacts',
            needAuth: true);
        var encode = jsonEncode(response);

        var data = allContactModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  ////////////**************************** edit profile
  Future<Either<Failure, EditModel>> editProfile(
      Map<String, dynamic> body, String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}profile/$id',
            needAuth: true, body: body);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

//************************* delete or confirm video and description
  Future<Either<Failure, EditModel>> editVideo(
      String id, String type, bool confirm) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(RequestType.patch,
            '${GlobalInfo.baseURL}profile/aboutMeStatus?userId=$id&type=$type',
            needAuth: true, body: {"confirm": confirm});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //*********************************** get transaction
  Future<Either<Failure, TransactionModel>> getTransaction(
      String id, int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}transaction?userId=$id&page=$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        print(response);
        var encode = jsonEncode(response);

        var data = transactionModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //****************** not verify account
  Future<Either<Failure, NotVerifyAccountModel>> getNotVerifyAccount(
      int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/notVerifyAccount?page=$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);
        print(response);

        var data = notVerifyAccountModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //********************************** verify account
  Future<Either<Failure, EditModel>> verifyAccount(
      String userId, bool confirm,String bankName,String userName) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}profile/verifyAccount/$userId';

        var response = await HttpServices.request(RequestType.patch, url,
            needAuth: true, body: {"confirm": confirm,"nameInBank":bankName,"bankNameInBank":userName});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //*************************************************** check list
  Future<Either<Failure, CheckListModel>> getCheckList(int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getCheckList/$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = checkListModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //**************************** request list
  Future<Either<Failure, RequestListModel>> requestList(int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getRequestList/$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = requestListModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //***************************************** session list
  Future<Either<Failure, SessionListModel>> sessionList(int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getSessionList/$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);
        print(response);

        var data = sessionListModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //***************************************** report list

  Future<Either<Failure, ReportListModel>> reportList(int page) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getReportList/$page';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = reportListModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //********************* single report
  Future<Either<Failure, SingleReportModel>> singleReport(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getReport/$id';

        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = singleReportModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //**************************** single session
  Future<Either<Failure, SingleReportModel>> singleSession(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getSession/$id';
        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = singleReportModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //**************************** single request

  Future<Either<Failure, SingleReportModel>> singleRequest(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getRequest/$id';
        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = singleReportModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //********************************** list tv
  Future<Either<Failure, NewDocumentModel>> listTv() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getTvs';
        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);
        print(response);

        var data = newDocumentModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //****************************** confirm tv or contact
  Future<Either<Failure, EditModel>> confirmTvOrContact(
      String userId, String type, String tvId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}profile/confirmTvContact/$userId';
        var response = await HttpServices.request(RequestType.patch, url,
            needAuth: true, body: {"_id": tvId, "type": type});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //**************************************** 555
  //********************** remote config
  Future<Either<Failure, RemoteConfigModel>> remoteConfig() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var headers = {
          'X-Parse-Application-Id': 'J93vp2x7h7Eiexe6jfpQc5jzcYd7IB6FljRhMqpS',
          'X-Parse-REST-API-Key': 'Z5z7dQEnBjXVxKWz8pbyThQ8cwpGmndjGWs2NPzt',
        };
        var request = http.Request('GET',
            Uri.parse('https://parseapi.back4app.com/classes/RemoteConfig'));

        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());

        var data = remoteConfigModelFromJson(response.body);

        return data.results!.isNotEmpty
            ? Right(data)
            : Left(ApiFailure("خطا در گرفتن"));
      } catch (e) {
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //************************************** create off
  Future<Either<Failure, CreateOffCodeModel>> createOff(
      Map<String, dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}discount';
        var response = await HttpServices.request(RequestType.post, url,
            needAuth: true, body: body);
        var encode = jsonEncode(response);

        var data = createOffCodeModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //************************************** get all off
  Future<Either<Failure, GetOffModel>> allOffCode() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}discount';
        var response =
            await HttpServices.request(RequestType.get, url, needAuth: true);
        var encode = jsonEncode(response);

        var data = getOffModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //************************************** get all off

  Future<Either<Failure, EditModel>> deleteOff(String id) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}discount/$id';
        var response = await HttpServices.request(RequestType.delete, url,
            needAuth: true, body: {});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  //*************************************** switch mentor
  Future<Either<Failure, EditModel>> changeUserStatus(
      String id, String? status) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}profile/changeUserStatus?userId=$id';
        var response = await HttpServices.request(RequestType.patch, url,
            needAuth: true, body: {"status": status});
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  } //*************************************** switch mentor

  Future<Either<Failure, EditModel>> addUser(Map<String, dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}profile/addUser';
        var response = await HttpServices.request(RequestType.post, url,
            needAuth: true, body: body);
        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }

  Future<Either<Failure, EditModel>> changeDateANdTime(
      String id, Map<String, String> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        print("3333333");
        print(id);
        print(body);

        var response = await HttpServices.request(RequestType.put,
            '${GlobalInfo.baseURL}sessions/changeSessionTime/$id',
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

  //******************************** get questions
  Future<Either<Failure, GetQuestionModel>> getQuestions(
      {String? status}) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}askMe';
        if (status != null && status != "All") {
          url += "?status=$status";
        }
        var response = await HttpServices.request(
          RequestType.get,
          url,
          needAuth: true,
        );

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        print(response);

        var encode = jsonEncode(response);

        var data = getQuestionModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //******************** get mentor ask
  Future<Either<Failure, GetMentorForAskModel>> getMentorsForAsk() async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}askMe/responder';

        var response = await HttpServices.request(
          RequestType.get,
          url,
          needAuth: true,
        );

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        print(response);

        var encode = jsonEncode(response);

        var data = getMentorForAskModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //******************** send answer of question
  Future<Either<Failure, EditModel>> sendAnswer(
      String id, Map<String, String> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}askMe/$id';

        var response = await HttpServices.request(RequestType.post, url,
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
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }  //******************** reject question
  Future<Either<Failure, EditModel>> rejectQuestion(
      String id, ) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}askMe/reject/$id';

        var response = await HttpServices.request(RequestType.patch, url,
            needAuth: true, body: {});

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
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //******************** verify account
  Future<Either<Failure, EditModel>> verifyDiposit(
      String transactionId,String status ,String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}transaction/checkout?id=$transactionId&status=$status&userId=$userId';

        var response = await HttpServices.request(RequestType.patch, url,
            needAuth: true, body: {});

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
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
  //******************** verify account
  Future<Either<Failure, NewDocumentModel>> newDocument( ) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getNewDocuments';

        var response = await HttpServices.request(RequestType.get, url,
            needAuth: true, );

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        print(response);

        var encode = jsonEncode(response);

        var data = newDocumentModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
  //******************** changeProfile
  Future<Either<Failure, ChangeProfileModel>> changeProfile( ) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}home/getUpdatedAboutMe';

        var response = await HttpServices.request(RequestType.get, url,
          needAuth: true, );

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }
        print(response);

        var encode = jsonEncode(response);

        var data = changeProfileModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }

  //******************** checkUserReport
  Future<Either<Failure, EditModel>> checkUserReport(String reportId,String status ) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var url = '${GlobalInfo.baseURL}profile/checkUserReport/$reportId';

        var response = await HttpServices.request(RequestType.patch, url,
          needAuth: true,body: {"status" :status} );

        if (response['error'] != null) {
          return Left(ApiFailure(response['error']['msg']));
        }

        var encode = jsonEncode(response);

        var data = editModelFromJson(encode);

        return data.ok == true
            ? Right(data)
            : Left(ApiFailure(data.message.toString()));
      } catch (e) {
        print(e);
        return Left(ApiFailure("سرور قادر به پاسخگویی نمی باشد"));
      }
    }
  }
}
