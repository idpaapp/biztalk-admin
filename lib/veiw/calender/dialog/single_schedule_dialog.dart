import 'package:biztalk_panel_admin/components/time_picker/date_time_picker.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text_field.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/calender/callender_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Future<void> singleScheduleDialog(
  BuildContext context, {
  String? title,
  String? date,
  String? userId,
  String? editId,
  bool? isEdit,
  String? startTime,
  String? endTime,
  String? price,
}) async {
  final CalendarController _calendarController = Get.find();

  var maskFormatter =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  final TextEditingController _amount = TextEditingController();

  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();



  if (isEdit == true) {
    _amount.text = price!;
    _endTime.text = endTime!;
    _startTime.text = startTime!;
  }

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
        title: TitleWidget(
            size: 4,
            title: title!,
            onClose: () {
              Get.back();
            }),
        content: SizedBox(
          height: Get.height * 0.3,
          width: Get.width * 0.35,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: "ساعت شروع و پایان جلسه",
                    color: AppColors.lighterBlack,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
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
                            validator: (val) {},
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
                            validator: (val) {},
                            onSaved: (val) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(
                    title: "مبلغ مشاوره",
                    color: AppColors.lighterBlack,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.veryLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextField(
                      controller: _amount,
                      isSuffix: 2,
                      hint: "مبلغ مشاوره",
                      cardFormatter: 1,
                      activeBorder: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.dividerDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                    if (_startTime.text == "") {
                      MyAlert.mySnakbarRed(text: "لطفا زمان شروع را وارد کنید");
                      return;
                    } else if (_endTime.text == "") {
                      MyAlert.mySnakbarRed(
                          text: "لطفا زمان پایان را وارد کنید");
                      return;
                    } else if (_amount.text == "") {
                      MyAlert.mySnakbarRed(text: "لطفا زمان مبلغ را وارد کنید");
                      return;
                    } else {
                      MyAlert.loding();
                      Map<String, dynamic> body = {
                        "date": date,
                        "start": _startTime.text,
                        "end": _endTime.text,
                        "price":
                            _amount.text.replaceAll(",", "").replaceAll("،", "")
                      };

                      if(isEdit == true){
                        print(body);
                        print(userId);
                        print(editId);
                        await _calendarController.updateCalendar(userId!, editId!, body);
                        if (_calendarController.resultUpdateCalendar.value.ok ==
                            true) {
                          Get.back();
                          Get.back();
                          _calendarController.fetchCalendar(userId, date!);
                        } else {
                          Get.back();
                          MyAlert.mySnakbarRed(text: "نشد");
                        }
                      }else{
                        await _calendarController.addCalendar(body, userId!);
                        if (_calendarController.resultAddCalendar.value.ok ==
                            true) {
                          Get.back();
                          Get.back();
                          _calendarController.fetchCalendar(userId, date!);
                        } else {
                          Get.back();
                          MyAlert.mySnakbarRed(text: "نشد");
                        }
                      }

                    }
                  },
                  text: isEdit == true ? "ویرایش":"ذخیره",
                  height: 40,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.darkerGreen,
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  width: Get.width * 0.1,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  onPressed: () async {
                    if (isEdit == true) {
                      confirmDialog(context,
                          title: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                        MyAlert.loding();
                        await _calendarController.deleteCalendar(
                            userId!, editId!);
                        if(_calendarController.resultDeleteCalendar.value.ok == true){
                          Get.back();
                          Get.back();
                          Get.back();
                          _calendarController.fetchCalendar(userId, date!);
                        }else{}
                      });
                    } else {
                      Get.back();
                    }
                  },
                  text: isEdit == false ? "انصراف" : "حذف ",
                  height: 40,
                  fontSize: 14,
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  width: Get.width * 0.1,
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
