import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class TashrihiAnswerWidget extends StatelessWidget {
  final String? question;
  final String? answer;

  const TashrihiAnswerWidget({Key? key, this.answer, this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: question,
              fontSize: 14,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,top: 10),
              child: CustomText(
                title: answer,
                fontSize: 12,
                color: AppColors.greyMiddle,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
  );
}
