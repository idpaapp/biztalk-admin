import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/edit_profile_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/left_column_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/right_column_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_controller.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController _fullName = TextEditingController();
final TextEditingController _userName = TextEditingController();
final TextEditingController _aboutMe = TextEditingController();
final TextEditingController _jobTitle = TextEditingController();
final TextEditingController _phone = TextEditingController();

final EditProfileController _editProfileController =
    Get.put(EditProfileController());

Future<void> showMyDialog(BuildContext context,
    {String? image,
    String? fullName,
    String? userType,
    String? userName,
    String? jobTitle,
    String? videoUrl,
    String? grade,
    String? id,
    String? phone,
    List<Skill>? kils,
    String? aboutMe}) async {
  if (videoUrl == null) {
    _editProfileController.activeVideo.value = false;
  } else {
    _editProfileController.activeVideo.value = true;

    _editProfileController.initializePlayer(videoUrl);
  }
  _userName.text = userName ?? "";
  _fullName.text = fullName ?? "";
  _jobTitle.text = jobTitle ?? "";
  _editProfileController.gradeTitle.value = grade ?? "مبتدی";
  _aboutMe.text = aboutMe ?? "";
  _phone.text = phone ?? "";

  _editProfileController.finallySelectId.clear();
  _editProfileController.finallySelectTitle.clear();
  _editProfileController.selectedChoicesId.clear();
  _editProfileController.selectedChoicesTitle.clear();
  if (kils!.isNotEmpty) {
    kils.forEach((element) {
      _editProfileController.finallySelectId.add(element.id);
      _editProfileController.finallySelectTitle.add(element.title);
    });
  }
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
        title: TitleWidget(
          title: "ویرایش اطلاعات",
        ),
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width * 0.7,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RightColumnWidget(
                      fullName: _fullName,
                      onDeleteImage: () {
                        confirmDialog(context,
                            title: "آیا برای حذف تصویر اطمینان دارید؟",
                            onConfirm: () {
                          _editProfileController.removeImage.value = true;
                          Get.back();
                        });
                      },
                      image: image,
                      userName: _userName,
                      phone: _phone),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  LeftColumnWidget(
                      aboutMe: _aboutMe, jobTitle: _jobTitle, id: id),
                ],
              )),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.dividerDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                    MyAlert.loding();
                    Map<String, dynamic> body = {
                      "removeImage": _editProfileController.removeImage.value,
                      "fullName": _fullName.text,
                      "userName": _userName.text,
                      "phone": _phone.text,
                      "mentorData": {
                        "jobTitle": _jobTitle.text,
                        "grade":
                            _editProfileController.gradeTitle.value == "مبتدی"
                                ? "beginner"
                                : _editProfileController.gradeTitle.value ==
                                        "حرفه ای"
                                    ? "professional"
                                    : _editProfileController.gradeTitle.value ==
                                            "متخصص"
                                        ? "expert"
                                        : "",
                        "skills": _editProfileController.finallySelectId,
                        "description": _aboutMe.text
                      }
                    };
                    await _editProfileController.updateProfile(body, id);
                    Get.back();

                    if (_editProfileController.resultEditProfile.value.ok ==
                        true) {
                      Get.lazyReplace(() => SingleMentorController());

                      Get.offAndToNamed(SingleMentorPage.route,
                          arguments: {"id": id, "userType": userType});
                    } else {
                      MyAlert.mySnakbarRed(text: "خطا");
                    }
                  },
                  text: "ذخیره",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                  bgColor: AppColors.disabledGrey,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
