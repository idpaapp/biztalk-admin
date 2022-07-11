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
  final TextEditingController uniName = TextEditingController();
  final TextEditingController uniDegree = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
              physics: const ScrollPhysics(),
              itemCount: educations!.length,
              itemBuilder: (context, index) {
                var education = educations![index];
                return NewItemDocumentWidget(
                  title: education.schoolTitle == null
                      ? ""
                      : education.schoolTitle ?? "",
                  subTitle: education.degree ?? "",
                  yers: education.activityYear ?? "",
                  statusTitle: education.statusTitle,
                  status: education.verificationStatus,
                  onShow: () {
                    uniName.text = education.schoolTitle ?? "";
                    uniDegree.text = education.degree ?? "";
                    end.text = education.endYear ?? "";
                    start.text = education.startYear ?? "";
                    _documentController.isActiveJobSwitch.value =
                        education.currentCourse ?? false;
                    EditDocumentDialog(
                        context, "نام دانشگاه", "رشته", "", "تحصیل", "edu",
                        onDelete: () {
                      MyAlert.deleteAlertDialog(context,
                          text: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                        MyAlert.loding();
                        await _documentController.deleteEducation(
                            data!.data!.profile!.id!, education.id!);
                        Get.back();
                        if (_documentController
                                .failureMessageDeleteEducation.value !=
                            "") {
                          MyAlert.mySnakbarRed(
                              text: _documentController
                                  .failureMessageDeleteEducation.value);
                        } else {
                          Get.back();
                          Get.back();
                          _documentController
                              .getDocument(data!.data!.profile!.id!);
                        }
                      });
                    }, onConfirmtitle: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": education.attachments!.isEmpty
                            ? "CONFIRM"
                            : "DOC_CHECKING"
                      };

                      onConfirmAdditional(
                          context, body, "ایا برای تایید اطمینان دارید؟");
                    }, onCancelTitle: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": false,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای عدم تایید اطمینان دارید؟");
                    }, onConfirm: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": "DOC_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای تایید اطمینان دارید؟");
                    }, onCancel: () {
                      Map<String, dynamic> body = {
                        "_id": education.id,
                        "type": "education",
                        "status": true,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای تایید اطمینان دارید؟");
                    }, onSave: () async {
                      Map<String, dynamic> body = {
                        "degree": uniDegree.text,
                        "startYear": start.text,
                        "endYear": end.text,
                        "currentCourse":
                            _documentController.isActiveJobSwitch.value,
                        'schoolTitle': uniName.text
                      };

                      print(body);

                      MyAlert.loding();
                      await _documentController.editEducation(
                          body, data!.data!.profile!.id!, education.id!);
                      Get.back();
                      if (_documentController
                              .failureMessageEditEducation.value !=
                          "") {
                        MyAlert.mySnakbarRed(
                            text: _documentController
                                .failureMessageEditEducation.value);
                      } else {
                        _documentController
                            .getDocument(data!.data!.profile!.id!);
                        Get.back();
                      }
                    },
                        atachment: education.attachments,
                        name: uniName,
                        name2: uniDegree,
                        startDate: start,
                        endDate: end,
                        isActiveSwitch:
                        _documentController.isActiveJobSwitch.value);
                  },
                );
              })
        ]),
      );

  onConfirmAdditional(
      BuildContext context, Map<String, dynamic> body, String title) {
    MyAlert.deleteAlertDialog(context, text: title, onConfirm: () async {
      MyAlert.loding();
      await _documentController.confirmAdditional(
          data!.data!.profile!.id!, body);
      if (_documentController.failureMessageConfirmAdditional.value != "") {
        Get.back();
        MyAlert.mySnakbarRed(
            text: _documentController.failureMessageConfirmAdditional.value);
      } else {
        Get.back();
        Get.back();
        Get.back();
        _documentController.getDocument(data!.data!.profile!.id!);
      }
    });
  }
}
