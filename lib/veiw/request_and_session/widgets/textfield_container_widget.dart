import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextfieldContainerWidget extends StatelessWidget {
  final TextEditingController? textEditingController;


  const TextfieldContainerWidget(
      {Key? key, this.textEditingController, })
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    width: Get.width*0.1,
        decoration: BoxDecoration(
          color: AppColors.veryLightGrey,
          border: Border.all(color: AppColors.disabledGrey),
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextField(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "تاریخ",
              counterText: "",
              contentPadding: EdgeInsets.only(right: 5,bottom: 10)),
        ),
      );
}
