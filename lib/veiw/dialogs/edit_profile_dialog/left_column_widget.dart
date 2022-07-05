import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/delete_accept_widget.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                    },
                    child:   const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,)
                        ),
                  ),

                SizedBox(width: 12,),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TitleTextFieldWidget(
              title: "عنوان شغلی یا مهارت اصلی شما",
              hint: "عنوان شغلی ",
              editingController: jobTitle,
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                TitleTextFieldWidget(
                  title: "درباره من",
                  activeDelete: true,
                  hint: "درباره من",
                  maxLines: 6,
                    onConfirm: () {
                      changeStatuseMethod(
                          context: context,
                          title: "آیا برای تایید توضیحات اطمینان دارید؟",
                          type: "description",
                          confirm: true);
                    },
                  onDelete: () {
                    changeStatuseMethod(
                        context: context,
                        title: "آیا برای حذف توضیحات اطمینان دارید؟",
                        type: "description",
                        confirm: false);
                  } ,
                  editingController: aboutMe,
                ),

              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  color: AppColors.greyMiddle,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  title: "ویدیوی معرفی",
                ),
                DeleteAcceptWidget(

                  onConfirm: () {
                    changeStatuseMethod(
                        context: context,
                        title: "آیا برای تایید ویدیو اطمینان دارید؟",
                        type: "video",
                        confirm: true);
                  },

                  onDelete: () {
                    changeStatuseMethod(
                        context: context,
                        title: "آیا برای حذف ویدیو اطمینان دارید؟",
                        type: "video",
                        confirm: false);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),


            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.borderColor,
                      ),
                      color: Colors.white),
                  child: _editProfileController.activeVideo.value == false
                      ? const Center(
                          child: CustomText(
                              title: "ویدیو موجود نمی باشد", fontSize: 11),
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
          ],
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
