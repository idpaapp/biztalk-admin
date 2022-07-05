import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/edit_profile_controller.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> selectionDialog(BuildContext context) async {
  TextEditingController _search = TextEditingController();
  final EditProfileController _editController =
      Get.put(EditProfileController());
  final HomeController _homeController = Get.find();
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        title: const TitleWidget(
            size: 1,
            title: "انتخاب زمینه ها",
           ),
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.5,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.veryLightGrey,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.disabledGrey,
                      ),
                    ),
                    child: TextField(
                        controller: _search,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: InputBorder.none,
                            hintText: "جست وجو",
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.black,
                            ))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => Wrap(
                    spacing: 10,
                        runSpacing: 10,
                        children: _homeController.resultCategory.value.data!
                            .map((element) => ChoiceChip(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: AppColors.tosi,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                label: CustomText(
                                    title: element.title,
                                    color: _editController.selectedChoicesId
                                            .contains(element.id)
                                        ? Colors.white
                                        : AppColors.black),
                                backgroundColor: Colors.white,
                                selectedColor: AppColors.tosi,
                                onSelected: (selected) {

                                  if(_editController.selectedChoicesId.contains(element.id)){
                                    _editController.selectedChoicesId.remove(element.id);
                                    _editController.selectedChoicesTitle.remove(element.title);
                                  }else{
                                    _editController.selectedChoicesId.add(element.id);
                                    _editController.selectedChoicesTitle.add(element.title);
                                  }

                                },
                                selected: _editController.selectedChoicesId
                                    .contains(element.id)))
                            .toList(),
                      ))
                ],
              )),
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
                  onPressed: () {
                    _editController.finallySelectId.clear();
                    _editController.finallySelectTitle.clear();
                    _editController.finallySelectId.addAll(_editController.selectedChoicesId);
                    _editController.finallySelectTitle.addAll(_editController.selectedChoicesTitle);
                    Get.back();
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
