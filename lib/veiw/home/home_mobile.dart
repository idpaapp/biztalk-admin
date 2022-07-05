import 'package:biztalk_panel_admin/model/home/info_home_model.dart';
import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
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

class HomeDesctopPage extends StatelessWidget {
  final TextEditingController _search = TextEditingController();

  HomeDesctopPage(
      {Key? key, required this.homeController, required this.offController})
      : super(key: key);
  final HomeController homeController;

  final OffController offController;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: getBody(context),
      );

  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(children: [
          const TopSectionPanelAdmin(title: "کاربران"),
          SizedBox(
            height: Get.height * 0.07,
          ),
          containerSection(homeController.resultFetchHome.value, context),
          SizedBox(
            height: Get.height * 0.07,
          ),
          Obx(() {
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
            } else if (homeController.tab.value == 0) {
              homeController.fetchUsers(1);
              return userListSection();
            } else {
              return const SizedBox();
            }
          }),
          const SizedBox(
            height: 30,
          )
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
                  )),
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
                              if (user.userType == "عادی") {


                                Get.toNamed(SingleUserPage.route, arguments: {
                                  "id": user.id.toString(),
                                  "userType": user.userType
                                });
                              } else {

                                Get.toNamed(SingleMentorPage.route, arguments: {
                                  "id": user.id.toString(),
                                  "userType": user.userType
                                });
                              }
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
            }),
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
              }),
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

  Widget containerSection(HomeInfoModel homeInfoModel, BuildContext context) =>
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "لیست کاربران",
                    onTap: () {
                      homeController.tab.value = 0;
                    },
                    number: homeInfoModel.data!.userCount,
                    borderColor: homeController.tab.value == 0
                        ? Colors.red
                        : AppColors.blueDark,
                    bgColors: AppColors.blueDark,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "حساب بانکی تایید شده",
                    onTap: () {
                      homeController.tab.value = 1;
                    },
                    borderColor: homeController.tab.value == 1
                        ? Colors.red
                        : AppColors.blueBgContainer,
                    number: homeInfoModel.data!.notVerifiedAccount,
                    bgColors: AppColors.blueBgContainer,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "درخواست تسویه حساب",
                    onTap: () {
                      homeController.tab.value = 2;
                    },
                    number: homeInfoModel.data!.checkOutCount,
                    bgColors: AppColors.yellowBg,
                    borderColor: homeController.tab.value == 2
                        ? Colors.red
                        : AppColors.yellowBg,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "درخواست جلسه",
                    onTap: () {
                      homeController.tab.value = 3;
                    },
                    borderColor: homeController.tab.value == 3
                        ? Colors.red
                        : AppColors.blueDark,
                    number: homeInfoModel.data!.requestCount,
                    bgColors: AppColors.blueDark,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "جلسه(نیاز به بررسی)",
                    onTap: () {
                      homeController.tab.value = 4;

                      // sessionDialog(context,"اطلاعات جلسه");
                    },
                    borderColor: homeController.tab.value == 4
                        ? Colors.red
                        : AppColors.greenBg,
                    number: homeInfoModel.data!.sessionCount,
                    bgColors: AppColors.greenBg,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Obx(
                () => Expanded(
                  child: ContainerSectionWidget(
                    title: "گزارش تخلف",
                    onTap: () {
                      homeController.tab.value = 5;
                    },
                    number: homeInfoModel.data!.reportCount,
                    borderColor: homeController.tab.value == 5
                        ? Colors.white
                        : AppColors.red,
                    bgColors: AppColors.red,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Expanded(
                    child: ContainerSectionWidget(
                      title: "رسانه جدیدوارد شده",
                      onTap: () {
                        homeController.tab.value = 6;
                      },
                      number: homeInfoModel.data!.tvCount,
                      borderColor: homeController.tab.value == 6
                          ? Colors.red
                          : AppColors.yellowBg,
                      bgColors: AppColors.yellowBg,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Obx(
                  () => Expanded(
                    child: ContainerSectionWidget(
                      title: " کدهای تخفیف",
                      onTap: () async {
                        homeController.tab.value = 7;
                      },
                      number: 1371,
                      borderColor: homeController.tab.value == 7
                          ? Colors.red
                          : AppColors.yellowBg,
                      bgColors: AppColors.yellowBg,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Obx(
                  () => Expanded(
                    child: ContainerSectionWidget(
                      title: "کاربران بررسی نشده",
                      onTap: () {
                        homeController.tab.value = 8;
                      },
                      number: homeInfoModel.data!.userChecking,
                      borderColor: homeController.tab.value == 8
                          ? Colors.red
                          : AppColors.blueDark,
                      bgColors: AppColors.blueDark,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Obx(
                  () => Expanded(
                    child: ContainerSectionWidget(
                      title: "مدیریت صفحه اصلی",
                      onTap: () {
                        homeController.tab.value = 9;
                        Get.to(() => ManagerPage());
                      },
                      number: 0,
                      borderColor: homeController.tab.value == 9
                          ? Colors.red
                          : AppColors.blueDark,
                      bgColors: AppColors.blueDark,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Expanded(
                  child: ContainerSectionWidget(
                    title: "افزودن کاربر جدید",
                    onTap: () {
                      homeController.tab.value = 0;
                      insertUser(context, "افزودن کاربر جدید");
                    },
                    number: 0,
                    borderColor: AppColors.blueDark,
                    bgColors: AppColors.blueDark,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      );
}
