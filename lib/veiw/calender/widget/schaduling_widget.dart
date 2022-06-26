import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class SchadulingSectionWidget extends StatelessWidget {
  final String? timeSession;
  final String? amount;
  final String? stateTitle;
  final String? state;
  final onEdit;

  const SchadulingSectionWidget(
      {Key? key, this.amount, this.stateTitle, this.timeSession,this.state,this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.topLeft,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color:state == "available" ? Colors.white : AppColors.disabledGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustomText(
                  title: "زمان جلسه : ",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  title: timeSession,
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const CustomText(
                  title: "مبلغ تعیین شده: ",
                  color: AppColors.darkerGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  title: amount,
                  color: AppColors.darkerGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const CustomText(
                  title: "وضعیت: ",
                  color: AppColors.darkerGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  title: stateTitle,
                  color: state == "available" ? AppColors.darkOrange :AppColors.redText,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ],
            )
          ],
        ),
      ),
      state == "available" ?                           ButtonText(
        margin: const EdgeInsets.only(left: 8, top: 15),
        onPressed:onEdit,
        text: "ویرایش",
        bgColor: AppColors.greenWhite,
        height: 30,
        width: 75,
        fontSize: 10,
        textColor: AppColors.darkerGreen,
      )
          :const SizedBox(height: 0,)
    ],
  );
}
