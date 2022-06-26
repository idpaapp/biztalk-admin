import 'dart:convert';

import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/home/all_banner_model.dart';
import 'package:biztalk_panel_admin/service/manager_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManagerPageController extends GetxController {
  final ManagerRepository _managerRepository = Get.find<ManagerRepository>();
  RxString selectedDropDownValue = "بازکردن لینک".obs;
  RxBool switchActive = false.obs;
  RxString titleSwitch = "غیر فعال".obs;

  clearData() {
    selectedImagedPath.value = "";
    base64File.value = "";
    nameImage.value = "";

    isLink.value = true;
  }

  RxString selectedImagedPath = ''.obs;
  RxString base64File = ''.obs;
  RxString nameImage = ''.obs;
  RxBool isLink = true.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 80);
    if (pickedFile != null) {
      selectedImagedPath.value = pickedFile.path;
      nameImage.value = pickedFile.name;
      var byteData = await pickedFile.readAsBytes();
      var buffer = byteData.buffer.asUint8List();
      base64File.value = base64Encode(buffer);
      print(base64File.value);
    }
  }

  //***************************************** create link

  RxString failureMessageCreateBanner = "".obs;
  RxBool isLoadingCreateBanner = false.obs;
  var resultCreateBanner = EditModel().obs;

  createBanner(Map<String, dynamic> body) async {
    failureMessageCreateBanner.value = "";
    isLoadingCreateBanner.value = true;
    final result = await _managerRepository.createBanner(body);
    result.fold(
      (left) {
        failureMessageCreateBanner.value = left.message;
      },
      (right) {
        resultCreateBanner.value = right;
        isLoadingCreateBanner.value = false;
      },
    );
  } //***************************************** edit link

  RxString failureMessageEditBanner = "".obs;
  RxBool isLoadingEditBanner = false.obs;
  var resultEditBanner = EditModel().obs;

  editBanner(String id,Map<String,dynamic> body) async {
    failureMessageEditBanner.value = "";
    isLoadingEditBanner.value = true;
    final result = await _managerRepository.editBanner(id,body);
    result.fold(
      (left) {
        failureMessageEditBanner.value = left.message;
      },
      (right) {
        resultEditBanner.value = right;
        isLoadingEditBanner.value = false;
      },
    );
  }

  //***************************************** get banner

  RxString failureMessageGetBanner = "".obs;
  RxBool isLoadingGetBanner = false.obs;
  var resultGetBanner = AllBannerModel().obs;

  getBanner() async {
    failureMessageGetBanner.value = "";
    isLoadingGetBanner.value = true;
    final result = await _managerRepository.getBanners();
    result.fold(
      (left) {
        failureMessageGetBanner.value = left.message;
      },
      (right) {
        resultGetBanner.value = right;
        isLoadingGetBanner.value = false;
      },
    );
  }

  //********************************* delete banner
  RxString failureMessageDeleteBanner = "".obs;
  RxBool isLoadingDeleteBanner = false.obs;
  var resultDeleteBanner = EditModel().obs;

  deletBanner(String id) async {
    failureMessageDeleteBanner.value = "";
    isLoadingDeleteBanner.value = true;
    final result = await _managerRepository.deleteBanner(id);
    result.fold(
      (left) {
        failureMessageDeleteBanner.value = left.message;
      },
      (right) {
        resultDeleteBanner.value = right;
        isLoadingDeleteBanner.value = false;
      },
    );
  }
}
