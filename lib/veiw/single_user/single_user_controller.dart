import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/mentro/user_model.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:get/get.dart';
class SingleUserController extends GetxController{
  final HomeRepository _homeRepo = Get.find<HomeRepository>();
   RxBool switchValue=false.obs;
  RxInt selectedPage =1.obs;




  RxString failureMessageFetchUser = "".obs;
  RxBool isLoadingFetchUser = false.obs;
  var resultFetchUser = UserModel().obs;

  fetchUser(String id) async {
    failureMessageFetchUser.value = "";
    isLoadingFetchUser.value = true;
    final result = await  _homeRepo.getUser(id);
    result.fold(
          (left) {
        failureMessageFetchUser.value = left.message;
      },
          (right) {
        resultFetchUser.value = right;
        isLoadingFetchUser.value = false;
      },
    );
  }


  RxString failureMessageChangeStatus = "".obs;
  RxBool isLoadingChangeStatus = false.obs;
  var resultChangeStatus = EditModel().obs;

  changeStatus(String id,String status) async {
    failureMessageChangeStatus.value = "";
    isLoadingChangeStatus.value = true;
    final result = await _homeRepo.changeUserStatus(id, status);
    result.fold(
          (left) {
        failureMessageChangeStatus.value = left.message;
      },
          (right) {
        resultChangeStatus.value = right;
        isLoadingChangeStatus.value = false;
      },
    );
  }

}