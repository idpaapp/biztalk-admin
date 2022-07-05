import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MentorChat extends StatelessWidget {
  final String? message;
  final String? image;
  final onLongTap;
  final String? date;

  MentorChat({Key? key, this.message, this.onLongTap, this.date, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: image == null
                  ? const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage("assets/images/avatar_placeholder.png"))
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          GlobalInfo.serverAddress + "/" + image!)),
            ),
            Container(
              width: Get.width * 0.12,
              decoration: const BoxDecoration(
                color: AppColors.disabledGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.only(
                  left: 5, bottom: Get.height * 0.01, top: Get.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    title: message,
                    fontSize: 13,
                    color: AppColors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        title: date,
                        fontSize: 8,
                        color: AppColors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
