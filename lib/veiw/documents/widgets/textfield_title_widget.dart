import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class TextfieldTitleWidgets extends StatelessWidget {
  final String? title;
  final String? hint;
  final bool? activeNumber;
  final TextEditingController? textEditingController;

  const TextfieldTitleWidgets(
      {Key? key,
        this.title,
        this.activeNumber = false,
        this.textEditingController,
        this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.veryLightGrey),
          child: TextField(
            controller: textEditingController,
            keyboardType: activeNumber == false
                ? TextInputType.text
                : TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              hintStyle:
              const TextStyle(color: AppColors.greyFill, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
