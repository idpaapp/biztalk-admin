import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'button_text.dart';
import 'custom_text.dart';

class MyAlert {
  static deleteBottomSheet({String? title, String? text, onCancel, onConfirm}) {
    Get.bottomSheet(
      Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: Get.height * 0.28,
          child: Padding(
            padding: EdgeInsets.fromLTRB(Get.width * 0.09, Get.height * 0.025,
                Get.width * 0.09, Get.height * 0.02),
            child: Column(
              children: [
                CustomText(
                  title: title,
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomText(
                  title: text,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,

                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: onConfirm,
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.darkerGreen),
                        child: const Center(
                          child: CustomText(
                            title: "تایید",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onCancel,
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Center(
                          child: CustomText(
                            title: "انصراف",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }

  static deleteAlertDialog({String? title, String? text, onCancel, onConfirm}) {
    Get.defaultDialog(
        title: title!,
        middleTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        middleText: text!,
        titleStyle: const TextStyle(
            color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
        actions: [
          SizedBox(
            width: Get.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonText(
                    onPressed: onCancel,
                    text: "متوجه شدم",
                    width: 120,
                    height: 40,
                    bgColor: Colors.white,
                    textColor: Colors.grey,
                    activeBorder: 1,
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  static loding() {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 280,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  const [
                SizedBox(
                  height: 14,
                ),
                CircularProgressIndicator(color: Colors.white,),
                SizedBox(
                  height: 50,
                ),
                CustomText(
                  title: 'لطفا منتظر بمانید...',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Get.defaultDialog(
    //     title: "",
    //     middleText: 'لطفا منتظر بمانید',
    //     middleTextStyle: TextStyle(color: AppColors.Primary, fontSize: 15),
    //     actions: [
    //       Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //        SizedBox(
    //         height: 24,
    //       )
    //     ],barrierDismissible: false);
  }

  static mySnakbar({String? text,String title ="عملیات موفق"}) {
    Get.snackbar('', '',


        titleText:  Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        icon: const Directionality(
          textDirection: TextDirection.rtl,
          child: Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 35,
          ),
        ),
        messageText: Text(
          text!,
          style: const TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppColors.darkerGreen,
        duration: const Duration(seconds: 2));
  }

  static notification({String? text, String? title}) {
    Get.snackbar('', '',
        titleText: Text(
          title!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        icon: const Directionality(
          textDirection: TextDirection.rtl,
          child: Icon(
            Icons.notifications_active_outlined,
            color: Colors.grey,
            size: 35,
          ),
        ),
        messageText: Text(
          text!,
          style: const TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 4));
  }

  static mySnakbarRed({String? text,int? second }) {
    Get.snackbar('', '',
        icon: const Directionality(
          textDirection: TextDirection.rtl,
          child: Icon(
            Icons.error_outlined,
            color: Colors.white,
            size: 36,
          ),
        ),
        titleText: const Text(
          "توجه",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        messageText: Text(
          text!,
          style: const TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.red,
        duration:  Duration(seconds: second ?? 4));
  }
  static guestBottomSheet({onCancel, onConfirm}) {
    Get.bottomSheet(
      Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: Get.height * 0.28,
          child: Padding(
            padding: EdgeInsets.fromLTRB(Get.width * 0.09, Get.height * 0.025,
                Get.width * 0.09, Get.height * 0.02),
            child: Column(
              children: [
                const CustomText(
                  title: "توجه",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const CustomText(
                  title: "برای انجام عملیات باید ابتدا وارد حساب کاربری خود شوید",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: onConfirm,
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.darkerGreen),
                        child: const Center(
                          child: CustomText(
                            title: "تایید",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onCancel,
                      child: const Center(
                        child: CustomText(
                          title: "عدم تایید",
                          fontSize: 14,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }

}
