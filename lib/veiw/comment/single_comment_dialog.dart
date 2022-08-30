import 'package:biztalk_panel_admin/model/get_answers_model.dart';
import 'package:biztalk_panel_admin/resources/all_methods.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/row_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/tashrihi_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> singleCommentDialog(BuildContext context, {onConfirm,AnswersModel? answersModel}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: Get.height * 0.7,
          width: Get.width * 0.5,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(answersModel!),
                  const SizedBox(
                    height: 40,
                  ),
                  listView(answersModel),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.builder(shrinkWrap: true,
                      itemCount:answersModel.answers!.longAnswers!.length,
                      itemBuilder: (context, index) {
                    var data=answersModel.answers!.longAnswers![index];
                        return  TashrihiAnswerWidget(
                          question: data.questionText,
                          answer:data.description);
                      })

                ],
              )),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: Get.width * 0.02),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ButtonText(
                onPressed: onConfirm,
                text: "تایید",
                borderRadios: 10,
                fontWeight: FontWeight.w500,
                height: 40,
                fontSize: 14,
                width: 70,
                textColor: Colors.white,
                bgColor: AppColors.blueSession,
              ),
              const SizedBox(
                width: 10,
              ),
              ButtonText(
                borderRadios: 10,
                onPressed: () {
                  Get.back();
                },
                text: "انصراف",
                height: 40,
                fontSize: 14,
                width: 70,
                fontWeight: FontWeight.w500,
                textColor: AppColors.blueSession,
                bgColor: Colors.white,
                borderColor: AppColors.blueSession,
                activeBorder: 1,
              ),
            ]),
          ),
        ],
      );
    },
  );
}

Widget listView(AnswersModel answersModel) =>
    ListView.builder(
      itemCount: answersModel.answers!.singleAnswers!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data=answersModel.answers!.singleAnswers![index];
        return RowDialogWidget(
          rate: data.score,
          answer: data.answerTitle,
          question: data.questionText,
        );
      },
    );

Widget title(AnswersModel answersModel) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         CustomText(
            title: "جلسه مشاوره ${answersModel.mentorFullName.toString()} و ${answersModel.userFullNameuserFullName}",
            fontWeight: FontWeight.w700,
            fontSize: 16),
        Row(
          children: [
            const Center(
                child: CustomText(
                    title: "میانگین امتیاز",
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 12,
            ),
            Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AllMethods.commentColor(answersModel.average!)),
                child:  CustomText(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    title: answersModel.average!.toStringAsFixed(1).toString())),
          ],
        ),
      ],
    );
