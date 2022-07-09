import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/master_page.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/calender/calender_page.dart';
import 'package:biztalk_panel_admin/veiw/create_off/create_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/profile_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_page.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_and_session_page.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_controller.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/user_section.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/middle_container_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_title_table_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_controller.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_page.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleMentorPage extends StatelessWidget {
  final String? rout;
  final String? finalID;
  final String? userType;

  SingleMentorPage({
    Key? key,
    this.rout,
    this.finalID,
    this.userType,
  }) : super(key: key) {
    _singleMentorController.selectedChangeUser.value = 0;
    _singleMentorController.fetchMentor(finalID!);
  }

  List data = [
    "اکانت مشاور",
    "اکانت کاربر عادی",
  ];

  final SingleMentorController _singleMentorController =
      Get.put(SingleMentorController());
  final HomeController _homeController = Get.put(HomeController());
  final SingleUserController _singleUserController =
      Get.put(SingleUserController());

  @override
  Widget build(BuildContext context) => Obx(() {
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
      });

  Widget getBody(BuildContext context, MentorModel value) {

    _singleMentorController.switchValue.value =
        value.data!.profile!.status == "ACTIVE" ? true : false;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(children: [
          Obx(() => ProfileSectionWidget(
                userType: userType,
                showSwitch: true,
                statustitle: value.data!.profile!.statusTitle,
                status: value.data!.profile!.status,
                tab: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 22, right: 150),
                    height: 30,
                    child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Obx(() => InkWell(
                                onTap: () {
                                  _singleMentorController
                                      .selectedChangeUser.value = index;
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: _singleMentorController
                                                        .selectedChangeUser
                                                        .value ==
                                                    index
                                                ? AppColors.blueSession
                                                : Colors.white,
                                            width: 3),
                                      ),
                                    ),
                                    child: CustomText(
                                      title: data[index],
                                      fontSize: 14,
                                      color: Colors.black,
                                    )),
                              ));
                        }),
                  ),
                ),
                onSwitchBtn: () {},
                isUser: false,
                image: value.data!.profile!.profile ?? "",
                onSwitchChange: (valueSwitch) async {
                  MyAlert.loding();
                  await _singleMentorController.changeStatus(
                      value.data!.profile!.id.toString(),
                      valueSwitch ? "ACTIVE" : "DE_ACTIVE");
                  Get.back();
                  if (_singleMentorController
                          .failureMessageChangeStatus.value !=
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
          Obx(() {
            if (_singleMentorController.selectedChangeUser.value == 0) {
              return Obx(() {
                if (_singleMentorController.failureMessageFetchUser.value !=
                    "") {
                  _singleMentorController.fetchMentor(finalID!);

                  return Center(
                    child: CustomText(
                        title: _singleMentorController
                            .failureMessageFetchUser.value),
                  );
                } else if (_singleMentorController.isLoadingFetchUser.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return mentroSection(
                      _singleMentorController.resultFetchUser.value, context);
                }
              });
            } else {
              _singleUserController.fetchUser(finalID!);
              return Obx(() {
                if (_singleUserController.failureMessageFetchUser.value != "") {
                  return Center(
                    child: CustomText(
                        title: _singleUserController
                            .failureMessageFetchUser.value),
                  );
                } else if (_singleUserController.isLoadingFetchUser.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return UserSectionWidget(
                    value: _singleUserController.resultFetchUser.value,
                    id: finalID,
                  );
                }
              });
            }
          }),
          SizedBox(
            height: Get.height * 0.03,
          ),
        ]),
      ),
    );
  }

  mainSectionMentor(
    MentorModel value,
  ) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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

  Widget mentroSection(MentorModel value, BuildContext context) => Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MiddleContainerWidget(
                      colors: AppColors.yellowCalandar,
                      onTap: () {
                        Get.toNamed(CalenderPage.route, arguments: {
                          "date": english(),
                          "mentorId": value.data!.profile!.id
                        });
                      },
                      title: "تقویم",
                      iconData: Icons.calendar_today_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: MiddleContainerWidget(
                      colors: AppColors.greenBank,
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
                      isBullet:
                          value.data!.profile!.isConfirmDocs! ? true : false,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: MiddleContainerWidget(
                      colors: AppColors.pinkDucument,
                      title: "سوابق",
                      isBullet: true,
                      onTap: () {
                        Get.to(() => DocumentPage(
                              data: value,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: MiddleContainerWidget(
                      title: "نقد و نظرات کاربران",
                      colors: AppColors.orangHome,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: MiddleContainerWidget(
                      onTap: () {
                        Get.to(
                          () => RequestAndSessionPage(
                            userType: "mentor",
                          ),
                        );
                      },
                      title: "درخواست ها و جلسات",
                      colors: AppColors.blueSession,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: MiddleContainerWidget(
                      colors: AppColors.blueSession,
                      title: "راه های ارتباطی و رسانه ها",
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
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: MiddleContainerWidget(
                      colors: AppColors.blueSession,
                      title: "تعریف کد تخفیف",
                      onTap: () {
                        createOffer(context,
                            title: "تعریف کد تخفیف",
                            id: finalID,
                            name: _singleMentorController
                                .resultFetchUser.value.data!.profile!.fullName,
                            userType: 'mentor');
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          mainSectionMentor(value),
          SizedBox(
            height: Get.height * 0.03,
          ),
        ],
      );
}
