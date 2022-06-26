import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/session_dialog/session_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/row_bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionListSection extends StatelessWidget {
  SessionListSection({Key? key}) : super(key: key) {
    _homeController.selectedPage.value = 1;

    _homeController.sessionList(1);
  }

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            const RowBankWidget(
              isSessionList: true,
              isTitle: true,
              oneColumn: "نام درخواست دهنده",
              twoColumn: "نام مشاور",
              threeColumn: "زمان شروع جلسه",
              fourColumn: "موضوع",
              fiveColumn: "وضعیت",
              sixColumn: "زمان باقی مانده",
            ),
            Obx(() {
              if (_homeController.failureMessageSessionList.value != "") {
                return SizedBox(
                  height: 100,
                  width: Get.width,
                  child: Center(
                      child: CustomText(
                    title: _homeController.failureMessageSessionList.value,
                  )),
                );
              } else if (_homeController.isLoadingSessionList.value) {
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
                        itemCount: _homeController
                            .resultSessionList.value.data!.session!.length,
                        itemBuilder: (context, index) {
                          var session = _homeController
                              .resultSessionList.value.data!.session![index];
                          return RowBankWidget(
                            isTitle: false,
                            oneColumn: session.user!.fullName ?? "",
                            twoColumn: session.mentor!.fullName ?? "",
                            threeColumn:
                                session.date! + "ساعت " + session.startTime!,
                            fourColumn: session.subject!.title ?? "",
                            isSessionList: true,
                            sixColumn: session.fromNow ?? "",
                            fiveColumn: session.statusTitle ?? "",
                            onTap: () async {
                              MyAlert.loding();
                              await _homeController.singleSession(session.id!);
                              if (_homeController
                                      .failureMessageSingleSession.value !=
                                  "") {
                                Get.back();
                                MyAlert.mySnakbarRed(
                                    text: _homeController
                                        .failureMessageSingleSession.value);
                                return;
                              } else {
                                Get.back();
                                sessionDialog(context, "جلسه", session,
                                    _homeController.resultSingleSession.value);
                              }


                            },
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    pageSection(),
                  ],
                );
              }
            }),
          ],
        ),
      );

  Widget pageSection() {
    var data = _homeController.resultSessionList.value.data!;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.totalPages! <= 5
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
              itemCount: data.totalPages,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      _homeController.selectedPage.value = index + 1;
                      _homeController.sessionList(index + 1);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index + 1 == _homeController.selectedPage.value
                              ? AppColors.blueIndigo
                              : Colors.white),
                      child: Center(
                        child: CustomText(
                          title: "${index + 1}",
                          color: index + 1 == _homeController.selectedPage.value
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
          data.totalPages! <= 5
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
