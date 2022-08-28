import 'package:biztalk_panel_admin/model/comment_model.dart';
import 'package:biztalk_panel_admin/service/manager_repository.dart';
import 'package:get/get.dart';
class CommentController extends GetxController{
  final ManagerRepository _managerRepository =Get.find<ManagerRepository>();
  //************************ get comments
  RxString failureMessageGetComments = "".obs;
  var resultagGetComments = CommentsModel().obs;
  RxBool isLoadingageGetComments = false.obs;

  getComments() async {
    failureMessageGetComments.value = "";
    isLoadingageGetComments.value = true;
    final result = await _managerRepository.getComment();
    result.fold(
          (left) {
        failureMessageGetComments.value = left.message;
      },
          (right) {
        resultagGetComments.value = right;
        isLoadingageGetComments.value = false;
      },
    );
  }
  @override
  void onInit() {
    getComments();
    // TODO: implement onInit
    super.onInit();
  }
}