import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffWidget extends StatelessWidget {
  final String? oneColumn;
  final String? twoColumn;
  final String? threeColumn;
  final String? fourColumn;
  final String? fiveColumn;
  final String? sixColumn;
  final bool? isTitle;
  final onDelete;
  final onCopy;
  final onTap;

  const OffWidget(
      {Key? key,
      this.fiveColumn,
      this.fourColumn,
      this.sixColumn,
      this.twoColumn,
      this.oneColumn,
      this.threeColumn,
      this.onDelete,
      this.onCopy,
        this.onTap,
      this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
   onTap:onTap,
    child: Container(
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InkWell(
                        onTap: onCopy,
                        child: Row(
                          children: [
                            isTitle == true?SizedBox(height: 0,): const Center(child: Icon(Icons.copy_outlined)),
                            SizedBox(width: 8,),
                            CustomText(
                                fontSize: isTitle == true ? 16 : 14,
                                color: isTitle == true
                                    ? AppColors.lighterBlack
                                    : AppColors.black,
                                fontWeight: FontWeight.w500,
                                title: twoColumn),

                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: CustomText(
                        fontSize: isTitle == true ? 16 : 14,
                        color: isTitle == true
                            ? AppColors.lighterBlack
                            : AppColors.black,
                        fontWeight: FontWeight.w500,
                        title: threeColumn ?? "")),
                Expanded(
                    flex: 2,
                    child: CustomText(
                        fontSize: 16,
                        color: isTitle == true
                            ? AppColors.lighterBlack
                            : AppColors.black,
                        fontWeight: FontWeight.w500,
                        title: fourColumn)),
                Expanded(
                    flex: 2,
                    child: CustomText(
                        fontSize: 16,
                        color: isTitle == true
                            ? AppColors.lighterBlack
                            : AppColors.black,
                        fontWeight: FontWeight.w500,
                        title: fiveColumn ?? "")),
                Expanded(
                    flex: 2,
                    child: isTitle == true
                        ? Container()
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                ButtonText(
                                  onPressed: onDelete,
                                  text: "حذف",
                                  height: 30,
                                  fontSize: 14,
                                  width: Get.width * 0.05,
                                  textColor: Colors.white,
                                  bgColor: AppColors.red,
                                ),
                              ],
                            ),
                          )),
              ],
            ),
          ),
        ),
  );
}
