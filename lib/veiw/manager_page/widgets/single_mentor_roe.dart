import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleMentorRow extends StatelessWidget {
  final String? fullName;
  final String? userName;
  final String? phoneNumber;
  final String? image;
  final bool? isTitle;
  final Color bgColor;
  final onTap;
 final String titleBtn;
 final Color btnColor;

  const SingleMentorRow(
      {Key? key,
        this.onTap,
        this.bgColor=Colors.white,
        this.userName,
        this.fullName,
        this.btnColor= AppColors.lighterBlack,
        this.titleBtn="افزودن",
        this.phoneNumber,
        this.image,
        this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    decoration: BoxDecoration(
      color: bgColor,
      border: Border(
        bottom: BorderSide(
            color: isTitle == true
                ? AppColors.dividerDark
                : AppColors.dividerLight),
      ),
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: isTitle == true
                  ? Container()
                  : image == ""
                  ? const Center(
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(

                        "assets/images/avatar_placeholder.png")),
              )
                  : Center(
                child: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(GlobalInfo.serverAddress +"/"+ image!)),
              )),
          Expanded(
            flex: 2,
            child: CustomText(
                fontSize: isTitle == true ? 16 : 14,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                title: fullName),
          ),

          Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: userName)),
          Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: phoneNumber)),
          Expanded(
              flex: 2,
              child: isTitle == true
                  ? Container()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonText(
                    onPressed: onTap,
                    width: Get.width * 0.06,
                    height: Get.height * 0.035,
                    fontSize: 13,
                    text: titleBtn,
                    bgColor: btnColor,
                    fontWeight: FontWeight.w500,
                    textColor:Colors.white,
                    activeBorder: 1,
                    margin: EdgeInsets.only(left: Get.width * 0.02),
                  )
                ],
              )),
        ],
      ),
    ),
  );
}
