import 'package:biztalk_panel_admin/model/transaction/not_verify_account_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:flutter/material.dart';

import '../edit_profile_dialog/title_widget.dart';
import 'package:get/get.dart';

Future<void> singleTransactionDialog(BuildContext context, String title,AccountDatum single,onConfirm) async {
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
            size: 1,
            title: title,
            ),
        content: Container(
          height: Get.height * 0.6,
          width: Get.width * 0.5,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  single.profileImageUrl == null ? CircleAvatar(
              radius: 50,
                backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
              ):CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(GlobalInfo.serverAddress + "/"+ single.profileImageUrl!),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RowTextWidget(title: "نام و نام خانوادگی :",subTitle:single.fullName??"",),SizedBox(height: 15,),
                  RowTextWidget(title: "نام کاربری :",subTitle: single.userName??"",),SizedBox(height: 15,),
                  RowTextWidget(title: "نوع کاربری :",subTitle: single.userType??"",),SizedBox(height: 15,),
                  RowTextWidget(title: "شبا :",subTitle: single.iban??"",),SizedBox(height: 15,),
                  RowTextWidget(title: "نام صاحب شبا :",subTitle: single.nameInBank??"",),SizedBox(height: 15,),
                  RowTextWidget(title: "بانک :",subTitle: single.bank!.name??"",),SizedBox(height: 15,),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonText(
                  onPressed: () {},
                  text: "استعلام",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.green,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonText(
                      onPressed: onConfirm,
                      text: "تایید",
                      borderRadios: 3,
                      fontWeight: FontWeight.w500,
                      height: 40,
                      width: Get.width * 0.1,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.blueBg,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ButtonText(
                      borderRadios: 3,
                      onPressed: () {
                        Get.back();
                      },
                      text: "عدم تایید",
                      height: 40,
                      width: Get.width * 0.1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      bgColor: AppColors.disabledGrey,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
