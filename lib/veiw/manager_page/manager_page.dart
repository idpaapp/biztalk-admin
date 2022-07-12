import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/create_edit_banner.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page_controller.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/baner_list_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/insert_banner_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/istatic_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerPage extends StatelessWidget {
  ManagerPage({Key? key}) : super(key: key) {
    _managerPageController.getBanner();
  }

  final ManagerPageController _managerPageController =
      Get.put(ManagerPageController());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.disabledGrey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopSectionPanelAdmin(
                title: "  مدیریت صفحه اصلی",
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              Obx(
                () {
                  if (_managerPageController.failureMessageGetBanner.value !=
                      "") {
                    return Center(
                      child: CustomText(
                          title: _managerPageController
                              .failureMessageGetBanner.value),
                    );
                  } else if (_managerPageController.isLoadingGetBanner.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        carouselBanner(),
                        const SizedBox(
                          height: 12,
                        ),
                        IstaticBannerWidget(),
                        const SizedBox(
                          height: 12,
                        ),
                        listNumber1(),
                        const SizedBox(
                          height: 12,
                        ),
                        listNumber2(),
                        const SizedBox(
                          height: 12,
                        ),
                        listNumber3(),
                        const SizedBox(
                          height: 26,
                        ),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      );

  Widget carouselBanner() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              fontSize: 18,
              title: "بنر های کروسل",
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            AspectRatio(
              aspectRatio: 1 / 0.16,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: _managerPageController
                        .resultGetBanner.value.data!.carousel!.length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      _managerPageController
                          .resultGetBanner.value.data!.carousel!.length) {
                    return InsertBannerWidget(
                      onTap: () {
                        createEditBanner(
                          context,
                          bannerGroup: "carousel",
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                    );
                  } else {
                    var carousel = _managerPageController
                        .resultGetBanner.value.data!.carousel![index];

                    return BannerListWidget(
                      onEdit: () {
                        createEditBanner(
                          context,
                          bannerGroup: "carousel",
                          edit: 'edit',
                          banner: carousel,
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                      title: carousel.bannerType == 'link'
                          ? "بازکردن لینک"
                          : "بازکردن لیست",
                      description: carousel.bannerDescription,
                      listTitle: carousel.bannerTitle,
                      nameMentor: carousel.mentors!.length.toString(),
                      number: carousel.mentors!.length.toString(),
                      isLink: carousel.bannerType == 'link' ? true : false,
                      onDelete: () {
                        confirmDialog(
                          context,
                          title: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                            MyAlert.loding();
                            await _managerPageController
                                .deletBanner(carousel.id!);
                            Get.back();
                            if (_managerPageController
                                    .failureMessageDeleteBanner.value !=
                                "") {
                              MyAlert.mySnakbarRed(
                                  text: _managerPageController
                                      .failureMessageDeleteBanner.value);
                            } else {
                              _managerPageController
                                  .resultGetBanner.value.data!.carousel!
                                  .removeAt(index);
                              _managerPageController.resultGetBanner.refresh();
                              Get.back();
                            }
                          },
                        );
                      },
                      link: carousel.link,
                      imgAddress:
                          GlobalInfo.serverAddress + "/" + carousel.logo!,
                    );
                  }
                },
              ),
            )
          ],
        ),
      );

  Widget listNumber1() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              fontSize: 18,
              title: "لیست شماره 1",
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            AspectRatio(
              aspectRatio: 1 / 0.16,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: _managerPageController
                        .resultGetBanner.value.data!.list1!.length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      _managerPageController
                          .resultGetBanner.value.data!.list1!.length) {
                    return InsertBannerWidget(
                      onTap: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list1",
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                    );
                  } else {
                    var carousel = _managerPageController
                        .resultGetBanner.value.data!.list1![index];

                    return BannerListWidget(
                      onEdit: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list1",
                          edit: 'edit',
                          banner: carousel,
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                      title: carousel.bannerType == 'link'
                          ? "بازکردن لینک"
                          : "بازکردن لیست",
                      description: carousel.bannerDescription,
                      listTitle: carousel.bannerTitle,
                      nameMentor: carousel.mentors!.length.toString(),
                      number: carousel.mentors!.length.toString(),
                      isLink: carousel.bannerType == 'link' ? true : false,
                      onDelete: () {
                        confirmDialog(
                          context,
                          title: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                            MyAlert.loding();
                            await _managerPageController
                                .deletBanner(carousel.id!);
                            Get.back();
                            if (_managerPageController
                                    .failureMessageDeleteBanner.value !=
                                "") {
                              MyAlert.mySnakbarRed(
                                  text: _managerPageController
                                      .failureMessageDeleteBanner.value);
                            } else {
                              _managerPageController
                                  .resultGetBanner.value.data!.list1!
                                  .removeAt(index);
                              _managerPageController.resultGetBanner.refresh();
                              Get.back();
                            }
                          },
                        );
                      },
                      link: carousel.link,
                      imgAddress:
                          GlobalInfo.serverAddress + "/" + carousel.logo!,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget listNumber2() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              fontSize: 18,
              title: "لیست شماره 2",
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            AspectRatio(
              aspectRatio: 1 / 0.16,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: _managerPageController
                        .resultGetBanner.value.data!.list2!.length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      _managerPageController
                          .resultGetBanner.value.data!.list2!.length) {
                    return InsertBannerWidget(
                      onTap: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list2",
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                    );
                  } else {
                    var carousel = _managerPageController
                        .resultGetBanner.value.data!.list2![index];

                    return BannerListWidget(
                      onEdit: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list2",
                          edit: 'edit',
                          banner: carousel,
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                      title: carousel.bannerType == 'link'
                          ? "بازکردن لینک"
                          : "بازکردن لیست",
                      description: carousel.bannerDescription,
                      listTitle: carousel.bannerTitle,
                      nameMentor: carousel.mentors!.length.toString(),
                      number: carousel.mentors!.length.toString(),
                      isLink: carousel.bannerType == 'link' ? true : false,
                      onDelete: () {
                        confirmDialog(
                          context,
                          title: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                            MyAlert.loding();
                            await _managerPageController
                                .deletBanner(carousel.id!);
                            Get.back();
                            if (_managerPageController
                                    .failureMessageDeleteBanner.value !=
                                "") {
                              MyAlert.mySnakbarRed(
                                  text: _managerPageController
                                      .failureMessageDeleteBanner.value);
                            } else {
                              _managerPageController
                                  .resultGetBanner.value.data!.list2!
                                  .removeAt(index);
                              _managerPageController.resultGetBanner.refresh();
                              Get.back();
                            }
                          },
                        );
                      },
                      link: carousel.link,
                      imgAddress:
                          GlobalInfo.serverAddress + "/" + carousel.logo!,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget listNumber3() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              fontSize: 18,
              title: "لیست شماره 3",
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            AspectRatio(
              aspectRatio: 1 / 0.16,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: _managerPageController
                        .resultGetBanner.value.data!.list3!.length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      _managerPageController
                          .resultGetBanner.value.data!.list3!.length) {
                    return InsertBannerWidget(
                      onTap: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list3",
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                    );
                  } else {
                    var carousel = _managerPageController
                        .resultGetBanner.value.data!.list3![index];

                    return BannerListWidget(
                      onEdit: () {
                        createEditBanner(
                          context,
                          bannerGroup: "list3",
                          edit: 'edit',
                          banner: carousel,
                          onChangeDropDown: (val) {
                            _managerPageController.selectedDropDownValue.value =
                                val;
                            if (val == "بازکردن لیست") {
                              _managerPageController.isLink.value = false;
                            } else {
                              _managerPageController.isLink.value = true;
                            }
                          },
                        );
                      },
                      title: carousel.bannerType == 'link'
                          ? "بازکردن لینک"
                          : "بازکردن لیست",
                      description: carousel.bannerDescription,
                      listTitle: carousel.bannerTitle,
                      nameMentor: carousel.mentors!.length.toString(),
                      number: carousel.mentors!.length.toString(),
                      isLink: carousel.bannerType == 'link' ? true : false,
                      onDelete: () {
                        confirmDialog(
                          context,
                          title: "آیا برای حذف اطمینان دارید؟",
                          onConfirm: () async {
                            MyAlert.loding();
                            await _managerPageController
                                .deletBanner(carousel.id!);
                            Get.back();
                            if (_managerPageController
                                    .failureMessageDeleteBanner.value !=
                                "") {
                              MyAlert.mySnakbarRed(
                                  text: _managerPageController
                                      .failureMessageDeleteBanner.value);
                            } else {
                              _managerPageController
                                  .resultGetBanner.value.data!.list3!
                                  .removeAt(index);
                              _managerPageController.resultGetBanner.refresh();
                              Get.back();
                            }
                          },
                        );
                      },
                      link: carousel.link,
                      imgAddress:
                          GlobalInfo.serverAddress + "/" + carousel.logo!,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
}
