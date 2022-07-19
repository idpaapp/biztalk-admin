import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';



Future<void> selectDateDialog(BuildContext context,
    {final onConfirm,final onChange}) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: const TitleWidget(
          size: 4,
          title: "انتخاب تاریخ",
        ),
        content: Directionality(
          textDirection: TextDirection.ltr,
          child: LinearDatePicker(
              startDate: iranCurrentDate(),
              //yyyy/mm/dd
              endDate: "1420/01/01",
              initialDate: iranCurrentDate(),
              dateChangeListener:onChange,
              showDay: true,
              //false -> only select year & month
              labelStyle: const TextStyle(
                fontFamily: 'iran_sans',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              selectedRowStyle: const TextStyle(
                fontFamily: 'iran_sans',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.darkerGreen,
              ),
              unselectedRowStyle: const TextStyle(
                fontFamily: 'iran_sans',
                fontSize: 16.0,
                color: Colors.blueGrey,
              ),
              yearText: "سال",
              monthText: "ماه ",
              showLabels: true,
              // to show column captions, eg. year, month, etc.
              columnWidth: 100,
              showMonthName: true,
              isJalaali: true // false -> Gregorian
          ),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.dividerDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonText(
                  onPressed: onConfirm,
                  text: "تایید",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                  bgColor: AppColors.red,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}




