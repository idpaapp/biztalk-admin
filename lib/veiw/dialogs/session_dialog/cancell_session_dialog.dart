import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/model/home/single_report_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/mentor_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/user_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/session_dialog/change_date.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../edit_profile_dialog/title_text_field_widget.dart';

final RequestSessionController _requestSessionController =
    Get.put(RequestSessionController());
final HomeController _homeController =Get.find();

Future<void> cancellDialog(
  BuildContext context,
  String title,
  String sessionId,{String? fromPage,String? userType,String? userID,}
) async {
  final TextEditingController penalty = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    // user must tap button!
    builder: (BuildContext context) {
      penalty.text = "";
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
          size: 4,
          title: title,
        ),
        content: SizedBox(
          height: Get.height * 0.4,
          width: Get.width * 0.3,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
            child: SingleChildScrollView(
              child: Column(children: [
                TitleTextFieldWidget(
                  title: "مبلغ جریمه",
                  editingController: penalty,
                  format: true,
                  textInputType: TextInputType.number,
                  hint: "مبلغ جریمه",
                ),
                const SizedBox(
                  height: 35,
                ),
                Obx(
                  () => Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.borderColor,
                      ),
                    ),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: const SizedBox(height: 0),
                      value: _requestSessionController.selectedTypeUser.value,
                      items: ["کاربر", "مشاور"].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: ListTile(
                            title: CustomText(title: value),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _requestSessionController.selectedTypeUser.value =
                            val.toString();
                      },
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  borderRadios: 3,
                  onPressed: () async {

                      Map<String, dynamic> body = {
                        "penalty":
                        penalty.text.replaceAll(",", "").replaceAll("،", ""),
                        "isUserCancel":
                        _requestSessionController.selectedTypeUser.value ==
                            "کاربر"
                            ? true
                            : false
                      };
                      print(body);
                      MyAlert.loding();
                      await _requestSessionController.cancelSession(
                          body, sessionId);
                      Get.back();
                      if (_requestSessionController.failureMessageCancelSession
                          .value != "") {
                        MyAlert.mySnakbarRed(text: _requestSessionController
                            .failureMessageCancelSession.value);
                      } else {
  if(fromPage != "1") {
    Get.back();
    Get.back();
    _homeController.sessionList(1);
  }else{
    Get.back();
    Get.back();
      _requestSessionController.getAllRequestSession({
      "page": _requestSessionController.selectedPage.value,
      "type": userType,
      "status":_requestSessionController.selectedStatus,
      "requestFromDate": _requestSessionController
          .selectedStartDateRequest.value == "انتخاب کنید" ? null:_requestSessionController
          .selectedStartDateRequest.value,
      "requestToDate": _requestSessionController
          .selectedEndDateRequest.value== "انتخاب کنید" ? null:_requestSessionController
          .selectedEndDateRequest.value,
      "sessionFromDate": _requestSessionController
          .selectedStartDateSession.value== "انتخاب کنید" ? null:_requestSessionController
          .selectedStartDateSession.value,
      "sessionToDate": _requestSessionController
          .selectedEndDateSession.value== "انتخاب کنید" ? null:_requestSessionController
          .selectedEndDateSession.value
      }, userID!);

  }



                      }

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
