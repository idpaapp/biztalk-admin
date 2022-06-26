import 'package:biztalk_panel_admin/model/home/all_banner_model.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/create_edit_banner.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page_controller.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/baner_list_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/insert_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IstaticBannerWidget extends StatelessWidget {
  IstaticBannerWidget({Key? key}) : super(key: key);
  final ManagerPageController _managerPageController = Get.find();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              fontSize: 18,
              title: "بنر های میانی",
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            AspectRatio(
              aspectRatio: 1 / 0.16,
              child: Row(
                children: [
                  middle1(context),
                  SizedBox(
                    width: 12,
                  ),
                  middle2(context),
                  SizedBox(
                    width: 12,
                  ),
                  middle3(context),
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                ],
              ),
            )
          ],
        ),
      );

  Widget middle1(BuildContext context) {
    return _managerPageController.resultGetBanner.value.data!.middle1 == null
        ? Expanded(child: InsertBannerWidget(
            onTap: () {
              createEditBanner(context, bannerGroup: "middle1",
                  onChangeDropDown: (val) {
                _managerPageController.selectedDropDownValue.value = val;
                if (val == "بازکردن لیست") {
                  _managerPageController.isLink.value = false;
                } else {
                  _managerPageController.isLink.value = true;
                }
              });
            },
          ))
        : Expanded(
            child: BannerListWidget(
            onDelete: () {
              confirmDialog(context, title: "آیا برای حذف اطمینان دارید؟",
                  onConfirm: () async {
                MyAlert.loding();
                await _managerPageController.deletBanner(_managerPageController
                    .resultGetBanner.value.data!.middle1!.id!);
                Get.back();
                if (_managerPageController.failureMessageDeleteBanner.value !=
                    "") {
                  MyAlert.mySnakbarRed(
                      text: _managerPageController
                          .failureMessageDeleteBanner.value);
                } else {
                  _managerPageController.getBanner();
                  Get.back();
                }
              });
            },
            onEdit: () {
              createEditBanner(context,
                  bannerGroup: "middle1",
                  edit: 'edit',
                  banner: _managerPageController.resultGetBanner.value.data!
                      .middle1!, onChangeDropDown: (val) {
                _managerPageController.selectedDropDownValue.value = val;
                if (val == "بازکردن لیست") {
                  _managerPageController.isLink.value = false;
                } else {
                  _managerPageController.isLink.value = true;
                }
              });
            },

              title:  _managerPageController
                  .resultGetBanner.value.data!.middle1!.bannerTitle ??
                  "",

              description: _managerPageController
                  .resultGetBanner.value.data!.middle1!.bannerDescription??"",
              listTitle:  _managerPageController
                  .resultGetBanner.value.data!.middle1!.bannerTitle??"",
              nameMentor: _managerPageController
                  .resultGetBanner.value.data!.middle1!.mentors!.length.toString(),
              number:  _managerPageController
                  .resultGetBanner.value.data!.middle1!.mentors!.length.toString(),
              isLink:  _managerPageController
                  .resultGetBanner.value.data!.middle1!.bannerType == 'link' ? true : false,

              link: _managerPageController
                  .resultGetBanner.value.data!.middle1!.link ??
                  "",
              imgAddress: GlobalInfo.serverAddress +
                  "/" +
                  _managerPageController
                      .resultGetBanner.value.data!.middle1!.logo!,

          ));
  }

  Widget middle2(BuildContext context) {
    return _managerPageController.resultGetBanner.value.data!.middle2 == null
        ? Expanded(child: InsertBannerWidget(
            onTap: () {
              createEditBanner(context, bannerGroup: "middle2",
                  onChangeDropDown: (val) {
                _managerPageController.selectedDropDownValue.value = val;
                if (val == "بازکردن لیست") {
                  _managerPageController.isLink.value = false;
                } else {
                  _managerPageController.isLink.value = true;
                }
              });
            },
          ))
        : Expanded(
            child: BannerListWidget(
            onDelete: () {
              confirmDialog(context, title: "آیا برای حذف اطمینان دارید؟",
                  onConfirm: () async {
                MyAlert.loding();
                await _managerPageController.deletBanner(_managerPageController
                    .resultGetBanner.value.data!.middle2!.id!);
                Get.back();
                if (_managerPageController.failureMessageDeleteBanner.value !=
                    "") {
                  MyAlert.mySnakbarRed(
                      text: _managerPageController
                          .failureMessageDeleteBanner.value);
                } else {
                  _managerPageController.getBanner();
                  Get.back();
                }
              });
            },
            onEdit: () {
              createEditBanner(context,
                  bannerGroup: "middle2",
                  edit: 'edit',
                  banner: _managerPageController.resultGetBanner.value.data!
                      .middle2!, onChangeDropDown: (val) {
                _managerPageController.selectedDropDownValue.value = val;
                if (val == "بازکردن لیست") {
                  _managerPageController.isLink.value = false;
                } else {
                  _managerPageController.isLink.value = true;
                }
              });
            },

              title:  _managerPageController
                  .resultGetBanner.value.data!.middle2!.bannerTitle ??
                  "",

              description: _managerPageController
                  .resultGetBanner.value.data!.middle2!.bannerDescription??"",
              listTitle:  _managerPageController
                  .resultGetBanner.value.data!.middle2!.bannerTitle??"",
              nameMentor: _managerPageController
                  .resultGetBanner.value.data!.middle2!.mentors!.length.toString(),
              number:  _managerPageController
                  .resultGetBanner.value.data!.middle2!.mentors!.length.toString(),
              isLink:  _managerPageController
                  .resultGetBanner.value.data!.middle2!.bannerType == 'link' ? true : false,

              link: _managerPageController
                  .resultGetBanner.value.data!.middle2!.link ??
                  "",
              imgAddress: GlobalInfo.serverAddress +
                  "/" +
                  _managerPageController
                      .resultGetBanner.value.data!.middle2!.logo!,



          ));
  }

  Widget middle3(BuildContext context) {
    return _managerPageController.resultGetBanner.value.data!.middle3 == null
        ? Expanded(child: InsertBannerWidget(
            onTap: () {
              createEditBanner(context, bannerGroup: "middle3",
                  onChangeDropDown: (val) {
                _managerPageController.selectedDropDownValue.value = val;
                if (val == "بازکردن لیست") {
                  _managerPageController.isLink.value = false;
                } else {
                  _managerPageController.isLink.value = true;
                }
              });
            },
          ))
        : Expanded(
            child: BannerListWidget(
              onDelete: () {
                confirmDialog(context, title: "آیا برای حذف اطمینان دارید؟",
                    onConfirm: () async {
                  MyAlert.loding();
                  await _managerPageController.deletBanner(
                      _managerPageController
                          .resultGetBanner.value.data!.middle3!.id!);
                  Get.back();
                  if (_managerPageController.failureMessageDeleteBanner.value !=
                      "") {
                    MyAlert.mySnakbarRed(
                        text: _managerPageController
                            .failureMessageDeleteBanner.value);
                  } else {
                    _managerPageController.getBanner();
                    Get.back();
                  }
                });
              },
              onEdit: () {
                createEditBanner(context,
                    bannerGroup: "middle3",
                    edit: 'edit',
                    banner: _managerPageController.resultGetBanner.value.data!
                        .middle3!, onChangeDropDown: (val) {
                  _managerPageController.selectedDropDownValue.value = val;
                  if (val == "بازکردن لیست") {
                    _managerPageController.isLink.value = false;
                  } else {
                    _managerPageController.isLink.value = true;
                  }
                });
              },
              title:  _managerPageController
                  .resultGetBanner.value.data!.middle3!.bannerTitle ??
                  "",

              description: _managerPageController
                  .resultGetBanner.value.data!.middle3!.bannerDescription??"",
              listTitle:  _managerPageController
                  .resultGetBanner.value.data!.middle3!.bannerTitle??"",
              nameMentor: _managerPageController
                  .resultGetBanner.value.data!.middle3!.mentors!.length.toString(),
              number:  _managerPageController
                  .resultGetBanner.value.data!.middle3!.mentors!.length.toString(),
              isLink:  _managerPageController
                  .resultGetBanner.value.data!.middle3!.bannerType == 'link' ? true : false,

              link: _managerPageController
                      .resultGetBanner.value.data!.middle3!.link ??
                  "",
              imgAddress: GlobalInfo.serverAddress +
                  "/" +
                  _managerPageController
                      .resultGetBanner.value.data!.middle3!.logo!,
            ),
          );
  }
}
