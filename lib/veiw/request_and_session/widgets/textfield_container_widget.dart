import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextfieldContainerWidget extends StatelessWidget {
  final String? date;
  final onTap;

  const TextfieldContainerWidget({Key? key, this.date, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: Get.width * 0.1,
          decoration: BoxDecoration(
            color: AppColors.veryLightGrey,
            border: Border.all(color: AppColors.disabledGrey),
            borderRadius: BorderRadius.circular(3),
          ),
          child:
              CustomText(color: AppColors.blackText, fontSize: 14, title: date),
        ),
      );
}
