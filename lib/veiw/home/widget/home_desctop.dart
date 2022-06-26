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
      : super(key: key) {
    HomeInfoModel homeInfoModel = homeController.resultFetchHome.value;
    data = [
      SingleData(
        title: "لیست کاربران",
        number: homeInfoModel.data!.userCount.toString(),
        bgColor: AppColors.blueDark,
      ),
      SingleData(
        title: "حساب بانکی تایید شده",
        number: homeInfoModel.data!.notVerifiedAccount!.toString(),
        bgColor: AppColors.blueBgContainer,
      ),
      SingleData(
        title: "درخواست تسویه حساب",
        number: homeInfoModel.data!.checkOutCount!.toString(),
        bgColor: AppColors.yellowBg,
      ),
      SingleData(
        title: "درخواست جلسه",
        number: homeInfoModel.data!.requestCount!.toString(),
        bgColor: AppColors.blueDark,
      ),
      SingleData(
        title: "جلسه(نیاز به بررسی)",
        number: homeInfoModel.data!.sessionCount!.toString(),
        bgColor: AppColors.greenBg,
      ),
      SingleData(
        title: "گزارش تخلف",
        number: homeInfoModel.data!.reportCount!.toString(),
        bgColor: AppColors.red,
      ),
      SingleData(
        title: "رسانه جدیدوارد شده",
        number: homeInfoModel.data!.tvCount!.toString(),
        bgColor: AppColors.yellowBg,
      ),
      SingleData(
        title: " کدهای تخفیف",
        number: "1371",
        bgColor: AppColors.yellowBg,
      ),
      SingleData(
        title: "کاربران بررسی نشده",
        number: homeInfoModel.data!.userChecking!.toString(),
        bgColor: AppColors.blueDark,
      ),SingleData(
        title: "مدیریت صفحه اصلی",
        number: "0",
        bgColor: AppColors.blueDark,

      ),SingleData(
        title: "افزودن کاربر جدید",
        number: "0",
        bgColor: AppColors.blueDark,

      ),
    ];
  }

  final HomeController homeController;

  final OffController offController;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: getBody(context),
      );

  Widget getBody(
    BuildContext context,
  ) =>
      SingleChildScrollView(
        child: Column(children: [
          const TopSectionPanelAdmin(title: "کاربران"),
          SizedBox(
            height: Get.height * 0.07,
          ),
          containerSection(context),
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
            } else if (homeController.tab.value == 0){
              homeController.fetchUsers(1);
              return userListSection();
            }else{
            return SizedBox();
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
                                Get.toNamed(SingleUserPage.route,
                                    arguments: {"id": user.id.toString(),"userType":user.userType});
                              } else {
                                Get.toNamed(SingleMentorPage.route,
                                    arguments: {"id": user.id.toString(),"userType":user.userType});
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

  Widget containerSection(BuildContext context) => SizedBox(
        height: Get.height * 0.3,
        child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Expanded(
                    child: ContainerSectionWidget(
                      title: data[index].title,
                      onTap: () {
                        homeController.tab.value = index;
                        if(index == 9){
                          Get.to(() => ManagerPage());

                        }
                        if(index == 10){
                          insertUser(context,"افزودن کاربر جدید")
                          ;
                        }
                      },
                      number: int.parse(data[index].number.toString()),
                      borderColor: homeController.tab.value == index
                          ? Colors.red
                          : data[index].bgColor,
                      bgColors: data[index].bgColor,
                    ),
                  ),
                ),
              );
            }),
      );
}
