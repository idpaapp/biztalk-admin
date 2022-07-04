import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/edit/edit_document_dialog.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/new_item_document_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchievementDocumentSectionWidget extends StatelessWidget {
  final String? title;
  final List<Achievement>? achievements;
  final MentorModel? data;

  AchievementDocumentSectionWidget({
    Key? key,
    this.title,
    this.achievements,
    this.data,
  }) : super(key: key);
  final DocumentController _documentController = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.white),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
        title: title,
        color: AppColors.titleColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: achievements!.length,
          itemBuilder: (context, index) {
            var achievment = achievements![index];
            return NewItemDocumentWidget(
              title: achievment.title??"",
              subTitle: achievment.place ?? "",
              yers:   achievment.year ?? "",
              statusTitle: achievment.statusTitle,

              onShow: () {
                EditDocumentDialog(
                    context,
                    "محل اخذ",
                    "عنوان دست آورد یا جایزه کسب شده",
                    "سال اخذ",
                    "",
                    "ach", onCancelTitle: () {
                  Map<String, dynamic> body = {
                    "_id": achievment.id,
                    "type": "achievement",
                    "status": false,
                    "docStatus": "DOC_NOT_CONFIRM"
                  };
                  onConfirmAdditional(
                      body, "ایا برای عدم تایید اطمینان دارید؟");
                }, onConfirmtitle: () {
                  Map<String, dynamic> body = {
                    "_id": achievment.id,
                    "type": "achievement",
                    "status": true,
                    "docStatus": achievment.attachments!.isEmpty
                        ? "CONFIRM"
                        : "DOC_CHECKING"
                  };
                  onConfirmAdditional(
                      body, "ایا برای  تایید اطمینان دارید؟");
                }, onConfirm: () {
                  Map<String, dynamic> body = {
                    "_id": achievment.id,
                    "type": "achievement",
                    "status": true,
                    "docStatus": "DOC_CONFIRM"
                  };
                  onConfirmAdditional(
                      body, "ایا برای تایید اطمینان دارید؟");
                }, onCancel: () {
                  Map<String, dynamic> body = {
                    "_id": achievment.id,
                    "type": "achievement",
                    "status": true,
                    "docStatus": "DOC_NOT_CONFIRM"
                  };
                  onConfirmAdditional(
                      body, "ایا برای تایید اطمینان دارید؟");
                },
                    name: TextEditingController(
                      text: achievment.title,
                    ),
                    atachment: achievment.attachments,
                    name2:
                    TextEditingController(text: achievment.place),
                    name3: TextEditingController(text: achievment.year),
                    endDate: TextEditingController(text: "55555"),
                    startDate: TextEditingController(text: "222222"));

              },
            );
          })
    ]),
  );

  onConfirmAdditional(Map<String, dynamic> body, String title) {
    MyAlert.deleteBottomSheet(
        text: title,
        title: "توجه",
        onCancel: () {
          Get.back();
        },
        onConfirm: () async {
          MyAlert.loding();
          await _documentController.confirmAdditional(
              data!.data!.profile!.id!, body);
          if (_documentController.failureMessageConfirmAdditional.value != "") {
            Get.back();
            MyAlert.mySnakbarRed(
                text:
                _documentController.failureMessageConfirmAdditional.value);
          } else {
            Get.back();
            Get.back();
            Get.back();
            _documentController.getDocument(data!.data!.profile!.id!);
          }
        });
  }
}
