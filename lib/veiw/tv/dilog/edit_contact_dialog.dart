import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_controller.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_page.dart';
import 'package:biztalk_panel_admin/veiw/tv/widgets/grid_media_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TvController _tvController = Get.put(TvController());
final HomeController _homeController = Get.find();

Future<void> editContactDialog(BuildContext context,
    {String? title,
    String? mainId,
    String? userId,
    bool? isCreate,
    String? type,
    String? imageType,
    String? mentorImage,
    String? mentorFullName,
    String? mentorJobTitle,
    String? link}) async {
  _tvController.contactImage.value="";
  _tvController.contactTitle.value ="";
  _tvController.contactId.value="";
  _tvController.contactAddress.value.text="";
  if (isCreate == true) {
    var data = _homeController.resultAllContact.value.data!.first;
    _tvController.contactId.value = data.id!;
    _tvController.contactTitle.value = data.title!;
    _tvController.contactImage.value = data.logo!;
  } else {
    _tvController.contactTitle.value = "";
    var data = _homeController.resultAllContact.value.data!
        .where((element) => element.title == type);

    _tvController.contactId.value = data.first.id!;
    _tvController.contactTitle.value = type!;
    _tvController.contactImage.value = imageType!;
    _tvController.contactAddress.value.text = link!;
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
            size: 4,
            title: title!,
          ),
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.35,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Obx(() => GridMediaItem(
                    isContact: true,
                    addressMedia: _tvController.contactAddress.value,
                    icon: _tvController.contactImage.value,
                    typeMedia: _tvController.contactTitle.value,
                    contact: _homeController.resultAllContact.value.data!,
                    onChangeDropDown: (value) {
                      _tvController.contactId.value = "";
                      print(value);
                      _tvController.contactTitle.value = value;
                      var data = _homeController.resultAllContact.value.data!
                          .where((element) => element.title == value);

                      _tvController.contactId.value = data.first.id!;
                    },
                  ),),),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.dividerDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                  if(isCreate == true){
                    Map<String, dynamic> body = {
                      "contact": _tvController.contactId.value,
                      "userName": _tvController.contactAddress.value.text,
                    };


                    MyAlert.loding();
                    await _tvController.createContact(body, userId!);
                    if (_tvController.failureMessageCreateContact.value == "" &&
                        _tvController.resultCreateContact.value.ok == true) {
                      Get.back();
                      Get.back();
                      Get.offAndToNamed(
                        TvPage.route,
                        arguments: {
                          "image": mentorImage,
                          "fullName": mentorFullName,
                          "jobTitle": mentorJobTitle,
                          "id": userId,
                        },
                      );
                    } else {
                      Get.back();
                      MyAlert.mySnakbarRed(
                          text:
                          _tvController.failureMessageCreateContact.value);
                    }
                  }else{
                    Map<String, dynamic> body = {
                      "_id": mainId,
                      "contact": _tvController.contactId.value,
                      "userName": _tvController.contactAddress.value.text,
                    };


                    MyAlert.loding();
                    await _tvController.updateContact(body, userId!);
                    if (_tvController.failureMessageUpdateContact.value == "" &&
                        _tvController.resultUpdateContact.value.ok == true) {
                      Get.back();
                      Get.back();
                      Get.offAndToNamed(
                        TvPage.route,
                        arguments: {
                          "image": mentorImage,
                          "fullName": mentorFullName,
                          "jobTitle": mentorJobTitle,
                          "id": userId,
                        },
                      );
                    } else {
                      Get.back();
                      MyAlert.mySnakbarRed(
                          text:
                          _tvController.failureMessageUpdateContact.value);
                    }
                  }
                  },
                  text: "ذخیره",
                  height: 40,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.darkerGreen,
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  width: Get.width * 0.1,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  onPressed: ()async {
                    confirmDialog(context,title: "آیا برای حذف راه ارتباطی اطمینان دارید؟",onConfirm: ()async{ Map<String, dynamic> body = {
                      "_id": mainId,
                    };


                    MyAlert.loding();
                    await _tvController.deleteContact(body, userId!);
                    if (_tvController.failureMessageDeleteContact.value == "" &&
                        _tvController.resultDeleteContact.value.ok == true) {
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.offAndToNamed(
                        TvPage.route,
                        arguments: {
                          "image": mentorImage,
                          "fullName": mentorFullName,
                          "jobTitle": mentorJobTitle,
                          "id": userId,
                        },
                      );
                    } else {
                      Get.back();
                      MyAlert.mySnakbarRed(
                          text:
                          _tvController.failureMessageDeleteContact.value);
                    }});


                  },
                  text: "حذف ",
                  height: 40,
                  fontSize: 14,
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  width: Get.width * 0.1,
                  textColor: Colors.white,
                  bgColor: AppColors.red,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
