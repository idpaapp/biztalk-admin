import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvRowWidget extends StatelessWidget {
  final String? type;
  final String? address;
  final bool? publishStatus;
  final String? publishStatusTitle;
  final String? statusTitle;
  final bool? status;
  final String? image;
  final bool? isTitle;
  final onEdit;
  final onConfirm;
  final bool isContact;
  final onLink;

  const TvRowWidget(
      {Key? key,
      this.onEdit,
      this.onConfirm,
      this.publishStatus,
      this.address,
      this.type,
      this.onLink,
      this.status,
      this.image,
      this.publishStatusTitle,
      this.statusTitle,
      this.isContact = false,
      this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: isTitle == true
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: isTitle == true
                  ? Container()
                  : image == ""
                      ? const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                                "assets/images/avatar_placeholder.png"),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      GlobalInfo.serverAddress + "/" + image!),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: type),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: onLink,
                child: CustomText(
                    fontSize: isTitle == true ? 16 : 14,
                    color: isTitle == true
                        ? AppColors.lighterBlack
                        : AppColors.blueIndigo,
                    fontWeight: FontWeight.w500,
                    title: address),
              ),
            ),
            isContact == true
                ? const SizedBox(
                    height: 0,
                  )
                : Expanded(
                    flex: 2,
                    child: CustomText(
                        fontSize: isTitle == true ? 16 : 14,
                        color: isTitle == true
                            ? AppColors.lighterBlack
                            : publishStatus == true
                                ? AppColors.green
                                : AppColors.dividerDark,
                        fontWeight: FontWeight.w500,
                        title: publishStatusTitle),
                  ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: 16,
                  color: isTitle == true
                      ? AppColors.lighterBlack
                      : status == true
                          ? AppColors.black
                          : AppColors.orange,
                  fontWeight: FontWeight.w500,
                  title: statusTitle),
            ),
            Expanded(
              flex: 2,
              child: isTitle == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        status != true
                            ? ButtonText(
                                padding: const EdgeInsets.only(left: 5),
                                onPressed: onConfirm,
                                width: Get.width * 0.06,
                                height: Get.height * 0.038,
                                fontSize: 13,
                                text: "تایید",
                                fontWeight: FontWeight.w500,
                                textColor: Colors.white,
                                bgColor: AppColors.green,
                                activeBorder: 1,
                                margin: EdgeInsets.only(left: Get.width * 0.01),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        ButtonText(
                          onPressed: onEdit,
                          width: Get.width * 0.05,
                          height: Get.height * 0.038,
                          fontSize: 13,
                          text: "ویرایش",
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.lighterBlack,
                          activeBorder: 1,
                          margin: EdgeInsets.only(left: Get.width * 0.02),
                        )
                      ],
                    ),
            ),
          ],
        ),
      );
}
