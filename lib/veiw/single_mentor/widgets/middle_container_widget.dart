import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleContainerWidget extends StatelessWidget {
  final String? title;
  final Color colors;
  final bool isBullet;
  final IconData? iconData;
  final onTap;

  const MiddleContainerWidget(
      {Key? key,
      this.title,
      this.iconData,
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
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            iconData,
                            color: colors,
                          ),
                        ),
                      ),
                      Expanded(
                        child: isBullet
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  children: [

                                    Expanded(
                                      flex: 10,
                                      child: CustomText(

                                        textOverflow: TextOverflow.ellipsis,

                                        title: title,
                                        fontSize: 14,
                                        color: AppColors.lighterBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),

                                    Expanded(

                                      child: Center(
                                        child: Container(

                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  children: [
                                    CustomText(
                                      textOverflow: TextOverflow.ellipsis,
                                      title: title,
                                      fontSize: 14,
                                      color: AppColors.lighterBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: "مشاهده",
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 22,
                        )
                      ],
                    ),
                  ),
                )
              ]),
        ),
      );
}
