import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Color bgColor;
  final Color borderColor;

  const RowTextWidget(
      {Key? key,
      this.title,
      this.subTitle,
      this.bgColor = AppColors.bgText,
      this.borderColor = AppColors.bgText})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomText(
              title: title,
              fontSize: 14,
              color: AppColors.lighterBlack,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: bgColor,
                  border: Border.all(color: borderColor)),
              child: CustomText(
                title: subTitle,
                fontSize: 14,
                color: AppColors.lighterBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
