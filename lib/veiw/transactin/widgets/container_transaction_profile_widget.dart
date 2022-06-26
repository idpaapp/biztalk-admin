import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerTransactionProfileWidget extends StatelessWidget {
  final String? amount;
  final String? title;
  final Color? bgColor;

  const ContainerTransactionProfileWidget(
      {Key? key, this.bgColor, this.title, this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(

    // constraints: BoxConstraints(
    //   minHeight: Get.height * 0.09,
    //   maxHeight: Get.height * 0.09,
    //   minWidth: Get.width * 0.16,
    //   maxWidth: Get.width * 0.15,
    // ),
        height: Get.height * 0.1,
        width: Get.width * 0.15,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: bgColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomText(
                    title: amount,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: Get.width*0.005,),
                  const CustomText(
                    title: "تومان",
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: Get.height *0.005,),
              CustomText(
                title: title,
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400
                ,
              ),
            ]),
      );
}
