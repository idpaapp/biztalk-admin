import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/calender/calender_page.dart';
import 'package:biztalk_panel_admin/veiw/create_off/create_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/profile_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_page.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_and_session_page.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_controller.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/middle_container_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_title_table_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_page.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_page.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleMentorPage extends StatelessWidget {
  static const route = "/singleMentorPage";

  final String? rout;
  late String finalID;
  late String userType;

  SingleMentorPage({
    Key? key,
    this.rout,
  }) : super(key: key) {
    finalID = Get.arguments["id"];
    _singleMentorController.fetchMentor(finalID);
    userType = Get.arguments['userType'];
    print(userType);
    print(finalID);
  }

  final SingleMentorController _singleMentorController =
      Get.put(SingleMentorController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: Obx(() {
          if (_singleMentorController.failureMessageFetchUser.value != "") {
            return Center(
              child: CustomText(
                  title: _singleMentorController.failureMessageFetchUser.value),
            );
          } else if (_singleMentorController.isLoadingFetchUser.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return getBody(
                context, _singleMentorController.resultFetchUser.value);
          }
        }),
      );

  Widget getBody(BuildContext context, MentorModel value) {
    _singleMentorController.switchValue.value =
        value.data!.profile!.status == "ACTIVE" ? true : false;
    return SingleChildScrollView(
      child: Column(children: [
        TopSectionPanelAdmin(
          title: "کاربران" " /" "rout",
          onDashbord: () {
            Get.back();
          },
        ),
        SizedBox(
          height: Get.height * 0.07,
        ),
        Obx(() => ProfileSectionWidget(
              userType: userType,
              showSwitch: true,
              statustitle: value.data!.profile!.statusTitle,
              status: value.data!.profile!.status,
              onSwitchBtn: () {
                Get.offAndToNamed(SingleUserPage.route,
                    arguments: {"id": finalID, "userType": userType});
              },
              isUser: false,
              image: value.data!.profile!.profile ?? "",
              onSwitchChange: (valueSwitch) async {
                MyAlert.loding();
                await _singleMentorController.changeStatus(
                    value.data!.profile!.id.toString(),
                    valueSwitch ? "ACTIVE" : "DE_ACTIVE");
                Get.back();
                if (_singleMentorController.failureMessageChangeStatus.value !=
                    "") {
                  MyAlert.mySnakbarRed(
                      text: _singleMentorController
                          .failureMessageChangeStatus.value);
                } else {
                  _singleMentorController.switchValue.value = valueSwitch;
                  _homeController.fetchInfoHome();
                  _homeController.fetchUsers(1);
                }
              },
              switchValue: _singleMentorController.switchValue.value,
              onEdit: () {
                showMyDialog(
                  context,
                  userType: userType,
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
              },
              fullName: value.data!.profile!.fullName,
              jobTitle: value.data!.profile!.jobTitle ?? "",
            )),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MiddleContainerWidget(
                    onTap: () {
                      print(english());
                      Get.toNamed(CalenderPage.route, arguments: {
                        "date": english(),
                        "mentorId": value.data!.profile!.id
                      });
                    },
                    title: "تقویم",
                    detail: "",
                    isBottomIcon: false,
                  ),
                  MiddleContainerWidget(
                    onTap: () {
                      var profile = value.data!.profile!;

                      Get.toNamed(TransactionPage.route, arguments: {
                        "image": profile.profile ?? "",
                        "fullName": profile.fullName,
                        "jobTitle": profile.jobTitle ?? "",
                        "typeUser": "mentor",
                        "id": profile.id,
                      });
                    },
                    title: "گردش حساب",
                    detail: "4.3145000 ریال تسویه",
                    isBottomIcon: false,
                    isBullet:
                        value.data!.profile!.isConfirmDocs! ? true : false,
                  ),
                  MiddleContainerWidget(
                    title: "سوابق",
                    detail: "سوابق تایید نشده",
                    isBullet: true,
                    onTap: () {
                      Get.to(() => DocumentPage(
                            data: value,
                          ));
                    },
                    isBottomIcon:
                        value.data!.profile!.isConfirmDocs! ? true : false,
                  ),
                  const MiddleContainerWidget(
                    title: "نقد و نظرات کاربران",
                    detail: "4.3 امتیاز کسب شده",
                    isBottomIcon: true,
                  ),
                  MiddleContainerWidget(
                    onTap: () {
                      Get.to(
                        () => RequestAndSessionPage(
                          userType: "mentor",
                        ),
                      );
                    },
                    title: "درخواست ها و جلسات",
                    detail: "",
                    isBottomIcon: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                children: [
                  MiddleContainerWidget(
                    title: "راه های ارتباطی و رسانه ها",
                    detail: "",
                    isBottomIcon: false,
                    onTap: () {
                      var profile = value.data!.profile!;
                      Get.toNamed(TvPage.route, arguments: {
                        "image": profile.profile,
                        "fullName": profile.fullName,
                        "jobTitle": profile.jobTitle,
                        "id": profile.id,
                      });
                      // contactDialog(context,value.data!.profile!.id.toString());
                    },
                  ),
                  SizedBox(
                    width: Get.width * 0.025,
                  ),
                  MiddleContainerWidget(
                    title: "تعریف کد تخفیف",
                    detail: "",
                    isBottomIcon: false,
                    onTap: () {
                      createOffer(context,
                          title: "تعریف کد تخفیف",
                          id: finalID,
                          name: _singleMentorController
                              .resultFetchUser.value.data!.profile!.fullName,
                          userType: 'mentor');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        mainSection(value),
        SizedBox(
          height: Get.height * 0.03,
        ),
      ]),
    );
  }

  mainSection(MentorModel value) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
            title: "چیزها",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterBlack,
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileTitleTableWidget(
            isTitle: true,
            userName: "درخواست دهنده",
            stateTitle: "وضعیت",
            createDate: "تاریخ ایجاد درخواست",
            sessionDate: "زمان جلسه",
            subject: "موضوع",
            state: null,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: value.data!.requests!.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var req = value.data!.requests![index];
                return ProfileTitleTableWidget(
                  isTitle: false,
                  userName: req.requestOwnerName ?? "نا مشحص",
                  stateTitle: req.statusTitle ?? "نامشخص",
                  createDate: req.createdAt ?? "نا مشخص",
                  sessionDate: req.startTime ?? "نا مشخص",
                  subject: req.subject ?? "نامشخص",
                  state: req.status ?? "نا مشخص",
                );
              }),
          const SizedBox(
            height: 20,
          ),
        ]),
      );
}
