import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'custom_text.dart';

class CustomBottomSheet {
  static myBottomSheet(
      {double? height, String? title, required Widget widget}) {
    return Get.bottomSheet(
      SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                height: 3,
                margin: const EdgeInsets.symmetric(vertical: 0),
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.greyBorder,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(height: 20,),


              title == null
                  ? const SizedBox(height: 0,)
                  : CustomText(
                      title: title,
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
              const SizedBox(height: 10,),

              title == null ? const SizedBox(height: 0,): Container(
                height: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColors.greyBorder,
                    borderRadius: BorderRadius.circular(10)),
              ),
              widget
            ],
          ),
        ),
      ),
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),)) ,

      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  static widgetBottomSheet(
      {double? height, required Widget widget, Widget? titleWidget}) {
    return Get.bottomSheet(
      SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),

              Container(
                height: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: Get.width * 0.1,
                decoration: BoxDecoration(
                    color: AppColors.greyBorder,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(height: 20,),


              titleWidget ?? const SizedBox(height: 0,),
             // titleWidget == null ? SizedBox(height: 0,): Container(
             //    height: 2,
             //    margin: EdgeInsets.symmetric(vertical: 8),
             //    width: Get.width,
             //    decoration: BoxDecoration(
             //        color: AppColors.lightGrey,
             //        borderRadius: BorderRadius.circular(10)),
             //  ),
              widget
            ],
          ),
        ),
      ),
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),)) ,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
