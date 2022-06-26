import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTitleTableWidget extends StatelessWidget {
  final String? amount;
  final Color? amountColor;
  final String? date;
  final String? type;
  final String? stateTitle;
  final String? state;
  final bool? isTitle;

  const TransactionTitleTableWidget({Key? key,
    this.type,
    this.date,
    this.amountColor,
    this.amount,
    this.stateTitle, this.state,
    this.isTitle})
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
                  color: amountColor,
                  fontWeight: FontWeight.w500,
                  title: amount),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: date),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: type),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: state == 'pink' ? AppColors.pink : state == 'red'
                          ? AppColors.red
                          : state == 'blue'?AppColors.tosi:Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.01,vertical: Get.height*0.003),
                    child: CustomText(
                        fontSize: isTitle == true ? 16 : 12,
                        color:  AppColors.black,
                        fontWeight: FontWeight.w500,
                        title: stateTitle),
                  ),
                ],
              ),
            ),

          ],
        ),
      );
}
