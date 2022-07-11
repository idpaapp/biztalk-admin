import 'package:biztalk_panel_admin/model/off/get_off_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showOffer(BuildContext context, {SingleOff? singleOff}) async {
  final OffController _offController = Get.put(OffController());

  _offController.deleteData();

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
            title: "کد تخفیف",
            ),
        content: Container(
          height: Get.height * 0.6,
          width: Get.width * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              rightColumn(singleOff),
              leftColumn(singleOff),
            ],
          ),
        ),
        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ButtonText(
                  onPressed: () async {
                    Get.back();
                  },
                  text: "بازگشت ",
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

Widget rightColumn(SingleOff? singleOff) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width * 0.2,
          child: TitleTextWidget(
            title: "عنوان تخفیف",
            hint: singleOff!.title!,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width * 0.2,
          child: TitleTextWidget(
            title: "دسته بندی",
            hint: singleOff.useFor == null ?singleOff.useForTypeTitle :singleOff.useFor!.title,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width * 0.2,
          child: TitleTextWidget(
            title: "تاریخ شروع",
            hint: singleOff.startDate,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width * 0.2,
          child: TitleTextWidget(
            title: "تاریخ پایان",
            hint: singleOff.expireDate,
          ),
        ),
      ]),
    ),
  );
}

Widget leftColumn(SingleOff? singleOff) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(
        height: 20,
      ),
      Container(
        width: Get.width * 0.2,
        child: TitleTextWidget(
          title: singleOff!.discountPercent == null? "مبلغ تخفیف": "درصد تخفیف",
          hint: singleOff.discountPercent == null ?singleOff.discountPrice.toString():singleOff.discountPercent.toString(),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      singleOff.discountPercent == null?SizedBox(): Container(
        width: Get.width * 0.2,
        child: TitleTextWidget(
          title: "سقف تخفیف",
          hint: singleOff.topPrice.toString(),
        ),
      ),const SizedBox(
        height: 20,
      ),
      Container(
        width: Get.width * 0.2,
        child: TitleTextWidget(
          title: "کد تخفیف",
          hint: singleOff.code,
        ),
      ),
    ],
  );
}
