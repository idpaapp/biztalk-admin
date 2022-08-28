import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/ask_me/dialog/response_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/bank_section/row_bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskMeSection extends StatelessWidget {
  AskMeSection({Key? key}) : super(key: key) {
    _homeController.selectedPage.value = 88;
    _homeController.getQuestions();
    _homeController.askMeFilter.value="All";
  }

  List<FilterModel> listFilter = [
    FilterModel(key: "All", title: "همه"),
    FilterModel(key: "pending", title: "در انتظار پاسخ"),
    FilterModel(key: "answered", title: "پاسخ داده شده"),
    FilterModel(key: "reject", title: "رد شده"),
  ];
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),

        height: 30,
        child: ListView.builder(
            itemCount: listFilter.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var data=listFilter[index];
              return Obx(()=>ButtonText(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                onPressed: () {
                  _homeController.askMeFilter.value=data.key!;
                  _homeController.getQuestions(status: _homeController.askMeFilter.value);

                },
                text: listFilter[index].title,
                fontSize: 14,
                textColor: Colors.white,
                bgColor: data.key == _homeController.askMeFilter.value ? AppColors.masterColor:AppColors.bgChip,
              ));
            }),
      ),
      const SizedBox(height: 24,),

      Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              children: [
                const RowBankWidget(
                  isRequestList: true,
                  isTitle: true,
                  oneColumn: "موضوع",
                  twoColumn: "تاریخ ایجاد سوال",
                  threeColumn: "سوال کننده",
                  fourColumn: "وضعیت",
                  fiveColumn: "پاسخ دهنده",
                ),
                Obx(() {
                  if (_homeController.failureMessageGetQuestions.value != "") {
                    return SizedBox(
                      height: 100,
                      width: Get.width,
                      child: Center(
                          child: CustomText(
                        title: _homeController.failureMessageGetQuestions.value,
                      )),
                    );
                  } else if (_homeController.isLoadingGetQuestions.value) {
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
                                .resultGetQuestions.value.data!.questions!.length,
                            itemBuilder: (context, index) {
                              var question = _homeController
                                  .resultGetQuestions.value.data!.questions![index];
                              return RowBankWidget(
                                statusForColor: question.status,
                                isTitle: false,
                                oneColumn: question.title ?? "نامشخص",
                                twoColumn: question.dateTime ?? "نامشخص",
                                threeColumn: question.questioner == null
                                    ? "نا مشخص"
                                    : question.questioner!.fullName ?? "نا مشخص",
                                fourColumn: question.statusTitle ?? "نا مشخص",
                                isRequestList: true,
                                isChips: true,
                                fiveColumn: question.responder == null
                                    ? "نا مشخص"
                                    : question.responder!.userAnswer == null
                                        ? "نا مشخص"
                                        : question
                                                .responder!.userAnswer!.fullName ??
                                            "نا مشخص",
                                onTap: () async {
                                  MyAlert.loding();
                                  await _homeController.getMentorForAsk();
                                  Get.back();
                                  if(_homeController.failureMessageGetMentor.value !=""){
                                    MyAlert.mySnakbarRed(text:_homeController.failureMessageGetMentor.value );
                                  }else{
                                    _homeController.mentorTitle.value=_homeController.resultGetMentor.value.data!.first.fullName!;
                                    _homeController.mentorId.value=_homeController.resultGetMentor.value.data!.first.id!;
                                    responseDialogS(context,title:  question.title ?? "",question: question.question??"",id: question.id);


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
          ),
    ],
  );

  Widget pageSection() {
    var data = _homeController.resultGetQuestions.value.data!;
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
                      _homeController.requestList(index + 1);
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

class FilterModel {
  final String? title;
  final String? key;

  FilterModel({this.title, this.key});
}
