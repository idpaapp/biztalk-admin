import 'package:biztalk_panel_admin/components/shamsi_datepicker.dart';
import 'package:biztalk_panel_admin/model/calendar/mentor_calendar_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/buttom_row_widget.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/calender/callender_controller.dart';
import 'package:biztalk_panel_admin/veiw/calender/dialog/single_schedule_dialog.dart';
import 'package:biztalk_panel_admin/veiw/calender/widget/schaduling_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  static const route = "/calenderPage";

  late String mentorId;

  CalenderPage({Key? key}) : super(key: key) {
    _calendarController.selectedDate.value = Get.arguments["date"];
    mentorId = Get.arguments["mentorId"];
    _calendarController.fetchCalendar(
        mentorId, _calendarController.selectedDate.value);
  }

  final CalendarController _calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: getBody(context),
      );

  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const TopSectionPanelAdmin(title: "کاربران"),
            SizedBox(
              height: Get.height * 0.03,
            ),
            myCalender(),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (_calendarController.failureMessageGetCalendar.value != "") {
                return Center(
                  child: CustomText(
                      title:
                          _calendarController.failureMessageGetCalendar.value),
                );
              } else if (_calendarController.isLoadingGetCalendar.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              title: "زمانبندی ها",
                              color: AppColors.lighterBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ButtonRow(
                              height: 35,
                              onPressed: () {
                                singleScheduleDialog(
                                  context,
                                  title: "افزودن زمانبندی ",
                                  date: _calendarController
                                      .selectedDate.value,
                                  userId: mentorId,isEdit: false
                                );
                                //onInsertTime();
                              },
                              text: "افزودن زمانبندی ",
                              textColor: AppColors.darkerGreen,
                              bgColor: AppColors.veryLightGreen,
                              icon: Icons.add,
                              fontSize: 11,
                              iconColor: AppColors.darkerGreen,
                            )
                          ],
                        ),
                        listView(
                            _calendarController.resultGetCalendar.value.data),
                      ],
                    ),
                  ),
                );
              }
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  Widget listView(List<SingleDate>? data) {
    return data!.isEmpty
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: CustomText(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                title: "اطلاعاتی یافت نشد",
                color: AppColors.blackText,
              ),
            ))
        : ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              var date = data[index];
              return SchadulingSectionWidget(
                onEdit: () {
                  singleScheduleDialog(
                      context,
                      title: "ویرایش زمانبندی ",
                      date: _calendarController
                          .selectedDate.value,
                      userId: mentorId,isEdit: true,
                    endTime: date.end,
                    startTime: date.start,
                    price: date.price.toString(),
                    editId: date.id
                  );
                },
                amount: date.formattedPrice,
                stateTitle: date.statusTitle,
                state: date.status,
                timeSession: "از" + date.start! + "  الی  " + date.end!,
              );
            },
          );
  }

  Widget myCalender() => Container(
      height: 400,
      width: Get.width * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ShamsiDatepicker(
          deactiveWeekList: const [7],
          activeSelectedDateBackColor: AppColors.darkerGreen,
          activeSelectedDateTextColor: Colors.yellowAccent,
          useFullWeekName: true,
          deactiveSelectedDateTextColor: Colors.grey,
          datesBorderRadius: 50,
          deactiveSelectedDateBackColor: Colors.white,
          activeDateTextStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          deactiveDateTextStyle: const TextStyle(color: Colors.red),
          monthTextStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          yearTextStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          weekTextStyle: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          shamsiDateStringFormat: "yyyy-mm-dd",
          gregorianDateStringFormat: "yyyy-mm-dd",
          onMonthChange: (shamsi, gregorian) {},
          onDateSelect: (shamsi, gregorian) async {


            _calendarController.selectedDate.value = gregorian;
            _calendarController.fetchCalendar(mentorId, gregorian);
          }));

}
