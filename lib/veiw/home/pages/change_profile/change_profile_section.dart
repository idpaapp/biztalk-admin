import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/profile_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/new_document/new_document_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProfileSection extends StatelessWidget {
  ChangeProfileSection({Key? key}) : super(key: key) {
    _homeController.changeProfile();
  }

  final HomeController _homeController = Get.find();
  final SingleMentorController _singleMentorController =
      Get.put(SingleMentorController());

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            const NewDocumentWidget(
              isTitle: true,
              threeColumn: "گزینه تغیر یافته",
              oneColumn: "نام و نام خانوادگی",
              twoColumn: "نام کاربری",
              isThree: true,
            ),
            Column(
              children: [
                Obx(() {
                  if (_homeController.failureMessageChangeProfile.value != "") {
                    return Center(
                      child: CustomText(
                          title: _homeController
                              .failureMessageChangeProfile.value),
                    );
                  } else if (_homeController.isLoadingChangeProfile.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _homeController
                          .resultChangeProfile.value.data!.length,
                      itemBuilder: (context, index) {
                        var data = _homeController
                            .resultChangeProfile.value.data![index];
                        return NewDocumentWidget(
                          onTap: () async {
                            MyAlert.loding();
                            await _singleMentorController.fetchMentor(data.id!);
                            Get.back();
                            if(_singleMentorController.failureMessageFetchUser.value !=""){
                              MyAlert.mySnakbarRed(text: _singleMentorController.failureMessageFetchUser.value);
                            }else{
                              var value=_singleMentorController.resultFetchUser.value;
                              showMyDialog(
                                context,
                                userType: "mentor",
                                videoUrl: value.data?.profile!.videoUrl,
                                phone: value.data!.profile!.phone,
                                image: value.data!.profile!.profile,
                                id: value.data!.profile!.id!,
                                jobTitle: value.data!.profile!.jobTitle,
                                aboutMe: value.data!.profile!.description,
                                userName: value.data!.profile!.userName,
                                fullName: value.data!.profile!.fullName,
                                grade: value.data!.profile!.gradeTitle,
                                kils: value.data!.profile!.skills,
                              );
                            }
                          },
                          twoColumn: data.userName,
                          isThree: true,
                          threeColumn: statusTitle(data.aboutMe!.videoStatus!,
                              data.aboutMe!.descriptionStatus!),
                          oneColumn: data.fullName,
                          isTitle: false,
                        );
                      },
                    );
                  }
                }),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                //  pageSection(homeController.resultHomeUsers.value),
              ],
            )
          ],
        ),
      );

  String statusTitle(bool video, bool description) {
    if (!video && !description) {
      return "هردو";
    } else if (!video) {
      return "ویدیو";
    } else if (!description) {
      return "درباره من";
    } else {
      return "";
    }
  }
}
