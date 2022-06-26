import 'package:biztalk_panel_admin/model/home/request_list_model.dart';
import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/model/home/single_report_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/mentor_chat_item.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/widget/chat_screen/widget/user_chat_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> requestDialog(BuildContext context, String title, Request request,
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
            onClose: () {
              Get.back();
            }),
        content: SizedBox(
          height: Get.height * 0.7,
          width: Get.width * 0.6,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Row(
                children: [
                  right(request),
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

Widget right(Request request) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            request.mentor!.profileImageUrl == null
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
                  request.mentor!.profileImageUrl!),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: request.user!.profileImageUrl == null
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
                    request.user!.profileImageUrl!),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "مشاور :",
          subTitle: request.mentor!.fullName,
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "شماره مشاور :",
          subTitle: request.mentor!.phoneNumber,
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "مراجع :",
          subTitle: request.user!.fullName,
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "شماره مراجع :",
          subTitle: request.user!.phoneNumber,
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "تاریخ و زمان :",
          subTitle: request.createdAt,
        ),
        SizedBox(
          height: 10,
        ),

        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "دسته بندی :",
          subTitle: request.subject!.title,
        ),
        SizedBox(
          height: 10,
        ),
        RowTextWidget(
          title: "توضیحات :",
          subTitle: request.description,
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
