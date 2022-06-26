import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';

class ItemJobWidget extends StatelessWidget {
  final onTap;
  final String? image;
  final String? companyTitle;
  final String? job;
  final String? date;
  final String? status;

  const ItemJobWidget(
      {Key? key,
      this.onTap,
      this.image,
      this.status,
      this.date,
      this.companyTitle,
      this.job})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      image == null
                          ? Expanded(
                              child: Center(
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),

                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/avatarwhite.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.darkerGreen,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            GlobalInfo.serverAddress +
                                                "/" +
                                                image!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: companyTitle,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lighterBlack,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              title: job,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.darkGrey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              fontSize: 12,
                              title: date,
                              color: AppColors.darkGrey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                ButtonText(
                                  onPressed: null,
                                  borderRadios: 5,
                                  text: status,
                                  fontSize: 10,
                                  textColor: _handelTextColor(status!),
                                  bgColor: _handelBackColor(status!),
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ButtonText(
                text: "ویرایش",
                bgColor: AppColors.greenWhite,
                height: 30,
                width: 75,
                fontSize: 10,
                textColor: AppColors.darkerGreen,
                onPressed: () {},
              )
            ],
          ),
        ),
      );

  Color _handelTextColor(String data) {
    if (data == "DOC_NOT_SEND") {
      return AppColors.darkGrey;
    } else if (data == "DOC_CONFIRM") {
      return Colors.white;
    } else if (data == "DOC_CHECKING") {
      return AppColors.blueBg;
    } else {
      return AppColors.redText;
    }
  }

  Color _handelBackColor(String data) {
    if (data == "DOC_NOT_SEND") {
      return AppColors.disabledGrey;
    } else if (data == "DOC_CONFIRM") {
      return AppColors.darkerGreen;
    } else if (data == "DOC_CHECKING") {
      return AppColors.vBlue;
    } else {
      return AppColors.redBg;
    }
  }
}
