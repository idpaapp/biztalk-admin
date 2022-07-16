import 'package:biztalk_panel_admin/components/time_picker/date_time_picker.dart';
import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/model/home/single_report_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text_field.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_bottomsheet.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/mentor_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/user_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/session/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamsi_date/shamsi_date.dart';
final SessionController _sessionController =Get.put(SessionController());
var maskFormatter =
MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
Future<void> sessionDialog(BuildContext context, String title, Session session,
    SingleReportModel value) async {
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
            size: 3,
            title: title,
            ),
        content: SizedBox(
          height: Get.height * 0.7,
          width: Get.width * 0.6,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Row(
                children: [
                  right(session),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        title: "تاریخچه گفتوگوها",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lighterBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 5),
                        height: Get.height * 0.6,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: AppColors.dividerLight),
                        ),
                        child: listOfMessage( value),
                      )
                    ],
                  ))
                ],
              )),
        ),
        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "لغو جلسه",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                  bgColor: AppColors.red,
                ),
               
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "بستن",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                  bgColor: AppColors.disabledGrey,
                ),
              ],
            ),
          )
        ],
      );
    },
  );

}
setTime() {
  TextEditingController _startTime=TextEditingController();
  TextEditingController _endTime=TextEditingController();
  TextEditingController _amount=TextEditingController();
  _sessionController.selectedDate.value = iranCurrentDate();
  _sessionController.selectedDateGorge.value = miladiCurrent();

  CustomBottomSheet.myBottomSheet(
    title: "افزودن زمان بندی",
    height: Get.height*0.5,
    widget: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
              datePikcer();
            },
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Obx(() => Container(
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        controller: TextEditingController(
                            text: _sessionController
                                .selectedDate.value),
                        isEnabled: false,
                        isSuffix: 1,
                        cardFormatter: 2,
                        activeBorder: true,
                      ),
                    )),
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
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                title: "مبلغ مشاوره",
                color: AppColors.lighterBlack,
                fontSize: 12,

                fontWeight: FontWeight.normal,
              ),
              Row(
                children: [
                  Obx(()=>Directionality(
                    textDirection: TextDirection.ltr,
                    child: Switch(value:_sessionController.freeSession.value , onChanged: (val){
                      _sessionController.freeSession.value =val;
                      if(val){
                        _amount.text="0";
                      }
                    },activeColor: AppColors.green),
                  ),),
                  CustomText(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green,
                    title: "رایگان",
                  ),

                ],
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(()=>CustomTextField(
              controller: _amount,
              isSuffix: 2,
              isEnabled: !_sessionController.freeSession.value,
              hint: _sessionController.freeSession.value? "0" :"مبلغ مشاوره",
              cardFormatter: 1,
              activeBorder: true,
            )),
          ),            const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonText(
                onPressed: () {
                  onInsertTime();
                },
                text: "افزودن",
                borderRadios: 10,
                width: 110,
                height: 35,
                bgColor: AppColors.darkerGreen,
                textColor: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const CustomText(
                  title: "انصراف",
                ),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      ),
    ),
  );
}

datePikcer() {
  String date = "";
  String dateGorg = "";

  CustomBottomSheet.myBottomSheet(
    height: 500,
    title: "انتخاب تاریخ",
    widget: Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: ButtonText(
                    text: 'انتخاب',
                    height: 40,
                    onPressed: () {
                      _sessionController.selectedDate.value = date;
                      _sessionController.selectedDateGorge.value =
                          dateGorg;
                      Get.back();
                    },
                    fontSize: 16,
                    bgColor: AppColors.darkerGreen,
                    textColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.darkGrey),
                    ),
                    child: const Center(
                      child: CustomText(
                        title: "انصراف",
                        color: AppColors.darkGrey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
void onInsertTime() async {
 print("sss");
  // if(int.parse(_amount.text.replaceAll(",", "")) < 5000 &&int.parse(_amount.text.replaceAll(",", "")) !=0 ){
  //   MyAlert.mySnakbarRed(text: "حداقل مبلغ مجاز بیش از 5,000 تومان می باشد");
  //   return;
  // }
  // if (_endTime.text == "" || _startTime.text == "" ) {
  //   MyAlert.mySnakbarRed(text: "لطفا ساعت را وارد کنید");
  //   return;
  // }
  // MyAlert.loading();
  // await _socketConnectController.createCalenderOnChat(
  //     _socketConnectController.selectedDateGorge.value,
  //     _startTime.text,
  //     _endTime.text,
  //     _amount.text.replaceAll(",", "").replaceAll("،", ""),
  //     widget.requestId);
  // if (_socketConnectController.failureMessageCreateTime.value != "") {
  //   Get.back();
  //   MyAlert.mySnakbarRed(
  //       text: _socketConnectController.failureMessageCreateTime.value);
  //   return;
  // } else if (_socketConnectController.resultCreateTime.value.success ==
  //     true) {
  //   _socketConnectController.onSendTap(
  //       _socketConnectController.resultCreateTime.value.message.toString(),
  //       _socketConnectController.resultCreateChat.value.data.toString());
  //   scrollController.animateTo(0.0,
  //       curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
  //   _messageController.text = "";
  //   _endTime.text = "";
  //   _startTime.text = "";
  //   _amount.text = "";
  //   Get.back();
  //   Get.back();
  // }
}


Widget right(Session session) => Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            session.mentor!.profileImageUrl == null
                ? const CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/images/avatar_placeholder.png"),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 50,
                    backgroundImage: NetworkImage(GlobalInfo.serverAddress +
                        "/" +
                        session.mentor!.profileImageUrl!),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: session.user!.profileImageUrl == null
                  ? const CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/images/avatar_placeholder.png"),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(GlobalInfo.serverAddress +
                          "/" +
                          session.user!.profileImageUrl!),
                    ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "مشاور :",
          subTitle: session.mentor!.fullName,
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "شماره مشاور :",
          subTitle: session.mentor!.phoneNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "مراجع :",
          subTitle: session.user!.fullName,
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "شماره مراجع :",
          subTitle: session.user!.phoneNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RowTextWidget(
              title: "تاریخ و زمان :",
              subTitle: session.date! + " "+session.startTime! ,
            ),
            InkWell(onTap:setTime ,child: Icon(Icons.date_range,size: 30),)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "مبلغ(تومان) :",
          subTitle: session.formattedPrice,
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "دسته بندی :",
          subTitle: session.subject!.title,
        ),
        const SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "توضیحات :",
          subTitle: session.description,
        ),
      ],
    ));

Widget listOfMessage(SingleReportModel value) => ListView.builder(
      physics: const ScrollPhysics(),
      itemCount: value.data!.length,
      reverse: true,
      itemBuilder: (context, index) {
        var message = value.data![index];
        if (message.senderType == "mentor") {
          return UserChat(
            message: message.msg,
            image:
                message.sender!.profileImageUrl!,
            date: message.date,
          );
        } else {
          return MentorChat(
            message: message.msg,
            image:
                message.sender!.profileImageUrl!,
            date: message.date,
          );
        }
      },
    );
