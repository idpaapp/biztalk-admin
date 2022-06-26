import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTitleTableWidget extends StatelessWidget {
  final String? subject;
  final String? createDate;
  final String? userName;
  final String? stateTitle;
  final String? state;
  final String? sessionDate;
  final bool? isTitle;
  final onTap;

  const ProfileTitleTableWidget({Key? key,
    this.onTap,
    this.userName,
    this.createDate,
    this.subject,
    this.stateTitle, this.state,
    this.isTitle, this.sessionDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: isTitle == true
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: subject),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: createDate),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: userName),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: state == 'pink' ? AppColors.pink : state == 'red'
                          ? AppColors.red
                          : state == 'confirmed'?AppColors.tosi:Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.01,vertical: Get.height*0.003),
                    child: CustomText(
                        fontSize: isTitle == true ? 16 : 12,
                        color: state == null? AppColors.black:Colors.white,
                        fontWeight: FontWeight.w500,
                        title: stateTitle),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: sessionDate),
            ),
          ],
        ),
      );
}
