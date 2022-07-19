import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> confirmDialog(BuildContext context,
    {String? title,onConfirm}) async {


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
            size: 4,
            title: "توجه",
           ),
        content: SizedBox(
          height: Get.height * 0.2,
          width: Get.width * 0.3,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(title:title ,color: AppColors.lighterBlack,fontSize: 18,)




                ],
              )),
        ),
        actions: <Widget>[
          Padding(            padding:  EdgeInsets.symmetric(vertical: 10, horizontal:Get.width * 0.02),
          child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
            ButtonText(
              onPressed: onConfirm,
              text: "تایید",
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
          ]),
          ),




        ],
      );
    },
  );

}


