import 'dart:js';

import 'package:biztalk_panel_admin/model/home/all_banner_model.dart';
import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/text_fiels_custom_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/widgets/left_column.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/widgets/mentor_list_widgets.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/widgets/right_column.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/select_user_dialog.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController _fullName = TextEditingController();
final TextEditingController _titleList = TextEditingController();
final TextEditingController _link = TextEditingController();
final TextEditingController _search = TextEditingController();
final ManagerPageController _managerPageController = Get.find();
final HomeController _homeController = Get.find();

Future<void> createEditBanner(BuildContext context,
    {String? image,

      onChangeDropDown,
      String? fullName,
      String? edit,
      String bannerType = "link",
      String? id,
      String? phone,
      Middle1? banner,
      String? userName,
      String? bannerGroup,
      onConfirmImage}) async {
  _managerPageController.clearData();
  _managerPageController.switchActive.value=false;
  _homeController.selectedMentor.clear();
  _homeController.selectedMentorFinaly.clear();

  _link.text = "";
  _titleList.text = "";
  if(edit == "edit"){
    _managerPageController.selectedImagedPath.value=GlobalInfo.serverAddress + "/" + banner!.logo!;

    _managerPageController.isLink.value=false;
    _titleList.text=banner.bannerTitle??"";
    _managerPageController.switchActive.value=banner.status!;
    _link.text=banner.bannerDescription??"";

    banner.mentors!.forEach((element) {
      _homeController.selectedMentorFinaly.add(User(fullName: element.fullName,id: element.id,phoneNumber: element.phoneNumber,userName: element.userName));
    });

     }
  // _userName.text = userName!;
  // _fullName.text = fullName!;
  // _phone.text = phone!;

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
            size: 3,
            title: "ویرایش / افزودن",
           ),
        content: Obx(
              () =>
              Container(
                height: _managerPageController.isLink.value
                    ? Get.height * 0.5
                    : Get.height * 0.8,
                width: Get.width * 0.6,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.005),

                    child: SingleChildScrollView(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                                () =>
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: AppColors.greyBorder),
                                      color: Colors.white),
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.greyFill),
                                        color: AppColors.dividerLight),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: const SizedBox(height: 0),
                                      value: _managerPageController
                                          .selectedDropDownValue.value,
                                      items:
                                      ['بازکردن لینک', 'بازکردن لیست'].map((
                                          value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: ListTile(
                                            title: CustomText(
                                                title: value, fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: onChangeDropDown,
                                    ),
                                  ),
                                ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Expanded(child: SingleChildScrollView(
                                  child: RightColumnBanner())),
                              SizedBox(
                                width: 24,
                              ),
                              Expanded(

                                child: SingleChildScrollView(
                                  child: LeftColumnBanner(

                                    link: _link,
                                    titleList: _titleList,
                                  ),
                                ),),
                            ],
                          ),
                          Obx(() =>
                          _managerPageController.isLink.value
                              ? SizedBox()
                              : listViewSection(context))
                        ],
                      ),
                    )),
              ),
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
                    if (edit == "edit") {
                      List mentors = [];
                      _homeController.selectedMentorFinaly.forEach((element) {
                        mentors.add(element.id);
                      });
                      Map<String, dynamic> body = {
                        "bannerGroup": bannerGroup,
                        "status":_managerPageController.switchActive.value,
                        "bannerType": "list",
                        "logo": {
                          "fileName": _managerPageController.nameImage.value,
                          "base64": _managerPageController.base64File.value},
                        "bannerTitle": _titleList.text,
                        "bannerDescription": _link.text,
                        "link": _link.text,
                        "mentors": mentors
                      };
                      if( _managerPageController.base64File.value == ""){
                        body.remove("logo");
                      }
                      print(body);
                      MyAlert.loding();
                      await _managerPageController.editBanner(
                          banner!.id!, body);
                      Get.back();
                      if (_managerPageController.failureMessageEditBanner
                          .value != "") {
                        MyAlert.mySnakbarRed(text: _managerPageController
                            .failureMessageEditBanner.value);
                      } else {
                        _managerPageController.getBanner();
                        Get.back();
                      }







                    }else {
                      print(_managerPageController.isLink.value);
                      if (_managerPageController.isLink.value) {
                        Map<String, dynamic> body = {
                          "bannerGroup": bannerGroup,

                          "status":_managerPageController.switchActive.value,
                          "bannerType": 'link',
                          "logo": {
                            "fileName": _managerPageController.nameImage.value,
                            "base64": _managerPageController.base64File.value},
                          "bannerTitle": _titleList.text,
                          "bannerDescription": "",
                          "link": _link.text,
                          "mentors": []
                        };
                        print(body);
                        MyAlert.loding();
                        await _managerPageController.createBanner(body);
                        Get.back();
                        if (_managerPageController.failureMessageCreateBanner
                            .value != "") {
                          MyAlert.mySnakbarRed(text: _managerPageController
                              .failureMessageCreateBanner.value);
                        } else {
                          _managerPageController.getBanner();
                          Get.back();
                        }
                      } else {
                        List mentors = [];
                        _homeController.selectedMentorFinaly.forEach((element) {
                          mentors.add(element.id);
                        });
                        Map<String, dynamic> body = {
                          "bannerGroup": bannerGroup,
                          "bannerType": "list",

                          "status":_managerPageController.switchActive.value,
                          "logo": {
                            "fileName": _managerPageController.nameImage.value,
                            "base64": _managerPageController.base64File.value},
                          "bannerTitle": _titleList.text,
                          "bannerDescription": _link.text,
                          "link": _link.text,
                          "mentors": mentors
                        };
                        print(body);
                        MyAlert.loding();
                        await _managerPageController.createBanner( body);
                        Get.back();
                        if (_managerPageController.failureMessageCreateBanner
                            .value != "") {
                          MyAlert.mySnakbarRed(text: _managerPageController
                              .failureMessageCreateBanner.value);
                        } else {
                          _managerPageController.getBanner();
                          Get.back();
                        }
                      }
                    }
                  },
                  text: "ذخیره",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                  bgColor: AppColors.disabledGrey,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

