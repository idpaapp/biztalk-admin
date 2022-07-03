import 'package:biztalk_panel_admin/model/category/category_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleMentorController extends GetxController{
  final HomeRepository _homeRepo = Get.find<HomeRepository>();
RxInt selectedChangeUser=0.obs;
  RxInt selectedPage =0.obs;
  RxBool switchValue=false.obs;

  RxString failureMessageFetchUser = "".obs;
  RxBool isLoadingFetchUser = false.obs;
  var resultFetchUser = MentorModel().obs;

  fetchMentor(String id) async {
    failureMessageFetchUser.value = "";
    isLoadingFetchUser.value = true;
    final result = await _homeRepo.getMentor(id);
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


  //************************** get categoury

  RxString  failureMessageCategory ="".obs;
  var resultCategory = CategoryModel().obs;
  RxBool isLoadingCategory = false.obs;

  Future<void> fetchCategory(
      ) async {
    isLoadingCategory.value = true;
    final result = await _homeRepo.getCategory();
    result.fold(
          (left) {
        failureMessageCategory.value = left.message;
      },
          (right) {
        resultCategory.value = right;
        isLoadingCategory.value=false;

      },
    );
  }
  //**********************
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
  @override
  void onInit() {

    fetchCategory();// TODO: implement onInit
    super.onInit();
  }
}