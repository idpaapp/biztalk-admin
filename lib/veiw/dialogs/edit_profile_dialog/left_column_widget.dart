import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/edit_profile_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';

class LeftColumnWidget extends StatelessWidget {
  final TextEditingController? aboutMe;
  final String? id;

  TextEditingController? jobTitle;

  LeftColumnWidget({Key? key, this.aboutMe, this.jobTitle, this.id})
      : super(key: key);
  final EditProfileController _editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.12,
              ),
              TitleTextFieldWidget(
                title: "عنوان شغلی یا مهارت اصلی شما",
                editingController: jobTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              TitleTextFieldWidget(
                title: "درباره من",
                maxLines: 3,
                editingController: aboutMe,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ButtonText(
                      onPressed: () {
                        changeStatuseMethod(
                            context: context,
                            title: "آیا برای تایید توضیحات اطمینان دارید؟",
                            type: "description",
                            confirm: true);
                      },
                      text: "تایید",
                      height: 30,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.darkerGreen,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonText(
                      onPressed: () {
                        changeStatuseMethod(
                            context: context,
                            title: "آیا برای حذف توضیحات اطمینان دارید؟",
                            type: "description",
                            confirm: false);
                      },
                      text: "حذف ",
                      height: 30,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: CustomText(
                  color: AppColors.lighterBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  title: "ویدیوی معرفی",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: Get.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.dividerDark,
                        ),
                        color: AppColors.veryLightGrey),
                    child: _editProfileController.activeVideo.value == false 
                        ? const Center(
                            child: CustomText(title: "ویدیو موجود نمی باشد",fontSize: 11),
                          )
                        : _editProfileController.isLoadingGetVideo.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Chewie(
                                  controller:
                                      _editProfileController.chewieController!,
                                ),
                              ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ButtonText(
                      onPressed: () {
                        changeStatuseMethod(
                            context: context,
                            title: "آیا برای تایید ویدیو اطمینان دارید؟",
                            type: "video",
                            confirm: true);
                      },
                      text: "تایید",
                      height: 30,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.darkerGreen,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonText(
                      onPressed: () {
                        changeStatuseMethod(
                            context: context,
                            title: "آیا برای حذف ویدیو اطمینان دارید؟",
                            type: "video",
                            confirm: false);
                      },
                      text: "حذف ",
                      height: 30,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  changeStatuseMethod(
      {BuildContext? context, String? title, String? type, bool? confirm}) {
    confirmDialog(context!, title: title, onConfirm: () async {
      MyAlert.loding();
      await _editProfileController.changeStatus(id!, type!, confirm!);
      Get.back();
      Get.back();

      if (_editProfileController.resultStatusVideo.value.ok == true) {
        MyAlert.mySnakbar(
            title: "عملیات موفق",
            text: _editProfileController.resultStatusVideo.value.message ?? "");
      } else {
        MyAlert.mySnakbarRed(
            text: _editProfileController.resultStatusVideo.value.message ??
                "ویدیویی از کاربر بارگذاری نشده");
      }
    });
  }
}
