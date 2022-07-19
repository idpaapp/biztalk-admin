import 'package:biztalk_panel_admin/model/all_request_session_model.dart';
import 'package:biztalk_panel_admin/service/mentor_repository.dart';
import 'package:get/get.dart';
class RequestSessionController extends GetxController{
  final MentorRepository _mentorRepository =Get.find<MentorRepository>();
  RxInt selectedPage=1.obs;
  RxInt typeSelectedFilter =0.obs;
  RxList selectedStatus=[].obs;
  RxString selectedStartDateRequest="انتخاب کنید".obs;
  RxString selectedEndDateRequest="انتخاب کنید".obs;
  RxString selectedEndDateSession="انتخاب کنید".obs;
  RxString selectedStartDateSession="انتخاب کنید".obs;
deleteData(){
  selectedStatus.clear();
  selectedPage.value=1;
  selectedStartDateRequest.value="انتخاب کنید";
  selectedEndDateRequest.value="انتخاب کنید";
  selectedEndDateSession.value="انتخاب کنید";
  selectedStartDateSession.value="انتخاب کنید";


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
}