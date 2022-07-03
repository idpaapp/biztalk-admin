import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/delete_accept_widget.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/edit_profile_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/select_dialog/select_dialog_section.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';

import 'package:biztalk_panel_admin/veiw/show_image/show_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightColumnWidget extends StatelessWidget {
  final TextEditingController? fullName;
  final TextEditingController? userName;
  final TextEditingController? phone;
  final String? image;
  final onDeleteImage;
  final onConfirmImage;
  final EditProfileController _editProfileController =
      Get.put(EditProfileController());

  RightColumnWidget(
      {Key? key,
      this.fullName,
      this.onConfirmImage,
      this.onDeleteImage,
      this.userName,
      this.image,
      this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageSection(context),
              const SizedBox(
                height: 10,
              ),
              TitleTextFieldWidget(
                title: "نام و نام خانوادگی",
                editingController: fullName,
              ),
              const SizedBox(
                height: 10,
              ),
              TitleTextFieldWidget(
                title: "نام کاربری",
                editingController: userName,
              ),
              const SizedBox(
                height: 10,
              ),
              TitleTextFieldWidget(
                title: "تلفن همراه",
                editingController: phone,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: CustomText(
                  color: AppColors.lighterBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  title: "میزان تسلط یا مهارت اصلی شما",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.dividerDark,
                    ),
                    color: AppColors.veryLightGrey),
                child: Obx(() => DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(height: 0),
                      value: _editProfileController.gradeTitle.value,
                      items: <String>['مبتدی', 'حرفه ای', 'متخصص']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(title: value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _editProfileController.gradeTitle.value =
                            val.toString();
                      },
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      color: AppColors.lighterBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      title: "زمینه های مشاوره",
                    ),
                    InkWell(
                      onTap: () {
                        _editProfileController.selectedChoicesId.clear();
                        _editProfileController.selectedChoicesTitle.clear();
                        _editProfileController.selectedChoicesId
                            .addAll(_editProfileController.finallySelectId);
                        _editProfileController.selectedChoicesTitle
                            .addAll(_editProfileController.finallySelectTitle);
                        selectionDialog(context);
                      },
                      child: const CustomText(
                          title: "ویرایش",
                          color: AppColors.blueIndigo,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Container(
                    height: Get.height * 0.06,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _editProfileController.finallySelectTitle
                            .map((element) => Chip(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: AppColors.tosi,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  label: CustomText(
                                      title: element, color: Colors.white),
                                  backgroundColor: AppColors.tosi,
                                ))
                            .toList(),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );

  Widget imageSection(BuildContext context) => Row(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                showImage(context, "نمایش تصویر", image!);
              },
              child: Obx(() => _editProfileController.removeImage.value ||
                      image == null
                  ? const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage("assets/images/avatar_placeholder.png"))
                  : CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          GlobalInfo.serverAddress + "/" + image!))),
            ),
          ),
          SizedBox(width: 12,),
          DeleteAcceptWidget(onConfirm: onConfirmImage,onDelete:onDeleteImage ,)
        ],
      );
}
