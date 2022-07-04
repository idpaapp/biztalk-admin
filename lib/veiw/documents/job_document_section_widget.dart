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

class JobDocumentSectionWidget extends StatelessWidget {
  final String? title;
  final List<Work>? works;
  final MentorModel? data;

  JobDocumentSectionWidget({
    Key? key,
    this.title,
    this.works,
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
              itemCount: works!.length,
              itemBuilder: (context, index) {
                var job = works![index];
                return NewItemDocumentWidget(
                  title: job.company == null ? "" : job.companyTitle,
                  subTitle: job.job,
                  yers:   job.activityYear ?? "",
                  statusTitle: job.statusTitle,
                  onShow: () {
                    EditDocumentDialog(
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
                          "docStatus": "DOC_NOT_CONFIRM"
                        };
                        onConfirmAdditional(
                            body, "ایا برای عدم تایید اطمینان دارید؟");
                      },
                      onConfirmtitle: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": job.attachments!.isEmpty
                              ? "CONFIRM"
                              : "DOC_CHECKING"
                        };
                        onConfirmAdditional(
                            body, "ایا برای تایید اطمینان دارید؟");
                      },
                      onCancel: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": "DOC_NOT_CONFIRM"
                        };
                        onConfirmAdditional(
                            body, "ایا برای تایید اطمینان دارید؟");
                      },
                      onConfirm: () {
                        Map<String, dynamic> body = {
                          "_id": job.id,
                          "type": "work",
                          "status": true,
                          "docStatus": "DOC_CONFIRM"
                        };
                        onConfirmAdditional(
                            body, "ایا برای تایید اطمینان دارید؟");
                      },
                      name: TextEditingController(
                        text: job.companyTitle,
                      ),
                      name2: TextEditingController(text: job.job),
                      startDate: TextEditingController(text: job.startYear),
                      endDate: TextEditingController(text: job.endYear),
                      isActiveSwitch: job.currentPosition,
                      atachment: job.attachments,
                    );
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
