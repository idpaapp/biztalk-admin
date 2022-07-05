import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/delete_accept_widget.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/edit_profile_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/show_image/show_image_dialog.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../edit_profile_dialog/title_text_field_widget.dart';

final TextEditingController _fullName = TextEditingController();
final TextEditingController _userName = TextEditingController();
final TextEditingController _phone = TextEditingController();
final EditProfileController _editProfileController =
    Get.put(EditProfileController());

Future<void> editUserProfile(BuildContext context,
    {String? image,
    String? fullName,
    String? id,
    String? phone,
    String? userName,
    onConfirmImage}) async {
  _userName.text = userName!;
  _fullName.text = fullName!;
  _phone.text = phone!;
  _editProfileController.removeUserImage.value = false;

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: const TitleWidget(
          size: 1,
          title: "ویرایش اطلاعات",
        ),
        content: SizedBox(
          height: Get.height * 0.6,
          width: Get.width * 0.5,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageSection(context, image!, onConfirmImage),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleTextFieldWidget(
                    title: "نام و نام خانوادگی",
                    editingController: _fullName,
                    hint: "نام و نام خانوادگی",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleTextFieldWidget(
                    title: "نام کاربری",
                    editingController: _userName,
                    hint: "نام کاربری",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleTextFieldWidget(
                    title: "تلفن همراه",
                    editingController: _phone,
                    hint: "تلفن همراه",
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                    MyAlert.loding();
                    Map<String, dynamic> body = {
                      "removeImage": false,
                      "fullName": _fullName.text,
                      "userName": _userName.text,
                      "phone": _phone.text
                    };

                    await _editProfileController.updateProfile(body, id);
                    if (_editProfileController.resultEditProfile.value.ok ==
                        true) {
                      Get.back();

                      Get.offAndToNamed(SingleUserPage.route,
                          arguments: {"id": id});
                    } else {
                      Get.back();
                      MyAlert.mySnakbarRed(text: "خطا");
                    }
                  },
                  text: "ذخیره",
                  borderRadios: 10,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueSession,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 10,
                  onPressed: () {
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  fontSize: 14,
                  width: 70,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.blueSession,
                  bgColor: Colors.white,
                  borderColor: AppColors.blueSession,
                  activeBorder: 1,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget imageSection(BuildContext context, String image, onConfirmImage) =>
    Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              if (image == "") {
                return;
              }
              showImage(context, "نمایش تصویر", image);
            },
            child: Obx(() => Center(
                  child: _editProfileController.removeUserImage.value ||
                          image == ""
                      ? const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          backgroundImage: AssetImage(
                              "assets/images/avatar_placeholder.png"))
                      : CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              GlobalInfo.serverAddress + "/" + image)),
                )),
          ),
        ),
        Expanded(
          flex: 2,
          child: DeleteAcceptWidget(
            onConfirm: onConfirmImage,
            onDelete: () {
              if (_editProfileController.removeUserImage.value ||
                  image == "") {
                return;
              }
              confirmDialog(context,
                  title: "آیا برای حذف تصویر اطمینان دارید؟", onConfirm: () {
                _editProfileController.removeUserImage.value = true;
                Get.back();
              });
            },
          ),
        ),
      ],
    );

void onSave() {

}
