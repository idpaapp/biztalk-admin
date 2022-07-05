import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController phone = TextEditingController();
final TextEditingController fullName = TextEditingController();
final TextEditingController userName = TextEditingController();
final HomeController _homeController = Get.put(HomeController());

Future<void> insertUser(
  BuildContext context,
  String title,
) async {
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
            size: 4,
            title: title,
           ),
        content: SizedBox(
          height: Get.height * 0.45,
          width: Get.width * 0.3,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextFieldWidget(
                    title: "شماره همراه",
                    editingController: phone,
                    hint: "شماره همراه",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  TitleTextFieldWidget(
                    title: "نام و نام خانوادگی",
                    editingController: fullName,
                    hint: "نام و نام خانوادگی",
                  ),
                  const SizedBox(height: 24),
                  TitleTextFieldWidget(
                    title: "نام کاربری",
                    editingController: userName,
                    hint: "نام کاربری",
                  ),
                  const SizedBox(height: 24),


                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10, horizontal:Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                    if (phone.text.trim() == "" ||
                        userName.text.trim() == "" ||
                        fullName.text.trim() == ""
                    ) {
                      MyAlert.mySnakbarRed(
                          text: "وارد کردن تمامی فیلد ها اجباذی است");

                      return;
                    }
                    Map<String, dynamic> body = {
                      "phoneNumber": phone.text,
                      "fullName": fullName.text,
                      "userName": userName.text,
                    };
                    MyAlert.loding();
                    await _homeController.addUser(body);
                    Get.back();
                    if(_homeController.failureMessageAddUser.value !=""){
                      MyAlert.mySnakbarRed(text: _homeController.failureMessageAddUser.value);
                    }else{
                      Get.back();
                      _homeController.fetchUsers(1);
                    }
                  },
                  text: "ذخیره",
                  borderRadios: 10,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width*0.1,
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
          )






        ],
      );
    },
  );
}
