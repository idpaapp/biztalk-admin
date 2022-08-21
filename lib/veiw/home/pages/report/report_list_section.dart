import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/report/report_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/bank_section/row_bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ReportListSection extends StatelessWidget {
  ReportListSection({Key? key}) : super(key: key){
_homeController.selectedPage.value =1;
    _homeController.reportList(1);
  }
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) =>Container(
    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.white),
    child: Column(
      children: [

        const RowBankWidget(
          isReportList: true,
          isTitle: true,
          oneColumn: "گزارش دهنده'",
          twoColumn: "متخلف",
          threeColumn: "تاریخ",
          fourColumn: "عنوان",


        ),
        Obx(() {
          if (_homeController.failureMessageReportList.value != "") {
            return SizedBox(
              height: 100,
              width: Get.width,
              child: Center(
                  child: CustomText(
                    title: _homeController.failureMessageReportList.value,
                  )),
            );
          } else if (_homeController.isLoadingReportList.value) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }  else {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _homeController
                        .resultReportList.value.data!.report!.length,
                    itemBuilder: (context, index) {
                      var report =_homeController
                          .resultReportList.value.data!.report![index];
                      return   RowBankWidget(

                        isTitle: false,
                        isReportList: true,
                        oneColumn:report.plaintiff == null ? "": report.plaintiff!.fullName ??"",


                        twoColumn:report.accused == null ? "":report.accused!.fullName ??"",
                        threeColumn: report.createdAt??"",
                        fourColumn: report.subject!.title??"",
                        sixColumn: "",
                        fiveColumn: "",



                        onTap: (){


                             reportDialog(context, "گزارش تخلف",report);


                        },

                      );
                    }),  SizedBox(
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
    var data = _homeController.resultReportList.value.data!;
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
                      _homeController.reportList(index + 1);
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
