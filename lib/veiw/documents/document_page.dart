import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/documents/achievement_document_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/education_document_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/job_document_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/container_document_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/set_new_achievement.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/set_new_edu.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/set_new_job.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentPage extends StatelessWidget {
  final MentorModel data;

  DocumentPage({Key? key, required this.data}) : super(key: key) {
    _documentController.getDocument(data.data!.profile!.id!);
  }

  final DocumentController _documentController = Get.put(DocumentController());
  List dataList = [
    "افزودن سابقه شغلی",
    "افزودن سابقه تحصیلی",
    "افزودن دستاورد"
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.veryLightGrey,
        body: Obx(() {
          if (_documentController.failureMessageGetDocument.value != "") {
            return Center(
              child: CustomText(
                  title: _documentController.failureMessageGetDocument.value),
            );
          } else if (_documentController.isLoadingGetDocument.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return getBody();
          }
        }),
      );

  Widget getBody() => SingleChildScrollView(
        child: Column(
          children: [
            const TopSectionPanelAdmin(title: "گردش حساب"),
            SizedBox(
              height: Get.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
              child: ProfileSectionWidget(
                tab: SizedBox(),
                isTransaction: true,
                isUser: false,
                image: "ss",
                onEdit: () {},
                fullName: data.data!.profile!.fullName,
                jobTitle: data.data!.profile!.jobTitle,
                widget: Row(
                  children: [
                    const ContainerDocumentWidget(
                      title: "مدرک شغلی ارسال نشده",
                      bgColor: AppColors.orange,
                      number: "1",
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    const ContainerDocumentWidget(
                      title: "مدرک شغلی تایید نشده",
                      bgColor: AppColors.tosi,
                      number: "1",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
              child: mainSection(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );

  mainSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          insetDocument(),
          SizedBox(
            width: 24,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobDocumentSectionWidget(
                  title: "سوابق شغلی",
                  data: data,
                  works:
                      _documentController.resultGetDocument.value.data!.works!,
                ),
                SizedBox(
                  height: 15,
                ),
                EducationDocumentSectionWidget(
                  title: "سوابق تحصیلی",
                  data: data,
                  educations: _documentController
                      .resultGetDocument.value.data!.educations,
                ),
                SizedBox(
                  height: 15,
                ),
                AchievementDocumentSectionWidget(
                  data: data,
                  title: "دستاوردها",
                  achievements: _documentController
                      .resultGetDocument.value.data!.achievements,
                )
              ],
            ),
          ),
        ],
      );

  Widget insetDocument() {
    return Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: dataList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          SetNewJob.setJob(context,
                              data.data!.profile!.id.toString(), "no");
                        } else if (index == 1) {
                          SetNewEdu.setEdu(context,
                              data.data!.profile!.id.toString(), "no");
                        } else {
                          SetNewAch.setAch(context,
                              data.data!.profile!.id.toString(), "no");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: index == 2
                                        ? Colors.white
                                        : AppColors.greyBtBorder))),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Icon(
                                Icons.add,
                                color: AppColors.greenAdd,
                                size: 30,
                              )),
                              Expanded(
                                  flex: 4,
                                  child: CustomText(
                                    color: AppColors.titleColor,
                                    title: dataList[index],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )));
  }

// JobSection() => Stack(
//       alignment: Alignment.topLeft,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomText(
//               title: "سوابق شغلی",
//               color: AppColors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//             GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: _documentController
//                     .resultGetDocument.value.data!.works!.length,
//                 physics: const ScrollPhysics(),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 1 / 0.25),
//                 itemBuilder: (context, index) {
//                   var job = _documentController
//                       .resultGetDocument.value.data!.works![index];
//                   return ItemJobWidget(
//                     onTap: () {
//                       EditDocumentDialog(
//                         context,
//                         "نام سازمان",
//                         "سمت و موقعیت شغلی",
//                         "",
//                         "فعالیت",
//                         "job",
//                         onCancelTitle: () {
//                           Map<String, dynamic> body = {
//                             "_id": job.id,
//                             "type": "work",
//                             "status": false,
//                             "docStatus": "DOC_NOT_CONFIRM"
//                           };
//                           onConfirmAdditional(
//                               body, "ایا برای عدم تایید اطمینان دارید؟");
//                         },
//                         onConfirmtitle: () {
//                           Map<String, dynamic> body = {
//                             "_id": job.id,
//                             "type": "work",
//                             "status": true,
//                             "docStatus": job.attachments!.isEmpty
//                                 ? "CONFIRM"
//                                 : "DOC_CHECKING"
//                           };
//                           onConfirmAdditional(
//                               body, "ایا برای تایید اطمینان دارید؟");
//                         },
//                         onCancel: () {
//                           Map<String, dynamic> body = {
//                             "_id": job.id,
//                             "type": "work",
//                             "status": true,
//                             "docStatus": "DOC_NOT_CONFIRM"
//                           };
//                           onConfirmAdditional(
//                               body, "ایا برای تایید اطمینان دارید؟");
//                         },
//                         onConfirm: () {
//                           Map<String, dynamic> body = {
//                             "_id": job.id,
//                             "type": "work",
//                             "status": true,
//                             "docStatus": "DOC_CONFIRM"
//                           };
//                           onConfirmAdditional(
//                               body, "ایا برای تایید اطمینان دارید؟");
//                         },
//                         name: TextEditingController(
//                           text: job.companyTitle,
//                         ),
//                         name2: TextEditingController(text: job.job),
//                         startDate: TextEditingController(text: job.startYear),
//                         endDate: TextEditingController(text: job.endYear),
//                         isActiveSwitch: job.currentPosition,
//                         atachment: job.attachments,
//                       );
//                     },
//                     date: job.activityYear ?? "",
//                     image: job.company == null ? "" : job.company!.imageUrl,
//                     companyTitle: job.company == null ? "" : job.companyTitle,
//                     job: job.job,
//                     status: job.statusTitle,
//                     onEdit: () {
//                       SetNewJob.setJob(
//                           data.data!.profile!.id.toString(), "edit",
//                           work: job);
//                     },
//                   );
//                 })
//           ],
//         ),
//         ButtonText(
//           onPressed: () {
//             SetNewJob.setJob(data.data!.profile!.id.toString(), "no");
//           },
//           text: 'افزودن سوابق شغلی',
//           height: 40,
//           width: 150,
//           fontSize: 14,
//           borderRadios: 5,
//           bgColor: AppColors.green,
//           textColor: Colors.white,
//         )
//       ],
//     );

// education() => Stack(
//       alignment: Alignment.topLeft,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomText(
//               title: "سوابق تحصیلی",
//               color: AppColors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//             GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: _documentController
//                     .resultGetDocument.value.data!.educations!.length,
//                 physics: const ScrollPhysics(),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 1 / 0.25),
//                 itemBuilder: (context, index) {
//                   var education = _documentController
//                       .resultGetDocument.value.data!.educations![index];
//                   return ItemJobWidget(
//                     onTap: () {
//                       EditDocumentDialog(context, "نام دانشگاه",
//                           "مقطع تحصیلی", "رشته", "تحصیل", "edu",
//                           name: TextEditingController(
//                             text: education.schoolTitle,
//                           ), onConfirmtitle: () {
//                         Map<String, dynamic> body = {
//                           "_id": education.id,
//                           "type": "education",
//                           "status": true,
//                           "docStatus": education.attachments!.isEmpty
//                               ? "CONFIRM"
//                               : "DOC_CHECKING"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای تایید اطمینان دارید؟");
//                       }, onCancelTitle: () {
//                         Map<String, dynamic> body = {
//                           "_id": education.id,
//                           "type": "education",
//                           "status": false,
//                           "docStatus": "DOC_NOT_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای عدم تایید اطمینان دارید؟");
//                       }, onConfirm: () {
//                         Map<String, dynamic> body = {
//                           "_id": education.id,
//                           "type": "education",
//                           "status": true,
//                           "docStatus": "DOC_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای تایید اطمینان دارید؟");
//                       }, onCancel: () {
//                         Map<String, dynamic> body = {
//                           "_id": education.id,
//                           "type": "education",
//                           "status": true,
//                           "docStatus": "DOC_NOT_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای تایید اطمینان دارید؟");
//                       },
//                           atachment: education.attachments,
//                           name2: TextEditingController(
//                               text: education.schoolTitle),
//                           name3: TextEditingController(
//                               text: education.schoolTitle),
//                           startDate: TextEditingController(
//                               text: education.startYear),
//                           endDate:
//                               TextEditingController(text: education.endYear),
//                           isActiveSwitch: education.currentCourse);
//                     },
//                     date: education.activityYear ?? "",
//                     image: education.school == null
//                         ? ""
//                         : education.school!.imageUrl,
//                     companyTitle: education.school == null
//                         ? ""
//                         : education.school!.title ?? "",
//                     job: education.schoolTitle ?? "",
//                     status: education.statusTitle ?? "",
//                     onEdit: () {
//                       SetNewEdu.setEdu(
//                           data.data!.profile!.id.toString(), "edit",
//                           education: education);
//                     },
//                   );
//                 })
//           ],
//         ),
//         ButtonText(
//           onPressed: () {
//             SetNewEdu.setEdu(data.data!.profile!.id.toString(), "no");
//           },
//           text: 'افزودن سوابق تحصیلی',
//           height: 40,
//           width: 150,
//           fontSize: 14,
//           borderRadios: 5,
//           bgColor: AppColors.green,
//           textColor: Colors.white,
//         )
//       ],
//     );

// achievment() => Stack(
//       alignment: Alignment.topLeft,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomText(
//               title: "دست آورد ها",
//               color: AppColors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//             GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: _documentController
//                     .resultGetDocument.value.data!.achievements!.length,
//                 physics: const ScrollPhysics(),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 1 / 0.25),
//                 itemBuilder: (context, index) {
//                   var achievment = _documentController
//                       .resultGetDocument.value.data!.achievements![index];
//                   return ItemJobWidget(
//                     onTap: () {
//                       EditDocumentDialog(
//                           context,
//                           "محل اخذ",
//                           "عنوان دست آورد یا جایزه کسب شده",
//                           "سال اخذ",
//                           "",
//                           "ach", onCancelTitle: () {
//                         Map<String, dynamic> body = {
//                           "_id": achievment.id,
//                           "type": "achievement",
//                           "status": false,
//                           "docStatus": "DOC_NOT_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای عدم تایید اطمینان دارید؟");
//                       }, onConfirmtitle: () {
//                         Map<String, dynamic> body = {
//                           "_id": achievment.id,
//                           "type": "achievement",
//                           "status": true,
//                           "docStatus": achievment.attachments!.isEmpty
//                               ? "CONFIRM"
//                               : "DOC_CHECKING"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای  تایید اطمینان دارید؟");
//                       }, onConfirm: () {
//                         Map<String, dynamic> body = {
//                           "_id": achievment.id,
//                           "type": "achievement",
//                           "status": true,
//                           "docStatus": "DOC_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای تایید اطمینان دارید؟");
//                       }, onCancel: () {
//                         Map<String, dynamic> body = {
//                           "_id": achievment.id,
//                           "type": "achievement",
//                           "status": true,
//                           "docStatus": "DOC_NOT_CONFIRM"
//                         };
//                         onConfirmAdditional(
//                             body, "ایا برای تایید اطمینان دارید؟");
//                       },
//                           name: TextEditingController(
//                             text: achievment.title,
//                           ),
//                           atachment: achievment.attachments,
//                           name2:
//                               TextEditingController(text: achievment.place),
//                           name3: TextEditingController(text: achievment.year),
//                           endDate: TextEditingController(text: "55555"),
//                           startDate: TextEditingController(text: "222222"));
//                     },
//                     date: achievment.year,
//                     image: "",
//                     companyTitle: achievment.title,
//                     job: achievment.place,
//                     status: achievment.statusTitle,
//                     onEdit: () {
//                       SetNewAch.setAch(
//                           data.data!.profile!.id.toString(), "edit",
//                           achievement: achievment);
//                     },
//                   );
//                 })
//           ],
//         ),
//         ButtonText(
//           onPressed: () {
//             SetNewAch.setAch(data.data!.profile!.id.toString(), "no");
//           },
//           text: 'افزودن دست اورد',
//           height: 40,
//           width: 150,
//           fontSize: 14,
//           borderRadios: 5,
//           bgColor: AppColors.green,
//           textColor: Colors.white,
//         )
//       ],
//     );

// onConfirmAdditional(Map<String, dynamic> body, String title) {
//   MyAlert.deleteBottomSheet(
//       text: title,
//       title: "توجه",
//       onCancel: () {
//         Get.back();
//       },
//       onConfirm: () async {
//         MyAlert.loding();
//         await _documentController.confirmAdditional(
//             data.data!.profile!.id!, body);
//         if (_documentController.failureMessageConfirmAdditional.value != "") {
//           Get.back();
//           MyAlert.mySnakbarRed(
//               text:
//                   _documentController.failureMessageConfirmAdditional.value);
//         } else {
//           Get.back();
//           Get.back();
//           Get.back();
//           _documentController.getDocument(data.data!.profile!.id!);
//         }
//       });
// }
}
