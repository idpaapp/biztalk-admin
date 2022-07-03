import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleContainerWidget extends StatelessWidget {
  final String? title;
  final String? topIcon;
  final Color colors;
  final bool isBullet;
  final onTap;

  const MiddleContainerWidget(
      {Key? key,
      this.title,
      this.topIcon,
      this.colors = Colors.yellow,
      this.onTap,
      this.isBullet = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: Get.height * 0.18,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 3,
                  child: Column(              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: colors,
                        ),
                      ),
                    ),

                    Expanded(

                      child:isBullet ?  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            CustomText(
                              title: title,
                              fontSize: 15,
                              color: AppColors.lighterBlack,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 10,
                              height: 10,

                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),


                          ],
                        ),
                      ): Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            CustomText(
                              title: title,
                              fontSize: 15,
                              color: AppColors.lighterBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],),
                ),


                Expanded(
                  child: Container(

                    decoration: BoxDecoration(color: colors,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10) )),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: "مشاهده",
                        ),
                        Icon(Icons.arrow_forward,color: Colors.white,size: 22,)
                      ],
                    ),
                  ),
                )
              ]),
        ),
      );
}
