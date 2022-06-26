import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertBannerWidget extends StatelessWidget {
  final onTap;
  final String title;

  const InsertBannerWidget({Key? key, this.onTap, this.title = "افزودن بنر"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.17,

        decoration: DottedDecoration(
          color: AppColors.darkGrey,
          shape: Shape.box,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.attachment,
            color: Colors.black,
            size: 30,
          ),
          CustomText(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            title: title,
          )
        ]),
      ),
    );
  }
}
