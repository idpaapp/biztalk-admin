import 'package:biztalk_panel_admin/model/get_all_bank_model.dart';
import 'package:biztalk_panel_admin/model/iban_inquiry_model.dart';
import 'package:biztalk_panel_admin/service/repository.dart';
import 'package:get/get.dart';

class BankAccountController extends GetxController{
RxString accountName="".obs;
RxString selectedBankId="".obs;
final Repository _repository=Get.find();

RxString failureMessageCheckIban = "".obs;
var resultCheckIban = IbanInquiryModel().obs;
RxBool isLoadingCheckIban = false.obs;

checkIban(String iban) async {
  failureMessageCheckIban.value = "";
  isLoadingCheckIban.value = true;
  final result = await _repository.checkIban(iban);
  result.fold(
        (left) {
      failureMessageCheckIban.value = left.message;
    },
        (right) {
      resultCheckIban.value = right;
      isLoadingCheckIban.value = false;
    },
  );
}
//************************** get banks

  RxString failureMessageGetBank = "".obs;
  var resultGetBank = AllBankModel().obs;
  RxBool isLoadingGetBank = false.obs;

  getBanks() async {
    failureMessageGetBank.value = "";
    isLoadingGetBank.value = true;
    final result = await _repository.getBanks();
    result.fold(
          (left) {
            failureMessageGetBank.value = left.message;
      },
          (right) {
            resultGetBank.value = right;
            isLoadingGetBank.value = false;
      },
    );
  }
}