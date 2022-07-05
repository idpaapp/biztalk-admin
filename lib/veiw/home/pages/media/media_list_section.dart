import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/media/media_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaListSection extends StatelessWidget {
  MediaListSection({Key? key}) : super(key: key) {
    _homeController.selectedPage.value = 1;
    _homeController.tvList(1);
  }

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            const MediaListWidget(
              isTitle: true,
              oneColumn: "نام و نام خانوادگی",
              twoColumn: "نام کاربری",
              threeColumn: "نوع کانال",
              fourColumn: "آدرس",
            ),
            Obx(() {
              if (_homeController.failureMessageListTv.value != "") {
                return SizedBox(
                  height: 100,
                  width: Get.width,
                  child: Center(
                      child: CustomText(
                    title: _homeController.failureMessageListTv.value,
                  )),
                );
              } else if (_homeController.isLoadingListTv.value) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _homeController
                            .resultListTv.value.data!.tvs!.length,
                        itemBuilder: (context, index) {
                          var tv = _homeController
                              .resultListTv.value.data!.tvs![index];
                          return MediaListWidget(
                            isTitle: false,
                            onLink: () async {
                              await launch(tv.tvLink! + tv.userName!);
                            },
                            oneColumn: tv.fullName,
                            twoColumn: tv.userName,
                            threeColumn: tv.tvTitle,
                            fourColumn: tv.tvLink! + tv.tvUserName!,
                            onConfirm: () {
                              confirmDialog(context,
                                  title: "آیا برای تایید رسانه اطمینان دارید؟",
                                  onConfirm: () async {
                                MyAlert.loding();
                                await _homeController.confirm(
                                    tv.userId!, "tv", tv.tvId!);
                                if (_homeController
                                        .failureMessageConfirm.value !=
                                    "") {
                                  Get.back();
                                  Get.back();
                                  MyAlert.mySnakbarRed(
                                      text: _homeController
                                          .failureMessageConfirm.value);
                                  return;
                                }else if(_homeController.resultConfirm.value.ok == true){
                                  Get.back();
                                  Get.back();
                                  _homeController.tvList(1);
                                  _homeController.selectedPage.value=1;
                                  MyAlert.mySnakbar(title: "عملیات موفق",text: "عملیات با موفقیت انجام شد");
                                }else{}
                              });
                            },
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    pageSection(),
                  ],
                );
              }
            }),
          ],
        ),
      );

  Widget pageSection() {
    var data = _homeController.resultListTv.value.data!;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.totalPages! <= 5
              ? const SizedBox(
                  height: 0,
                )
              : const InkWell(
                  child: Icon(Icons.double_arrow, color: AppColors.dividerDark),
                ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 30,
            width: 1,
            color: AppColors.dividerDark,
          ),
          const SizedBox(
            width: 15,
          ),
          ListView.builder(
              itemCount: data.totalPages,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      _homeController.selectedPage.value = index + 1;
                      _homeController.tvList(index + 1);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index + 1 == _homeController.selectedPage.value
                              ? AppColors.blueIndigo
                              : Colors.white),
                      child: Center(
                        child: CustomText(
                          title: "${index + 1}",
                          color: index + 1 == _homeController.selectedPage.value
                              ? Colors.white
                              : AppColors.dividerDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 30,
            width: 1,
            color: AppColors.dividerDark,
          ),
          const SizedBox(
            width: 15,
          ),
          data.totalPages! <= 5
              ? const SizedBox(
                  height: 0,
                )
              : const InkWell(
                  child: Icon(
                    Icons.double_arrow,
                    color: AppColors.dividerDark,
                  ),
                ),
        ],
      ),
    );
  }
}