Widget listViewSection(BuildContext context) =>
    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),

          TextFieldsCustomWidget(
            height: Get.height * 0.05,
            flex: 3,
            btnTitle: "افزودن مشاور",
            searchController: _search,
            onTap: () {
              _homeController.selectedMentor.addAll(
                  _homeController.selectedMentorFinaly);
              selectUserDialog(context);
            },
          ),

          const MentorListWidget(
            isTitle: true,
            image: "",
            userName: "نام کاربری",
            mainUserName: "نام و نام خانوادگی",
            phoneNumber: "شماره تلفن",
          ),

          ListView.builder(
              shrinkWrap: true,
              itemCount: _homeController.selectedMentorFinaly.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var mentor = _homeController.selectedMentorFinaly[index];
                return MentorListWidget(
                  onTap: () {
                    _homeController.selectedMentorFinaly.removeAt(index);
                  },
                  isTitle: false,
                  phoneNumber: mentor.phoneNumber ?? "",
                  mainUserName: mentor.fullName ?? "",
                  userName: mentor.userName ?? "",
                  image: mentor.profileImage == null ? null : GlobalInfo
                      .serverAddress + "/" + mentor.profileImage!,
                );
              }),

          SizedBox(
            height: Get.height * 0.07,
          ),

          // pageSection(5),
        ],
      ),
    );

Widget pageSection(int value) {
  return SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        value <= 5
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
            itemCount: value,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                    () =>
                    InkWell(
                      onTap: () {
                        // homeController.selectedPage.value = index + 1;
                        // homeController.fetchUsers(index + 1);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index + 1 == 5
                                ? AppColors.blueIndigo
                                : Colors.white),
                        child: Center(
                          child: CustomText(
                            title: "${index + 1}",
                            color: index + 1 == 5
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
        value <= 5
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

void onSave() {
  print(_fullName.text);
  print(_titleList.text);
}
