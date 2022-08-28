import 'package:biztalk_panel_admin/resources/all_methods.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/row_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/tashrihi_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> singleCommentDialog(BuildContext context, {onConfirm}) async {
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
                  title(),
                  const SizedBox(
                    height: 40,
                  ),
                  listView(),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.builder(shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return const TashrihiAnswerWidget(
                          question: "یمنتبیمنئبمنیئبوسی بئمیبئنمیبئ مینئبمنیئبم نیبمئیبئیب",
                          answer: "کمگکزووزییب نسیبن سحنبحسی مسمنی سمنبسی بسی بسیو بیئس بئسی بئسی بئ سئبئسی بئشس ب شسبئد شسئدب ئدسب شس بئدشس بس بسینب یسنب نس بندشنبسدشنسب شسبئ شسبئو شسئب شسئب شئس بئشس بنئشس بئن شسبنشسب شسئب شنئسسب نئش بنئشس بنش سبنشس بن شسبت شسبش سبئشس بئشس بئشس ب",);
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

Widget listView() =>
    ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RowDialogWidget(
          rate: index == 0
              ? 0.1
              : index == 4
              ? 0.5
              : 0.7,
          answer: "عالی",
          question: "میزان رضایت خود از برخورد مشاور چگونه ارزیابی می کنید.",
        );
      },
    );

Widget title() =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(
            title: "جلسه مشاوره سینا جمشییدی طاری و فرزاد زارع",
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
                    color: AllMethods.commentColor(4.2)),
                child: const CustomText(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    title: "4.2")),
          ],
        ),
      ],
    );
