import 'package:biztalk_panel_admin/model/all_request_session_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/service/mentor_repository.dart';
import 'package:get/get.dart';
class RequestSessionController extends GetxController{
  final MentorRepository _mentorRepository =Get.find<MentorRepository>();
  RxInt selectedPage=1.obs;
  RxInt typeSelectedFilter =0.obs;
  RxList selectedStatus= ["draft", "confirmed", "reserved", "completed"].obs;
  RxString selectedStartDateRequest="انتخاب کنید".obs;
  RxString selectedEndDateRequest="انتخاب کنید".obs;
  RxString selectedEndDateSession="انتخاب کنید".obs;
  RxString selectedStartDateSession="انتخاب کنید".obs;
  RxString selectedTypeUser="کاربر".obs;
deleteData(){
  selectedPage.value=1;
  selectedStartDateRequest.value="انتخاب کنید";
  selectedEndDateRequest.value="انتخاب کنید";
  selectedEndDateSession.value="انتخاب کنید";
  selectedStartDateSession.value="انتخاب کنید";
  selectedStatus.clear();
  selectedStatus.add("draft");
  selectedStatus.add("confirmed");
  selectedStatus.add("reserved");
  selectedStatus.add("completed");


}

  RxString failureMessageGetAll = "".obs;
  RxBool isLoadingGetAll = false.obs;
  var resultGetAll = AllRequestSessionModel().obs;

  getAllRequestSession(Map<String, dynamic> body, String userId) async {
    failureMessageGetAll.value = "";
    isLoadingGetAll.value = true;
    final result = await _mentorRepository.getAllRequestSession(body, userId);
    result.fold(
          (left) {
        failureMessageGetAll.value = left.message;
      },
          (right) {
        resultGetAll.value = right;
        isLoadingGetAll.value = false;
      },
    );
  }
  //************************************* cancel session

  RxString failureMessageCancelSession = "".obs;
  RxBool isLoadingCancelSession = false.obs;
  var resultCancelSession = EditModel().obs;

  cancelSession(Map<String, dynamic> body, String sessionId) async {
    failureMessageCancelSession.value = "";
    isLoadingCancelSession.value = true;
    final result = await _mentorRepository.cancelSession(body, sessionId);
    result.fold(
          (left) {
            failureMessageCancelSession.value = left.message;
      },
          (right) {
            resultCancelSession.value = right;
        isLoadingCancelSession.value = false;
      },
    );
  }

  //************************************* cancel request

  RxString failureMessageCancelRequest = "".obs;
  RxBool isLoadingCancelRequest = false.obs;
  var resultCancelRequest = EditModel().obs;

  cancelRequest( String sessionId) async {
    failureMessageCancelRequest.value = "";
    isLoadingCancelRequest.value = true;
    final result = await _mentorRepository.cancelRequest(sessionId);
    result.fold(
          (left) {
            failureMessageCancelRequest.value = left.message;
      },
          (right) {
            resultCancelRequest.value = right;
        isLoadingCancelRequest.value = false;
      },
    );
  }
}