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
import 'package:biztalk_panel_admin/veiw/dialogs/session_dialog/cancell_session_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/session_dialog/change_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> sessionDialog(BuildContext context, String title, Session session,
    SingleReportModel value,{String? fromPage,String? userType,String? userID,}) async {
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        right(session, context),
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
                              child: listOfMessage(value),
                            )
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
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
                    cancellDialog(context, "لغو جلسه",session.id!,userType: userType,userID: userID,fromPage: fromPage);

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

Widget right(Session session, BuildContext context) => Expanded(
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
          height: 17,
        ),
        RowTextWidget(
          title: "مشاور :",
          subTitle: session.mentor!.fullName,
        ),
        const SizedBox(
          height: 17,
        ),
        RowTextWidget(
          title: "شماره مشاور :",
          subTitle: session.mentor!.phoneNumber,
        ),
        const SizedBox(
          height: 17,
        ),
        RowTextWidget(
          title: "مراجع :",
          subTitle: session.user!.fullName,
        ),
        const SizedBox(
          height: 17,
        ),
        RowTextWidget(
          title: "شماره مراجع :",
          subTitle: session.user!.phoneNumber,
        ),
        const SizedBox(
          height: 17,
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            RowTextWidget(
              bgColor: Colors.white,
              title: "تاریخ و زمان :",
              subTitle: session.date! + " " + session.startTime!,
            ),
            InkWell(
              onTap: () {
                ChangeDate.setTime(context,session.timeId!);
              },
              child: const Icon(Icons.date_range, size: 30),
            )
          ],
        ),
        const SizedBox(
          height: 17,
        ),
        RowTextWidget(
          title: "مبلغ(تومان) :",
          subTitle: session.formattedPrice,
        ),
        const SizedBox(
          height: 17,
        ),
        RowTextWidget(
          title: "دسته بندی :",
          subTitle: session.subject!.title,
        ),
        const SizedBox(
          height: 17,
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
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var message = value.data![index];
        if (message.senderType == "mentor") {
          return UserChat(
            message: message.msg,
            image: message.sender!.profileImageUrl!,
            date: message.date,
          );
        } else {
          return MentorChat(
            message: message.msg,
            image: message.sender!.profileImageUrl!,
            date: message.date,
          );
        }
      },
    );
