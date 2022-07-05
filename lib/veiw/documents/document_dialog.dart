import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> DocumentDialog(BuildContext context,
    {Widget? content, onSave, String? title,bool activeBTN=false}) async {
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
          title: title!,
          size:2 ,
        ),
        content: SizedBox(
            height: Get.height * 0.45,
            width: Get.width * 0.4,
        child: content),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                activeBTN ? SizedBox(height: 0,):  ButtonText(
                  onPressed: onSave,
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
          )
        ],
      );
    },
  );
}
