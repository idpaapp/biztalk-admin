import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditProfileController extends GetxController {
  final HomeRepository _homeRepo = Get.find<HomeRepository>();

  RxList selectedChoicesId = [].obs;
  RxList selectedChoicesTitle = [].obs;
  RxList finallySelectId = [].obs;
  RxList finallySelectTitle = [].obs;

  RxString gradeTitle = "مبتدی".obs;
  RxBool removeImage=false.obs;
  RxBool removeUserImage=false.obs;
  @override
  void onInit() {
    removeImage.value=false;
    removeUserImage.value=false;
    // TODO: implement onInit
    super.onInit();
  }


  //************************** EditProfile

  RxString  failureMessageEdit ="".obs;
  var resultEditProfile = EditModel().obs;
  RxBool isLoadingEditProfile = false.obs;

   updateProfile(Map<String,dynamic> body,String? id) async {
    isLoadingEditProfile.value = true;
    final result = await _homeRepo.editProfile(body, id!);
    result.fold(
          (left) {
        failureMessageEdit.value = left.message;
      },
          (right) {
        resultEditProfile.value = right;
        isLoadingEditProfile.value=false;

      },
    );
  }

  //******************************************* video
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  RxBool isLoadingGetVideo = false.obs;
  RxBool activeVideo = false.obs;


  initializePlayer(String url) async {
    isLoadingGetVideo.value = true;
    try {
      videoPlayerController = VideoPlayerController.network(GlobalInfo.serverAddress+"/"+url);
      await Future.wait([videoPlayerController.initialize()]);
      chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          looping: false,
          materialProgressColors: ChewieProgressColors(
              playedColor: AppColors.green,

              handleColor: AppColors.red,
              backgroundColor: AppColors.lighterBlack,
              bufferedColor: AppColors.darkerGrey),
          placeholder: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
          autoInitialize: false);
    } finally {
      isLoadingGetVideo.value = false;
    }
    update();
  }
  //************************* delete or confirm video and description
  RxString  failureMessageState="".obs;
  var resultStatusVideo = EditModel().obs;
  RxBool isLoadingStatus = false.obs;

  changeStatus(String id,String type,bool confirm) async {
    isLoadingStatus.value = true;
    final result = await _homeRepo.editVideo(id, type, confirm);
    result.fold(
          (left) {
            failureMessageState.value = left.message;
      },
          (right) {
            resultStatusVideo.value = right;
            isLoadingStatus.value=false;

      },
    );
  }

}
