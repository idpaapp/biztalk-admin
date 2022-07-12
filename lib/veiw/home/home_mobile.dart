import 'package:biztalk_panel_admin/model/home/info_home_model.dart';
import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/master_page.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/drawer/drawer_page.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/bank_account_section.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/check_list_section/check_list_section.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/insert_user/insert_user_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/media/media_list_section.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/off/off_page.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/report/report_list_section.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/request_list/request_list_section.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/session/session_list_section.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/container_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/row_in_table_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/text_fiels_custom_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_page.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleData {
  final String? title;
  final String? number;
  final Color bgColor;

  SingleData({this.title, this.number, required this.bgColor});
}

class HomeMobilePage extends StatelessWidget {
  final TextEditingController _search = TextEditingController();
  late List<SingleData> data;

  HomeMobilePage(
      {Key? key, required this.homeController, required this.offController})
      : super(key: key);

  final HomeController homeController;

  final OffController offController;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: getBody(context),
        key: drawerKey,
        drawer: MyDrawer(),
      );

  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(children: [
          TopSectionPanelAdmin(
              title: "کاربران",
              showBottom: false,
              showLeading: true,
              drawer: InkWell(
                onTap: () {
                  drawerKey.currentState!.openDrawer();
                },
                child: Icon(Icons.menu, size: 30, color: Colors.white),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Obx(() {
              if (homeController.tab.value == 1) {
                return BankAccountSection();
              } else if (homeController.tab.value == 2) {
                return CheckListSection();
              } else if (homeController.tab.value == 3) {
                return RequestListSection();
              } else if (homeController.tab.value == 4) {
                return SessionListSection();
              } else if (homeController.tab.value == 5) {
                return ReportListSection();
              } else if (homeController.tab.value == 6) {
                return MediaListSection();
              } else if (homeController.tab.value == 7) {
                return OffPage();
              } else if (homeController.tab.value == 8) {
                homeController.fetchUsers(1, status: "CHECKING");
                return userListSection();
              } else if (homeController.tab.value == 11) {
                if (homeController.userType.value == "عادی") {
                  return SingleUserPage(
                      userType: homeController.userType.value,
                      id: homeController.userId.value);
                } else {
                  return SingleMentorPage(
                    userType: homeController.userType.value,
                    finalID: homeController.userId.value,
                  );
                }
              } else if (homeController.tab.value == 0) {
                homeController.fetchUsers(1);
                return userListSection();
              } else {
                return const SizedBox();
              }
            }),
          ),
        ]),
      );

  Widget userListSection() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            TextFieldsCustomWidget(
              searchController: _search,
              onTap: () {
                homeController.fetchUsers(1, mobile: _search.text);
              },
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const TitleRowInTableWidget(
              isTitle: true,
              image: "",
              userName: "نام کاربری",
              userType: "نوع کاربر",
              mainUserName: "نام و نام خانوادگی",
              phoneNumber: "شماره تلفن",
            ),
            Obx(() {
              if (homeController.failureMessage.value != "") {
                return SizedBox(
                  height: 100,
                  width: Get.width,
                  child: Center(
                      child: CustomText(
                    title: homeController.failureMessage.value,
                  ),),
                );
              } else if (homeController.isLoadingHome.value) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController
                            .resultHomeUsers.value.data!.users!.length,
                        itemBuilder: (context, index) {
                          var user = homeController
                              .resultHomeUsers.value.data!.users![index];
                          return TitleRowInTableWidget(
                            onTap: () {
                              homeController.userType.value = user.userType!;
                              homeController.userId.value = user.id!;
                              homeController.tab.value = 11;
                            },
                            isTitle: false,
                            phoneNumber: user.phoneNumber ?? "",
                            mainUserName: user.fullName ?? "",
                            userType: user.userType ?? "",
                            userName: user.userName ?? "",
                            image: user.profileImage ?? "",
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    pageSection(homeController.resultHomeUsers.value),
                  ],
                );
              }
            },),
          ],
        ),
      );

  Widget pageSection(UsersHomeModel value) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          value.data!.totalPages! <= 5
              ? const SizedBox(
                  height: 0,
                )
              : const InkWell(
                  child: Icon(Icons.double_arrow, color: AppColors.dividerDark),
                ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 30,
            width: 1,
            color: AppColors.dividerDark,
          ),
          const SizedBox(
            width: 15,
          ),
          ListView.builder(
              itemCount: value.data!.totalPages,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      homeController.selectedPage.value = index + 1;
                      homeController.fetchUsers(index + 1);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index + 1 == homeController.selectedPage.value
                              ? AppColors.blueIndigo
                              : Colors.white),
                      child: Center(
                        child: CustomText(
                          title: "${index + 1}",
                          color: index + 1 == homeController.selectedPage.value
                              ? Colors.white
                              : AppColors.dividerDark,
                        ),
                      ),
                    ),
                  ),
                );
              },),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 30,
            width: 1,
            color: AppColors.dividerDark,
          ),
          const SizedBox(
            width: 15,
          ),
          value.data!.totalPages! <= 5
              ? const SizedBox(
                  height: 0,
                )
              : const InkWell(
                  child: Icon(
                    Icons.double_arrow,
                    color: AppColors.dividerDark,
                  ),
                ),
        ],
      ),
    );
  }
}
