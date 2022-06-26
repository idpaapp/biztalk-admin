import 'package:biztalk_panel_admin/model/category/category_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/off/create_off_model.dart';
import 'package:biztalk_panel_admin/model/off/get_off_model.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OffController extends GetxController {
  final HomeRepository _homeRepo = Get.find<HomeRepository>();
  RxInt selectedCategory = 0.obs;
  RxInt selectedType = 0.obs;
  RxString startDate = "انتخاب کنید".obs;
  RxString endDate = "انتخاب کنید".obs;

  RxString selectedCategoryId = "".obs;
  deleteData(){
    startDate.value="انتخاب کنید";
    endDate.value="انتخاب کنید";
    selectedCategoryId.value="";
    precent.value.text="";
    amount.value.text="";
    top.value.text="";
    code.value.text="";
    selectedCategory.value=0;
    selectedType.value=0;
  }

  var precent = TextEditingController().obs;
  var amount = TextEditingController().obs;
  var top = TextEditingController().obs;
  var code = TextEditingController().obs;

  RxString failureMessageCategory = "".obs;
  var resultCategory = CategoryModel().obs;
  RxBool isLoadingCategory = false.obs;

  fetchCategory() async {
    failureMessageCategory.value = "";
    isLoadingCategory.value = true;
    final result = await _homeRepo.getCategory();
    result.fold(
      (left) {
        failureMessageCategory.value = left.message;
      },
      (right) {
        resultCategory.value = right;
        isLoadingCategory.value = false;
      },
    );
  }

//************** create off

  RxString failureMessageCreateOff = "".obs;
  var resultCreateOff = CreateOffCodeModel().obs;
  RxBool isLoadingCreateOff = false.obs;

  createOff(Map<String, dynamic> body) async {
    failureMessageCreateOff.value = "";
    isLoadingCreateOff.value = true;
    final result = await _homeRepo.createOff(body);
    result.fold(
      (left) {
        failureMessageCreateOff.value = left.message;
      },
      (right) {
        resultCreateOff.value = right;
        isLoadingCreateOff.value = false;
      },
    );
  }//************** get all off code

  RxString failureMessageAllOffCode = "".obs;
  var resultAllOffCode = GetOffModel().obs;
  RxBool isLoadingAllOffCode = false.obs;

  allOffCode() async {
    failureMessageAllOffCode.value = "";
    isLoadingAllOffCode.value = true;
    final result = await _homeRepo.allOffCode();
    result.fold(
      (left) {
        failureMessageAllOffCode.value = left.message;
      },
      (right) {
        resultAllOffCode.value = right;
        isLoadingAllOffCode.value = false;
      },
    );
  }
  //***************************** delete off
  //************** get all off code

  RxString failureMessageDeleteOff = "".obs;
  var resultDeleteOff = EditModel().obs;
  RxBool isLoadingDeleteOff = false.obs;

  deleteOff(String id) async {
    failureMessageDeleteOff.value = "";
    isLoadingDeleteOff.value = true;
    final result = await _homeRepo.deleteOff(id);
    result.fold(
          (left) {
            failureMessageDeleteOff.value = left.message;
      },
          (right) {
            resultDeleteOff.value = right;
            isLoadingDeleteOff.value = false;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
