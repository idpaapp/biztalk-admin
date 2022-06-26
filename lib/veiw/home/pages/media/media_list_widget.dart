import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaListWidget extends StatelessWidget {
  final String? oneColumn;
  final String? twoColumn;
  final String? threeColumn;
  final String? fourColumn;
  final bool? isTitle;
  final onConfirm;
  final onLink;

  const MediaListWidget(
      {Key? key,
        this.fourColumn,
        this.twoColumn,
        this.oneColumn,
        this.threeColumn,
        this.onConfirm,
        this.onLink,
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
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: onLink,
                child: CustomText(
                    fontSize: 16,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.black,

                    fontWeight: FontWeight.w500,
                    title: fourColumn),
              )),
          Expanded(
              flex: 2,
              child:isTitle == true ? SizedBox(height: 0,):Align(
                alignment: Alignment.centerRight,
                child: ButtonText(
                  onPressed: onConfirm,
                  text: "تایید",
                  height: 30,
                  fontSize: 14,
                  width: Get.width*0.05,
                  textColor: Colors.white,
                  bgColor: AppColors.darkerGreen,
                ),
              )),





        ],
      ),
    ),
  );
}
