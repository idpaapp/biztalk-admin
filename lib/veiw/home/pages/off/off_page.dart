import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/create_off/create_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/create_off/show_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/off/off_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OffPage extends StatelessWidget {
  OffPage({Key? key}) : super(key: key) {
    _offController.allOffCode();
  }

  final OffController _offController = Get.put(OffController());

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 60),

          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  const OffWidget(
                    isTitle: true,
                    oneColumn: "عنوان",
                    twoColumn: "کد تخفیف",
                    threeColumn: " تاریخ شروع",
                    fourColumn: "تاریخ پایان",
                    fiveColumn: "دسته بندی / شخص",
                  ),
                  Obx(() {
                    if (_offController.failureMessageAllOffCode.value != "") {
                      return SizedBox(
                        height: 100,
                        width: Get.width,
                        child: Center(
                            child: CustomText(
                          title: _offController.failureMessageAllOffCode.value,
                        )),
                      );
                    } else if (_offController.isLoadingAllOffCode.value) {
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
                              itemCount: _offController
                                  .resultAllOffCode.value.data!.length,
                              itemBuilder: (context, index) {
                                var check = _offController
                                    .resultAllOffCode.value.data![index];
                                return OffWidget(
                                  isTitle: false,
                                  onTap: (){
                                    showOffer(context,singleOff: check);

                                  },

                                  onCopy: (){
                                    Clipboard.setData(ClipboardData(text: check.code));

                                  },
                                  oneColumn: check.title,
                                  twoColumn: check.code ?? "",
                                  threeColumn: check.startDate ?? "نا مشخص",
                                  fiveColumn:check.useFor == null? check.useForTypeTitle: check.useFor!.title ?? "",
                                  fourColumn: check.expireDate ?? "نا مشخص",
                                  onDelete: () {
                                    confirmDialog(context,
                                        title: "آیا برای حذف اطمینان دارید؟",
                                        onConfirm: () async {
                                      MyAlert.loding();
                                      await _offController.deleteOff(check.id!);
                                      Get.back();
                                      if (_offController
                                              .failureMessageDeleteOff.value !=
                                          "") {
                                        MyAlert.mySnakbarRed(
                                            text: _offController
                                                .failureMessageDeleteOff.value);
                                      } else {
                                        Get.back();
                                        await _offController.allOffCode();
                                        MyAlert.mySnakbar(
                                            title: "عملیات موفق",
                                            text: "کد تخفیف با موفقیت حذف شد");
                                      }
                                    });
                                  },
                                );
                              }),
                          SizedBox(
                            height: Get.height * 0.07,
                          ),

                          // pageSection(),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
        ButtonText(
          onPressed: () async {
            MyAlert.loding();
            await _offController.fetchCategory();
            Get.back();
            if (_offController.failureMessageCategory.value != "") {
              MyAlert.mySnakbarRed(
                  text: _offController.failureMessageCategory.value);
            } else {
              _offController.selectedCategoryId.value =
              _offController.resultCategory.value.data!.first.id!;
              createOffer(context, title: "تعریف کد تخفیف");
            }
          },
          text: "افزودن کد تخفیف",
          height: 45,

          width: Get.width * 0.1,
          fontSize: 14,
          textColor: Colors.white,
          bgColor: AppColors.darkerGreen,
          fontWeight: FontWeight.w500,
          borderRadios: 5,
        )

      ],
    ),
  );
}
