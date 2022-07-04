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

class EducationDocumentSectionWidget extends StatelessWidget {
  final String? title;
  List<Education>? educations;
  final MentorModel? data;

  EducationDocumentSectionWidget({
    Key? key,
    this.title,
    this.educations,
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
          itemCount: educations!.length,
          itemBuilder: (context, index) {
            var education = educations![index];
            return NewItemDocumentWidget(
              title: education.school == null
                  ? ""
                  : education.school!.title ?? "",
              subTitle: education.degree ?? "",
              yers:   education.activityYear ?? "",
              statusTitle: education.statusTitle,
              onShow: () {
                EditDocumentDialog(context, "نام دانشگاه",
                    "مقطع تحصیلی", "رشته", "تحصیل", "edu",
                    name: TextEditingController(
                      text: education.schoolTitle,
                    ), onConfirmtitle: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": education.attachments!.isEmpty
                            ? "CONFIRM"
                            : "DOC_CHECKING"
                      };
                      onConfirmAdditional(
                          body, "ایا برای تایید اطمینان دارید؟");
                    }, onCancelTitle: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": false,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          body, "ایا برای عدم تایید اطمینان دارید؟");
                    }, onConfirm: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": "DOC_CONFIRM"
                      };
                      onConfirmAdditional(
                          body, "ایا برای تایید اطمینان دارید؟");
                    }, onCancel: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          body, "ایا برای تایید اطمینان دارید؟");
                    },
                    atachment: education.attachments,
                    name2: TextEditingController(
                        text: education.schoolTitle),
                    name3: TextEditingController(
                        text: education.schoolTitle),
                    startDate: TextEditingController(
                        text: education.startYear),
                    endDate:
                    TextEditingController(text: education.endYear),
                    isActiveSwitch: education.currentCourse);

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
