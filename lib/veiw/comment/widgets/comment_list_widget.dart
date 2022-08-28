import 'package:biztalk_panel_admin/resources/all_methods.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class CommentListWidget extends StatelessWidget {
  final String? fullName;
  final String? createDate;
  final String? comment;
  final double? rate;
  final bool isTitle;
  final String? statusRate;
  final onTap;

  const CommentListWidget(
      {Key? key,
        this.onTap,
        this.comment,
        this.createDate,
        this.fullName,
        this.rate,
        this.statusRate,
        this.isTitle = false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding:
      const EdgeInsets.only(bottom: 20, top: 20, left: 15, right: 15),
      decoration: BoxDecoration(
        color: isTitle == true ? AppColors.blueSession : Colors.white,
        borderRadius: isTitle
            ? const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
                fontSize: isTitle == true ? 16 : 14,
                color: isTitle == true ? Colors.white : AppColors.columnText,
                fontWeight: FontWeight.w500,
                title: fullName),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
                fontSize: isTitle == true ? 16 : 14,
                color: isTitle == true ? Colors.white : AppColors.columnText,
                fontWeight: FontWeight.w500,
                title: createDate),
          ),
          Expanded(
            flex: 3,
            child: CustomText(
                fontSize: isTitle == true ? 16 : 14,
                color: isTitle == true ? Colors.white : AppColors.columnText,
                fontWeight: FontWeight.w500,
                title: comment),
          ),
          Expanded(
            flex: 2,
            child: isTitle ? CustomText(
                fontSize:16 ,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                title: "میانگین امتیاز"):
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:AllMethods.commentColor(rate!)
                    ),

                    child: CustomText(
                        fontSize:  12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        title: rate.toString())
                ),
              ],
            ),

          ),
          Expanded(
            flex:2,
            child: isTitle?SizedBox() : Row(
              children: [
                ButtonText(
                  onPressed: onTap,
                  text: "مشاهده جزئیات",
                  borderRadios: 10,
                  fontWeight: FontWeight.w500,
                  height: 35,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueSession,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
