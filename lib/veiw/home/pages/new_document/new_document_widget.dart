import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewDocumentWidget extends StatelessWidget {
  final String? oneColumn;
  final String? twoColumn;
  final String? threeColumn;
  final String? fourColumn;
  final String? fiveColumn;
  final bool? isTitle;
  final onTap;


  const NewDocumentWidget(
      {Key? key,
        this.fiveColumn,
        this.fourColumn,

        this.twoColumn,
        this.oneColumn,
        this.threeColumn,
        this.onTap,
        this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding:
    const EdgeInsets.only(bottom: 20, top: 15, left: 20, right: 40),
    decoration: BoxDecoration(
      color: isTitle == true ? AppColors.blueSession : Colors.white,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
                fontSize: isTitle!  ? 16 : 14,
                color:
                isTitle == true ? Colors.white : AppColors.columnText,
                fontWeight: FontWeight.w500,
                title: oneColumn),
          ),
          Expanded(
              child: CustomText(
                  fontSize: isTitle!  ? 16 : 14,
                  color:
                  isTitle == true ? Colors.white : AppColors.blueIndigo,
                  fontWeight: FontWeight.w500,
                  title: twoColumn)),
          Expanded(
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color:
                  isTitle == true ? Colors.white : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: threeColumn ?? "")),

          Expanded(
              child:
                   CustomText(
                  fontSize: 16,
                  color: isTitle == true
                      ? Colors.white
                      : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: fourColumn)
                  ),

               Expanded(
              child: CustomText(
                  fontSize: 16,
                  color: isTitle == true
                      ? Colors.white
                      : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: fiveColumn ?? "")),

               Expanded(
              child: isTitle == true
                  ? Container()
                  : Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.more_horiz),
              )),

        ],
      ),
    ),
  );


}
