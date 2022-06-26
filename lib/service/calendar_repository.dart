import 'dart:convert';

import 'package:biztalk_panel_admin/failure/app_failure.dart';
import 'package:biztalk_panel_admin/failure/connection_faile.dart';
import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:biztalk_panel_admin/failure/failure.dart';
import 'package:biztalk_panel_admin/model/calendar/add_new_calendar_model.dart';
import 'package:biztalk_panel_admin/model/calendar/mentor_calendar_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/http_service.dart';
import 'package:dartz/dartz.dart';

class CalendarRepository{
  Future<Either<Failure, MentorCalendarModel>> getMentorCalendar(
     String mentorId,String date) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.get, '${GlobalInfo.baseURL}calendar/$mentorId/$date',
            needAuth: true);
        print(response);
        var encode = jsonEncode(response);

        var data = mentorCalendarModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //****************************** add new calendar
  Future<Either<Failure, AddNewCalendarModel>> addNewCalendar(
     Map<String,dynamic> body,String userId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}calendar/$userId',
            needAuth: true,body: body);
        print(response);
        var encode = jsonEncode(response);

        var data = addNewCalendarModelFromJson(encode);

        return data.ok == true ? Right(data) : Left(ApiFailure("نشد"));
      } catch (e) {
        print("getProfile error: $e \n");
        return Left(ApiFailure("خطای بارگذاری اطلاعات"));
      }
    }
  }
  //********************************* delete calendar
  Future<Either<Failure, EditModel>> deleteCalendar(
      String userId,String calendarId) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.delete, '${GlobalInfo.baseURL}calendar/$userId/$calendarId',
            needAuth: true,body: {});
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

  //************************ update calendar
  Future<Either<Failure, EditModel>> updateCalendar(
      String userId,String calendarId,Map<String,dynamic> body) async {
    if (!await DataConnectionChecker.hasConnection) {
      return Left(ConnectionFailure());
    } else {
      try {
        var response = await HttpServices.request(
            RequestType.put, '${GlobalInfo.baseURL}calendar/$userId/$calendarId',
            needAuth: true,body: body);
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