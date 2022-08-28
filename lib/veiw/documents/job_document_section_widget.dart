import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/edit/edit_document_dialog.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/new_item_document_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDocumentSectionWidget extends StatelessWidget {
  final String? title;
  final List<Work>? works;
  final MentorModel? data;
  final String? mentorId;

  JobDocumentSectionWidget({
    Key? key,
    this.title,
    this.works,
    this.mentorId,
    this.data,
  }) : super(key: key);
  final DocumentController _documentController = Get.put(DocumentController());
  final TextEditingController companyTitle = TextEditingController();
  final TextEditingController jobTitle = TextEditingController();
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
              itemCount: works!.length,
              itemBuilder: (context, index) {
                var job = works![index];
                return NewItemDocumentWidget(
                  statusVeryFy: job.status!,
                  title: job.company == null ? "" : job.companyTitle,
                  subTitle: job.job,
                  years: job.activityYear ?? "",
                  statusTitle: job.statusTitle,
                  status: job.verificationStatus,

                  onShow: () {
                    _documentController.isActiveJobSwitch.value =
                        job.currentPosition ?? false;
                    companyTitle.text = job.companyTitle ?? "";
                    jobTitle.text = job.job ?? "";
                    start.text = job.startYear ?? "";
                    end.text = job.endYear ?? "";
                    editDocumentDialog(
                      context,
                      "نام سازمان",
                      "سمت و موقعیت شغلی",
                      "",
                      "فعالیت",
                      "job",
                      onCancelTitle: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": false,
                          "docStatus": job.verificationStatus
                        };
                        onConfirmAdditional(
                            context, body, "ایا برای عدم تایید اطمینان دارید؟");
                      },
                      onConfirmTitle: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": job.verificationStatus
                        };
                        onConfirmAdditional(
                            context, body, "ایا برای تایید اطمینان دارید؟");
                      },
                      onCancel: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": "DOC_NOT_CONFIRM"
                        };
                        onConfirmAdditional(
                            context, body, "ایا برای تایید اطمینان دارید؟");
                      },
                      onDelete: () {
                        MyAlert.deleteAlertDialog(context,
                            text: "آیا برای حذف اطمینان دارید؟",
                            onConfirm: () async {
                          MyAlert.loding();
                          await _documentController.deleteJob(
                              mentorId!, job.id!);
                          Get.back();
                          if (_documentController
                                  .failureMessageDeleteJob.value !=
                              "") {
                            MyAlert.mySnakbarRed(
                                text: _documentController
                                    .failureMessageDeleteJob.value);
                          } else {
                            Get.back();
                            Get.back();
                            _documentController.getDocument(mentorId!);
                          }
                        });
                      },
                      onConfirm: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": "DOC_CONFIRM"
                        };
                        onConfirmAdditional(
                            context, body, "ایا برای تایید اطمینان دارید؟");
                      },
                      onSave: () async {
                        Map<String, dynamic> body = {
                          "job": jobTitle.text,
                          "startYear": start.text,
                          "endYear": end.text,
                          "currentPosition":
                              _documentController.isActiveJobSwitch.value,
                          "companyTitle": companyTitle.text,
                        };


                        MyAlert.loding();
                        await _documentController.editJob(
                            body, mentorId!, job.id!);
                        Get.back();
                        if (_documentController.failureMessageEditJob.value !=
                            "") {
                          MyAlert.mySnakbarRed(
                              text: _documentController
                                  .failureMessageEditJob.value);
                        } else {
                          _documentController.getDocument(mentorId!);
                          Get.back();
                        }
                      },
                      name: companyTitle,
                      name2: jobTitle,
                      startDate: start,
                      endDate: end,
                      isActiveSwitch:
                          _documentController.isActiveJobSwitch.value,
                      atachment: job.attachments,
                    );
                  },
                );
              })
        ]),
      );

  onConfirmAdditional(
      BuildContext context, Map<String, dynamic> body, String title) {
    confirmDialog(context, title: title, onConfirm: () async {
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
