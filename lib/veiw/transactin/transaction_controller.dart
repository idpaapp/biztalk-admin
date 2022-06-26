import 'package:biztalk_panel_admin/model/transaction/transaction_model.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:get/get.dart';
class TransactionController extends GetxController{
  final HomeRepository _homeRepo = Get.find<HomeRepository>();

  RxInt selectedPage=1.obs;

  RxString  failureMessage ="".obs;
  var resultTransaction = TransactionModel().obs;
  RxBool isLoadingTransaction = false.obs;

  fetchTransaction(String id,int page
      ) async {
    isLoadingTransaction.value = true;
    final result = await _homeRepo.getTransaction(id, page);
    result.fold(
          (left) {
        failureMessage.value = left.message;
      },
          (right) {
        resultTransaction.value = right;
        isLoadingTransaction.value=false;

      },
    );
  }
}