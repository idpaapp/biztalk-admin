import 'package:biztalk_panel_admin/model/all_request_session_model.dart';
import 'package:biztalk_panel_admin/service/mentor_repository.dart';
import 'package:get/get.dart';
class RequestSessionController extends GetxController{
  final MentorRepository _mentorRepository =Get.find<MentorRepository>();
  RxInt selectedPage=1.obs;
  RxInt typeSelectedFilter =0.obs;
  RxList selectedStatus=[].obs;
  RxString selectedStartDateRequest="".obs;
  RxString selectedEndDateRequest="".obs;
  RxString selectedEndDateSession="".obs;
  RxString selectedStartDateSession="".obs;


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