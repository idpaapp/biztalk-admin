import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerDocumentWidget extends StatelessWidget {
  final String? number;
  final String? title;
  final Color? bgColor;
  final Color borderColor;

  const ContainerDocumentWidget(
      {Key? key, this.bgColor, this.title, this.number,this.borderColor=Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(


    height: Get.height * 0.1,
    width: Get.width * 0.15,
    padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2), color: bgColor,border: Border.all(color: borderColor)),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: number,
            color: borderColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: Get.height *0.005,),
          CustomText(
            title: title,
            color: borderColor,
            fontSize: 14,
            fontWeight: FontWeight.w400
            ,
          ),
        ]),
  );
}
