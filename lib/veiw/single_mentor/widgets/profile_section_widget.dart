import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSectionWidget extends StatelessWidget {
  final String? fullName;
  final String? jobTitle;
  final String? image;
  final bool showSwitch;
  final onEdit;
  final onSwitchBtn;
  final bool isUser;
  final bool isTransaction;
  final Widget? widget;
  final String? status;
  final String? statustitle;
  final String? userType;
  final onSwitchChange;
  final bool? switchValue;

  const ProfileSectionWidget(
      {Key? key,
      this.image,
      this.onSwitchBtn,
      this.fullName,
      this.jobTitle,
      this.onEdit,
        this.userType,
        this.showSwitch =false,
      this.widget,
      this.status,
      this.statustitle,
        this.onSwitchChange,
        this.switchValue,
      this.isUser = false,
      this.isTransaction = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: Get.height*0.25,
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greyBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                image == ""
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/avatar_placeholder.png"),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            GlobalInfo.serverAddress + "/" + image.toString()),
                      ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          color: AppColors.blackText,
                          title: fullName,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      userType == "عادی" ? SizedBox(height: 0,): ButtonText(
                          borderColor: 2,
                          onPressed: onSwitchBtn,
                          text: isUser
                              ? "سوییچ به اکانت مشاور"
                              : "سوییچ به اکانت کاربر عادی",
                          borderRadios: 5,
                          bgColor: Colors.white,
                          textColor: AppColors.tosi,
                          activeBorder: 1,
                          height: Get.height * 0.03,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      color: AppColors.blackText,
                      title: jobTitle??"",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                showSwitch? statuseSection() :SizedBox()
              ],
            ),
            endSection(),
          ]),
        ),
      );

  Widget statuseSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                  title: "وضعیت:  ",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              CustomText(
                title: statustitle??"",
                color: AppColors.green,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Row(
            children: [
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Switch(
                    value:switchValue!,
                    onChanged: onSwitchChange,
                    activeColor: AppColors.darkerGreen,
                  ),
                ),

              CustomText(
                title: switchValue! ? "غیرفعال":"فعال",
                color: AppColors.black,
                fontSize: 12,
              ),
            ],
          ),


        ],
      ),
    );
  }

  Widget endSection() => Row(
        children: [
          isTransaction == true
              ? widget!
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonText(
                      onPressed: onEdit,
                      text: "ویرایش اطلاعات",
                      bgColor: AppColors.blueIndigo,
                      height: 30,
                      fontSize: 12,
                      borderRadios: 5,
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isUser
                        ? const Icon(
                            Icons.call,
                            color: Colors.black,
                          )
                        : Row(
                            children: const [
                              Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                            ],
                          )
                  ],
                )
        ],
      );
}
