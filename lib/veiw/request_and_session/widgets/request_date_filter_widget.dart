import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/responsive/select_date_dialog.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/textfield_container_widget.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/title_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestDateFilterWidget extends StatelessWidget {
  final String? title;
  final onTapSelectStart;
  final onTapSelectEnd;
  final String? selectStartDatee;
  final String? selectEndDatee;

  RequestDateFilterWidget({Key? key, this.title,this.selectEndDatee,this.selectStartDatee,this.onTapSelectEnd,this.onTapSelectStart}) : super(key: key);

  final RequestSessionController _requestSessionController = Get.find();
String startDate="";
String endDate="";
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: AppColors.disabledGrey),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TitleFilterSection(
            title: title,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Expanded(
                    child: Center(
                        child: CustomText(
                            title: "از", color: AppColors.darkerGrey))),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextfieldContainerWidget(
                      onTap: onTapSelectStart,
                      date: selectStartDatee,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Expanded(
                    child: Center(
                        child: CustomText(
                            title: "تا", color: AppColors.darkerGrey))),
                Expanded(
                  flex: 3,
                  child:Align(
                      alignment: Alignment.centerRight,
                      child: TextfieldContainerWidget(
                        date: selectEndDatee,
                        onTap: onTapSelectEnd,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      );
}
