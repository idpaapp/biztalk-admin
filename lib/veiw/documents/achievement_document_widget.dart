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
  final TextEditingController achieviementPlace=TextEditingController();
  final TextEditingController achievementTitle=TextEditingController();
  final TextEditingController achievementYears=TextEditingController();

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
              itemCount: achievements!.length,
              itemBuilder: (context, index) {
                var achievement = achievements![index];
                return NewItemDocumentWidget(
                  title: achievement.title ?? "",
                  subTitle: achievement.place ?? "",
                  yers: achievement.year ?? "",
                  statusTitle: achievement.statusTitle,
                  onShow: () {
                    achieviementPlace.text=achievement.place??"";
                    achievementTitle.text=achievement.title??"";
                    achievementYears.text=achievement.year??"";

                    EditDocumentDialog(
                        context,
                        "محل اخذ",
                        "عنوان دست آورد یا جایزه کسب شده",
                        "سال اخذ",
                        "",
                        "ach", onCancelTitle: () {
                      Map<String, dynamic> body = {
                        "_id": achievement.id,
                        "type": "achievement",
                        "status": false,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای عدم تایید اطمینان دارید؟");
                    }, onDelete: () {
                      MyAlert.deleteAlertDialog(context,
                          text: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                        MyAlert.loding();
                        await _documentController.deleteAchievement(
                            data!.data!.profile!.id!, achievement.id!);
                        Get.back();
                        if (_documentController
                                .failureMessageDeleteAchievement.value !=
                            "") {
                          MyAlert.mySnakbarRed(
                              text: _documentController
                                  .failureMessageDeleteAchievement.value);
                        } else {
                          Get.back();
                          Get.back();
                          _documentController
                              .getDocument(data!.data!.profile!.id!);
                        }
                      });
                    }, onConfirmtitle: () {
                      Map<String, dynamic> body = {
                        "_id": achievement.id,
                        "type": "achievement",
                        "status": true,
                        "docStatus": achievement.attachments!.isEmpty
                            ? "CONFIRM"
                            : "DOC_CHECKING"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای  تایید اطمینان دارید؟");
                    }, onConfirm: () {
                      Map<String, dynamic> body = {
                        "_id": achievement.id,
                        "type": "achievement",
                        "status": true,
                        "docStatus": "DOC_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای تایید اطمینان دارید؟");
                    }, onCancel: () {
                      Map<String, dynamic> body = {
                        "_id": achievement.id,
                        "type": "achievement",
                        "status": true,
                        "docStatus": "DOC_NOT_CONFIRM"
                      };
                      onConfirmAdditional(
                          context, body, "ایا برای تایید اطمینان دارید؟");
                    }, onSave: () async{
                      Map<String, dynamic> body = {
                        "title": achievementTitle.text,
                        "place": achieviementPlace.text,
                        "year": achievementYears.text,
                      };
                      print(body);
                        MyAlert.loding();
                        await _documentController.editAchivement(
                            body,   data!.data!.profile!.id!, achievement.id!);

                        Get.back();
                        if (_documentController
                                .failureMessageEditAchivement.value !=
                            "") {
                          MyAlert.mySnakbarRed(
                              text: _documentController
                                  .failureMessageEditAchivement.value);
                        } else {
                          _documentController
                              .getDocument(data!.data!.profile!.id!);
                          Get.back();
                        }
                    },
                        name: achieviementPlace,
                        atachment: achievement.attachments,
                        name2: achievementTitle,
                        name3: achievementYears,
                        endDate: TextEditingController(text: "55555"),
                        startDate: TextEditingController(text: "222222"));
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
