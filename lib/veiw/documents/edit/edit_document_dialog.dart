import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/edit/widgets/left_section.dart';
import 'package:biztalk_panel_admin/veiw/documents/edit/widgets/right_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> EditDocumentDialog(
  BuildContext context,
  String title,
  String subTitle,
  String sub2Title,
  String titleDialog,
  String fromPage, {
  final onConfirm,
  final onConfirmtitle,
  final onCancel,
  final onCancelTitle,
  TextEditingController? name,
  TextEditingController? name2,
  TextEditingController? name3,
  TextEditingController? startDate,
  TextEditingController? endDate,
  bool? isActiveSwitch,
  List<Attachment>? atachment,
}) async {
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
            title: "ویرایش اطلاعات",
            onClose: () {
              Get.back();
            }),
        content: SizedBox(
          height: fromPage == "edu" ? Get.height * 0.6 : Get.height * 0.5,
          width: Get.width * 0.6,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RightColumnEditDocument(
                    nameTitleController: name,
                    nameTitle2Controller: name2,
                    nameTitle3Controller: name3,
                    nameTitle: title,
                    nameTitle2: subTitle,
                    nameTitle3: sub2Title,
                    titleDialog: titleDialog,
                    fromPage: fromPage,
                    endYear: endDate,
                    startYear: startDate,
                    isActiveSwitch: isActiveSwitch,
                    onConfirmTitle: onConfirmtitle,
                    onDeleteTitle: onCancelTitle,
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  LeftSectionWidget(
                    attachment: atachment,
                    onConfeirm: onConfirm,
                    onDelete: onCancel,
                  )
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
                  onPressed: () {},
                  text: "ذخیره",
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
                  text: "انصراف",
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
