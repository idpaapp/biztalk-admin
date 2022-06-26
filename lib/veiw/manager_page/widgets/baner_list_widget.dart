import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerListWidget extends StatelessWidget {
  final String? title;
  final String? imgAddress;
  final String? link;
  final String? listTitle;
  final String? description;
  final String? number;
  final String? nameMentor;
  final bool isLink;
  final onEdit;
  final onDelete;

  const BannerListWidget(
      {Key? key,
      this.title,
      this.onDelete,
      this.onEdit,
      this.imgAddress,
      this.isLink = false,
      this.link,
      this.number,
      this.listTitle,
      this.nameMentor,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: Get.width * 0.17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(imgAddress!),fit: BoxFit.cover)),
                ),
              ),
              SizedBox(height: 8,),
              isLink
                  ? Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(
                              title: title,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                title: link,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                isLink ? SizedBox(height: 0,):  ButtonText(
                                  onPressed: onEdit,
                                  text: "ویرایش",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.white,
                                  bgColor: AppColors.blue,
                                  borderRadios: 10,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                ButtonText(
                                  onPressed: onDelete,
                                  text: "حذف",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.white,
                                  bgColor: AppColors.red,
                                  borderRadios: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(
                              title: title,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                CustomText(
                                  title: "عنوان لیست",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CustomText(
                                  title: listTitle,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                CustomText(
                                  title: "شرح لیست",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CustomText(
                                  title: description,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      title: "تعداد مشاور",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    CustomText(
                                      title: number,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    isLink ? SizedBox(height: 0,):ButtonText(
                                      onPressed: onEdit,
                                      text: "ویرایش",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.white,
                                      bgColor: AppColors.blue,
                                      borderRadios: 10,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    ButtonText(
                                      onPressed: onDelete,
                                      text: "حذف",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.white,
                                      bgColor: AppColors.red,
                                      borderRadios: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                       isLink?    Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                               isLink ? SizedBox(height: 0,): ButtonText(
                                  onPressed: onEdit,
                                  text: "ویرایش",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.white,
                                  bgColor: AppColors.blue,
                                  borderRadios: 10,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                ButtonText(
                                  onPressed: onDelete,
                                  text: "حذف",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.white,
                                  bgColor: AppColors.red,
                                  borderRadios: 10,
                                ),
                              ],
                            ),
                          ):SizedBox()
                        ],
                      ),
                    )
            ],
          ),
        ),
      );
}
