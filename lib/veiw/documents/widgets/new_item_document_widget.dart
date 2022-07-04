import 'package:biztalk_panel_admin/model/mentro/mentor_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class NewItemDocumentWidget extends StatelessWidget {
  final onShow;
  final String? title;
  final String? subTitle;
  final String? yers;
  final String? statusTitle;
  final String? status;


  const NewItemDocumentWidget(
      {Key? key,
      this.onShow,
      this.title,
      this.status,
      this.statusTitle,
      this.subTitle,
      this.yers})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.greyBg,
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 2,
                  height: 44,
                  color: AppColors.greyBg,
                )
              ],
            )),
            Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomText(
                                color: AppColors.titleColor,
                                title: title,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            SizedBox(width: 15,),

                            ButtonText(
                              onPressed: null,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              text: statusTitle,
                              borderRadios: 10,
                              fontWeight: FontWeight.normal,
                              height: 30,
                              fontSize: 12,
                              textColor: Colors.white,
                              bgColor: AppColors.blueSession,
                            ),
                          ],
                        ),
                        ButtonText(
                          onPressed: onShow,
                          text: "مشاهده",
                          borderRadios: 5,
                          fontWeight: FontWeight.w500,
                          height: 40,
                          width: 100,
                          fontSize: 14,
                          textColor: Colors.white,
                          bgColor: AppColors.blueSession,
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomText(
                        color: AppColors.titleColor,
                        title: subTitle,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),

                    SizedBox(height: 10,),
                    CustomText(
                        color: AppColors.titleColorTran,
                        title: yers,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ],
                )),
          ],
        ),
  );
}
