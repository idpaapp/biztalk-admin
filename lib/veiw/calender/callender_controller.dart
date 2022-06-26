import 'package:biztalk_panel_admin/model/calendar/add_new_calendar_model.dart';
import 'package:biztalk_panel_admin/model/calendar/mentor_calendar_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/service/calendar_repository.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController{
  RxString selectedDate ="".obs;

  final CalendarRepository _calendarRepo = Get.find<CalendarRepository>();

  //****************** get contact
  RxString  failureMessageGetCalendar ="".obs;
  var resultGetCalendar = MentorCalendarModel().obs;
  RxBool isLoadingGetCalendar = false.obs;

  fetchCalendar(String mentorId,String date) async {
    isLoadingGetCalendar.value = true;
    final result = await _calendarRepo.getMentorCalendar(mentorId, date);
    result.fold(
          (left) {
        failureMessageGetCalendar.value = left.message;
      },
          (right) {
        resultGetCalendar.value = right;
        isLoadingGetCalendar.value=false;

      },
    );
  }
  //************************************************ add new calendar
  RxString  failureMessageAddCalendar ="".obs;
  var resultAddCalendar = AddNewCalendarModel().obs;
  RxBool isLoadingAddCalendar = false.obs;

  addCalendar(Map<String,dynamic> body,String userId) async {
    isLoadingAddCalendar.value = true;
    final result = await _calendarRepo.addNewCalendar(body, userId);
    result.fold(
          (left) {
            failureMessageAddCalendar.value = left.message;
      },
          (right) {
            resultAddCalendar.value = right;
        isLoadingAddCalendar.value=false;

      },
    );
  }
  //*************************************************** delete calendar
  RxString  failureMessageDeleteCalendar ="".obs;
  var resultDeleteCalendar = EditModel().obs;
  RxBool isLoadingDeleteCalendar = false.obs;

  deleteCalendar(String userId,String calendarId) async {
    isLoadingDeleteCalendar.value = true;
    final result = await _calendarRepo.deleteCalendar(userId, calendarId);
    result.fold(
          (left) {
            failureMessageDeleteCalendar.value = left.message;
      },
          (right) {
            resultDeleteCalendar.value = right;
        isLoadingDeleteCalendar.value=false;

      },
    );
  }
//**************** update calendar

  RxString  failureMessageUpdateCalendar ="".obs;
  var resultUpdateCalendar = EditModel().obs;
  RxBool isLoadingUpdateCalendar = false.obs;

  updateCalendar(String userId,String calendarId,Map<String,dynamic> body) async {
    isLoadingUpdateCalendar.value = true;
    final result = await _calendarRepo.updateCalendar(userId, calendarId,body);
    result.fold(
          (left) {
            failureMessageUpdateCalendar.value = left.message;
      },
          (right) {
            resultUpdateCalendar.value = right;
        isLoadingUpdateCalendar.value=false;

      },
    );
  }

}