import 'package:biztalk_panel_admin/components/time_picker/date_time_picker.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text_field.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ChangeDate{
  var maskFormatter =
  MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
 static  setTime(BuildContext context,String dateId) {
   final HomeController _homeController = Get.find();
   var maskFormatter =
   MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
   TextEditingController _startTime=TextEditingController();
    TextEditingController _endTime=TextEditingController();
   _homeController.selectedDate.value = iranCurrentDate();
   _homeController.selectedDateGorge.value = miladiCurrent();



    documentDialog(context,title: "افزودن زمانبندی",size: 4,onSave: ()async{
      Map<String,String> body={
        "date": _homeController.selectedDateGorge.value,
        "start": _startTime.text,
        "end": _endTime.text
      };
      MyAlert.loding();
      await _homeController.changeDate(dateId, body);
      Get.back();
      if(_homeController.failureMessageChangeDate.value !=""){
        MyAlert.mySnakbarRed(text: _homeController.failureMessageChangeDate.value);
      }else{
        _homeController.sessionList(1);
        Get.back();
        Get.back();
        MyAlert.mySnakbar(text: "عملیات با موفقیت انجام شد");
      }
    },content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            title: "تاریخ جلسه",
            color: AppColors.lighterBlack,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              datePikcer(context);
            },
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child:  Container(
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        controller: TextEditingController(
                            text: _homeController
                                .selectedDate.value),
                        isEnabled: false,
                        isSuffix: 1,
                        cardFormatter: 2,
                        activeBorder: true,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Center(
                        child:
                        SvgPicture.asset("assets/images/icons/calendar.svg"),
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomText(
            title: "ساعت شروع و پایان جلسه",
            color: AppColors.lighterBlack,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.veryLightGrey),
                  child: DateTimePicker(
                    inputFormatters: [maskFormatter],
                    type: DateTimePickerType.time,
                    style: const TextStyle(color: AppColors.black),
                    controller: _startTime,
                    locale: const Locale('fa'),
                    cancelText: "انصراف",
                    cancelStyle: const TextStyle(color: Colors.red),
                    confirmStyle:
                    const TextStyle(color: AppColors.darkerGreen),
                    confirmText: "تایید",
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "ساعت شروع",
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    timeHintText: "انتخاب زمان",
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) {},
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: CustomText(
                    title: "تا",
                    color: AppColors.lighterBlack,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.veryLightGrey),
                  child: DateTimePicker(
                    inputFormatters: [maskFormatter],
                    type: DateTimePickerType.time,
                    style: const TextStyle(color: AppColors.black),
                    controller: _endTime,
                    locale: const Locale('fa'),
                    cancelText: "انصراف",
                    cancelStyle: const TextStyle(color: Colors.red),
                    confirmStyle:
                    const TextStyle(color: AppColors.darkerGreen),
                    confirmText: "تایید",
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "ساعت پایان",
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    timeHintText: "انتخاب زمان",
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) {},
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 14,
          ),
        ],
      ),
    ));
  }
 static datePikcer(BuildContext context) {
   final HomeController _homeController = Get.find();

   String date = "";
    String dateGorg = "";
   documentDialog(context,title: "انتخاب تاریخ",size: 4,onSave: (){
     _homeController.selectedDate.value = date;
     _homeController.selectedDateGorge.value =
         dateGorg;
     Get.back();
   },content:Column(
     children: [
       Directionality(
         textDirection: TextDirection.ltr,
         child: LinearDatePicker(
             startDate: iranCurrentDate(),
             //yyyy/mm/dd
             endDate: "1420/01/01",
             initialDate: iranCurrentDate(),
             dateChangeListener: (String selectedDate) {
               date = selectedDate;
               List<String> dates = selectedDate.split('/');
               Jalali j = Jalali(
                   int.parse(dates[0].toString()),
                   int.parse(dates[1].toString()),
                   int.parse(dates[2].toString()));
               Gregorian gregorian = j.toGregorian();
               String month = gregorian.month < 10
                   ? '0' + gregorian.month.toString()
                   : gregorian.month.toString();
               String day = gregorian.day < 10
                   ? '0' + gregorian.day.toString()
                   : gregorian.day.toString();
               dateGorg = "${gregorian.year}-$month-$day";
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
     ],
   ) );

  }
}