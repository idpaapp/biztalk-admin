import 'package:biztalk_panel_admin/model/comment_model.dart';
import 'package:biztalk_panel_admin/model/get_answers_model.dart';
import 'package:biztalk_panel_admin/service/manager_repository.dart';
import 'package:get/get.dart';
class CommentController extends GetxController{
  final ManagerRepository _managerRepository =Get.find<ManagerRepository>();
  //************************ get comments
  RxInt selectedPage=1.obs;
  RxString failureMessageGetComments = "".obs;
  var resultagGetComments = CommentsModel().obs;
  RxBool isLoadingageGetComments = false.obs;

  getComments(int page,String mentorId) async {
    failureMessageGetComments.value = "";
    isLoadingageGetComments.value = true;
    final result = await _managerRepository.getComment(page,mentorId);
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
  //********************************** get answer
  RxString failureMessageGetAnswers = "".obs;
  var resultGetAnswers = GetAnswersModel().obs;
  RxBool isLoadingGetAnswers = false.obs;

  getAnswers(String questionId) async {
    failureMessageGetAnswers.value = "";
    isLoadingGetAnswers.value = true;
    final result = await _managerRepository.getAnswers(questionId);
    result.fold(
          (left) {
            failureMessageGetAnswers.value = left.message;
      },
          (right) {
            resultGetAnswers.value = right;
            isLoadingGetAnswers.value = false;
      },
    );
  }
  
  
  
  
  
}