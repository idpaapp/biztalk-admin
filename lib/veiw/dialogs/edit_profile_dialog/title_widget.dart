import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TitleWidget extends StatelessWidget {
  final String title;
  final onClose;
  final int size;
  const TitleWidget({Key? key,required this.title,this.onClose,this.size=1}) : super(key: key);

  @override
  Widget build(BuildContext context)=>SizedBox(
    height: Get.height * 0.07,
    width:size == 4 ? Get.width * 0.3: size==2? Get.width * 0.4 :size == 1 ? Get.width * 0.5:size == 3 ? Get.width*0.6:Get.width * 0.7,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.009, vertical: Get.height * 0.008),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 CustomText(
                  title: title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lighterBlack,
                ),
                InkWell(
                  onTap: onClose,
                  child: const Icon(Icons.close,
                      color: AppColors.lighterBlack, size: 30),
                )
              ]),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.dividerDark,
        )
      ],
    ),
  );
}
