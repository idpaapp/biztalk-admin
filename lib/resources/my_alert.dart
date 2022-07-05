import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'button_text.dart';
import 'custom_text.dart';

class MyAlert {

  static deleteAlertDialog(BuildContext context,{ String? text, onConfirm}) {

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
          title: const TitleWidget(
            title: "توجه",
            size:5 ,
          ),
          content: SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.2,
              child: Column(children: [
                CustomText(title:text ,fontSize: 14,color: AppColors.blackText,fontWeight: FontWeight.w500,)
              ],)),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: Get.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   ButtonText(
                    onPressed: onConfirm,
                    text: "حذف",
                    borderRadios: 10,
                    fontWeight: FontWeight.w500,
                    height: 40,
                    width: Get.width * 0.1,
                    fontSize: 14,
                    textColor: Colors.white,
                    bgColor: AppColors.red,
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
                ],
              ),
            )
          ],
        );
      },
    );



    // Get.defaultDialog(
    //     title: title!,
    //     middleTextStyle: const TextStyle(
    //       color: Colors.grey,
    //       fontSize: 14,
    //     ),
    //     middleText: text!,
    //     titleStyle: const TextStyle(
    //         color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
    //     actions: [
    //       SizedBox(
    //         width: Get.width * 0.4,
    //         height: Get.height *0.2,
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               ButtonText(
    //                 onPressed: onCancel,
    //                 text: "انصراف",
    //                 width: 120,
    //                 height: 40,
    //                 bgColor: Colors.white,
    //                 textColor: Colors.grey,
    //                 activeBorder: 1,
    //               ),
    //               ButtonText(
    //                 onPressed: onConfirm,
    //                 text: "حذف",
    //                 width: 120,
    //                 height: 40,
    //                 bgColor: Colors.white,
    //                 textColor: Colors.grey,
    //                 activeBorder: 1,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ]);
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
