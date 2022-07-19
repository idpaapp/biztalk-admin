import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';

import '../../../resources/app_colors.dart';

final OffController _offController = Get.find();

class DatePikerWidget extends StatelessWidget {
  final String? date;
  final String? title;
  final int? from;

  const DatePikerWidget({Key? key, this.date, this.title, this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomText(
              title: title,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          InkWell(
            onTap: () {
              datePiker(context, from!);
            },
            child: Container(
              height: 45,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.dividerDark,
                  ),
                  color: AppColors.veryLightGrey),
              child:
                  CustomText(color: AppColors.black, fontSize: 14, title: date),
            ),
          ),
        ],
      );

  datePiker(BuildContext context, int from) async {
    String date;
    date = "";

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
                dateChangeListener: (val) {
                  date = val;
                },
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
                    onPressed: () {
                      if (from == 1) {
                        _offController.startDate.value = date;
                      } else {
                        _offController.endDate.value = date;
                      }
                      Get.back();
                    },
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
}
