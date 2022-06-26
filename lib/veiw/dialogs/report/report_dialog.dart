import 'package:biztalk_panel_admin/model/home/report_list_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/mentor_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/user_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dialog_confirm/confirm_dialog.dart';

final HomeController _homeController = Get.find();

Future<void> reportDialog(
    BuildContext context, String title, Report data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      _homeController.singleReport(data.id!);
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
            size: 3,
            title: title,
            onClose: () {
              Get.back();
            }),
        content: Container(
          height: Get.height * 0.7,
          width: Get.width * 0.6,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Row(
                children: [
                  right(data),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "تاریخچه گفتوگوها",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lighterBlack,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        height: Get.height * 0.6,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: AppColors.dividerLight),
                        ),
                        child: listOfMessage(data),
                      )
                    ],
                  ))
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonText(
                  onPressed: () async {
                    confirmDialog(context, onConfirm: () async {
                      MyAlert.loding();
                      await _homeController.changeStatus(data.id!, "DE_ACTIVE");
                      Get.back();
                      if(_homeController.failureMessageChangeStatus.value !=""){
                        MyAlert.mySnakbarRed(text: _homeController.failureMessageChangeStatus.value);
                      }else{
                        Get.back();
                        MyAlert.mySnakbar(title: "موفق",text: "کاربر با موفقیت مسدود شد!");
                      }
                    }, title: "ایا برای مسدود سازی کاربر اطمینان دارید");
                  },
                  text: "مسدود سازی",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonText(
                      onPressed: () {},
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
                      text: "عدم تایید",
                      height: 40,
                      width: Get.width * 0.1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      bgColor: AppColors.disabledGrey,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

Widget right(Report data) => Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        data.plaintiff!.profileImageUrl == null
            ? CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage("assets/images/avatar_placeholder.png"),
              )
            : CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(GlobalInfo.serverAddress +
                    "/" +
                    data.plaintiff!.profileImageUrl!),
              ),
        SizedBox(
          height: 20,
        ),
        RowTextWidget(
          title: "نام و نام خانوادگی :",
          subTitle:
              data.plaintiff == null ? "" : data.plaintiff!.fullName ?? "",
        ),
        SizedBox(
          height: 15,
        ),
        RowTextWidget(
          title: "نام کاربری :",
          subTitle:
              data.plaintiff == null ? "" : data.plaintiff!.userName ?? "",
        ),
        SizedBox(
          height: 15,
        ),
        RowTextWidget(
          title: "نوع کاربری :",
          subTitle:
              data.plaintiff == null ? "" : data.plaintiff!.userType ?? "",
        ),
        SizedBox(
          height: 15,
        ),
        RowTextWidget(
          title: "نام کاربر متخلف :",
          subTitle: data.accused == null ? "" : data.accused!.fullName ?? "",
        ),
        SizedBox(
          height: 15,
        ),
        RowTextWidget(
          title: "نوع تخلف :",
          subTitle: data.subject == null ? "" : data.subject!.title ?? "",
        ),
        SizedBox(
          height: 15,
        ),
        RowTextWidget(
          title: "متن گزارش :",
          subTitle: data.text ?? "",
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ));

Widget listOfMessage(Report data) => Obx(() {
      if (_homeController.failureMessageSingleReport.value != "") {
        return Center(
          child: CustomText(
              title: _homeController.failureMessageSingleReport.value),
        );
      } else if (_homeController.isLoadingSingleReport.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return _homeController.resultSingleReport.value.data!.isEmpty
            ? Center(
                child: CustomText(title: "گفتگویی یافت نشد"),
              )
            : ListView.builder(
                physics: const ScrollPhysics(),
                itemCount:
                    _homeController.resultSingleReport.value.data!.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var message =
                      _homeController.resultSingleReport.value.data![index];
                  if (message.sender!.id == data.plaintiff!.id) {
                    return UserChat(
                      image: data.plaintiff!.profileImageUrl,
                      message: message.msg,
                      date: message.time! + message.date!,
                    );
                  } else {
                    return MentorChat(
                      image: data.accused!.profileImageUrl,
                      message: message.msg,
                      date: message.time! + " - " + message.date!,
                    );
                  }
                },
              );
      }
    });
