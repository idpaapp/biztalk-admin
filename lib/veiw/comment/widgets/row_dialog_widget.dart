import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RowDialogWidget extends StatelessWidget {
  final String? question;
  final String? answer;
  final double? rate;

  const RowDialogWidget({Key? key, this.rate, this.question, this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: question,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black),
                    ),
                    TextSpan(
                      text:answer == null? "" :"   " + answer!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyMiddle),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: LinearPercentIndicator(
                lineHeight: 7.0,
                percent: rate!,
                backgroundColor: AppColors.greyBorder,
                progressColor: AppColors.blueIndigo,
              ),
            ),
          ],
        ),
      );
}
