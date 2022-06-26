import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleContainerWidget extends StatelessWidget {
  final String? title;
  final String? topIcon;
  final String? detail;
  final String? bottomIcon;
  final bool? isBottomIcon;
  final bool? isDetail;
  final bool isBullet;
  final onTap;

  const MiddleContainerWidget(
      {Key? key,
      this.title,
      this.topIcon,
      this.bottomIcon,
      this.detail,
      this.isBottomIcon,
      this.isDetail,
        this.onTap,
      this.isBullet = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: Get.height * 0.21,
    width: Get.width * 0.16,
    padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.01, vertical: Get.height * 0.02),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    child: InkWell(
      onTap: onTap,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            
            Expanded(
              child: CustomText(
                
                title: title,
                fontSize: 16,
                color: AppColors.lighterBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            isBullet == false
            
                ? Expanded(
                  child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        ),
                        SizedBox(
                          width: Get.width*0.005,
                        ),
                        CustomText(
                          title: detail,
                          color: AppColors.greyMiddle,
                          fontSize: 12,
                        ),
                      ],
                    ),
                )
            
                : const SizedBox(width: 0),
            const SizedBox(
              height: 10,
            ),
            
            Expanded(
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isBottomIcon == true
                        ? const Center(child: Icon(Icons.notification_important))
                        : Container(),
                  )
                ],
              ),
            )
          ]),
    ),
  );
}
