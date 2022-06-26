import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowBankWidget extends StatelessWidget {
  final String? oneColumn;
  final String? twoColumn;
  final String? threeColumn;
  final String? shebaNumber;
  final String? fourColumn;
  final String? fiveColumn;
  final String? sixColumn;
  final bool? isTitle;
  final bool? status;
  final onTap;
  final bool isCheckList;
  final bool isRequestList;
  final bool isSessionList;
  final bool isReportList;

  const RowBankWidget(
      {Key? key,
        this.fiveColumn,
        this.isCheckList =false,
        this.isReportList =false,
        this.fourColumn,
        this.sixColumn,
        this.status,
        this.twoColumn,
        this.oneColumn,
        this.isRequestList = false,
        this.threeColumn,
        this.onTap,
        this.shebaNumber,
        this.isSessionList =false,
        this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
            color: isTitle == true
                ? AppColors.dividerDark
                : AppColors.dividerLight),
      ),
    ),
    child: InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: oneColumn),
            ),
            Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: isTitle == true ? 16 : 14,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.blueIndigo,
                    fontWeight: FontWeight.w500,
                    title: twoColumn)),
            Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: isTitle == true ? 16 : 14,
                    color: isTitle == true
                        ? AppColors.lighterBlack

                        : AppColors.dividerDark,
                    fontWeight: FontWeight.w500,
                    title: threeColumn??"")),
            isSessionList == true? SizedBox(height: 0,):  isReportList == true? SizedBox(height: 0,):    isRequestList == true? SizedBox(height: 0,):  isCheckList == true ? SizedBox(height: 0,): Expanded(
                flex: 3,
                child: CustomText(
                    fontSize: 16,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.black,

                    fontWeight: FontWeight.w500,
                    title: shebaNumber??"")),
           Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: 16,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.black,

                    fontWeight: FontWeight.w500,
                    title: fourColumn)),
            isReportList == true? SizedBox(height: 0,):Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: 16,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.black,

                    fontWeight: FontWeight.w500,
                    title: fiveColumn??"")),
            isReportList == true? SizedBox(height: 0,):  isRequestList == true? SizedBox(height: 0,):  isCheckList != true ? SizedBox(height: 0,):  Expanded(
                flex: 2,
                child: isTitle ==true ? Container():Align(alignment: Alignment.centerRight,child: ButtonText(
                  onPressed: () {

                  },
                  text: "تایید",
                  height: 30,
                  fontSize: 14,
                  width: Get.width*0.05,
                  textColor: Colors.white,
                  bgColor: AppColors.darkerGreen,
                ),)),



            isReportList == true? SizedBox(height: 0,):  isSessionList !=true? SizedBox(height: 0,): Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: isTitle == true ? 16 : 14,
                    color: isTitle == true
                        ? AppColors.lighterBlack

                        : AppColors.dividerDark,
                    fontWeight: FontWeight.w500,
                    title: sixColumn??"")),

          ],
        ),
      ),
    ),
  );
}
