import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:get/get.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class RightColumnEditDocument extends StatelessWidget {
  final String? nameTitle;
  final String? nameTitle2;
  final String? nameTitle3;
  final String? titleDialog;
  final String? fromPage;
  final bool? isActiveSwitch;
  final onConfirmTitle;
  final onDeleteTitle;

  final TextEditingController? nameTitleController;
  final TextEditingController? nameTitle2Controller;
  final TextEditingController? nameTitle3Controller;
  final TextEditingController? startYear;
  final TextEditingController? endYear;
  final DocumentController _documentController = Get.put(DocumentController());

  final TextEditingController _lastYear = TextEditingController();
  final TextEditingController _firstYear = TextEditingController();
  RightColumnEditDocument(
      {Key? key,
      this.nameTitle2,
        this.startYear,
        this.endYear,
        this.onDeleteTitle,
        this.onConfirmTitle,
      this.nameTitle3,
        this.fromPage,
      this.nameTitle,
      this.nameTitle2Controller,
      this.nameTitle3Controller,
      this.nameTitleController,
        this.isActiveSwitch,
      this.titleDialog})
      : super(key: key){
    _lastYear.text =endYear!.text;
    _firstYear.text =startYear!.text;
    _documentController.isActiveJobSwitch.value=isActiveSwitch??false;
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      TitleTextFieldWidget(
        activeDelete: true,
        onConfirm: onConfirmTitle,
        onDelete: onDeleteTitle,
        title: nameTitle,
        editingController: nameTitleController,
        pre: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.darkerGreen,),
            child: const Center(child: Icon(Icons.image,color: Colors.white,)),
          ),
        ),
      ),
      const SizedBox(height: 12,),






      const SizedBox(
        height: 20,
      ),
      TitleTextFieldWidget(
        title: nameTitle2,
        editingController: nameTitle2Controller,

      ),
      const SizedBox(
        height: 20,
      ),
     fromPage == "job" ?const SizedBox(height: 0,): TitleTextFieldWidget(
        title: nameTitle3,
        editingController: nameTitle3Controller,
      ),
      const SizedBox(
        height: 20,
      ),
     fromPage == "ach"?const SizedBox(height: 0,): Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: " بازه $titleDialog",
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          Row(
            children: [
              Obx(
                () => Directionality(
                  textDirection: TextDirection.ltr,
                  child: Switch(
                    value: _documentController.isActiveJobSwitch.value,
                    onChanged: (bool value) {
                      _documentController.isActiveJobSwitch.value = value;
                      if (value == true) {
                        _lastYear.text = currentYear();
                      } else {
                        _lastYear.text = "";
                      }
                    },
                    activeColor: AppColors.darkerGreen,
                  ),
                ),
              ),
              CustomText(
                title: " مشغول به $titleDialog",
                color: AppColors.black,
                fontSize: 12,
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      fromPage == "ach"?const SizedBox(height: 0,):Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Center(
              child: CustomText(
                title: "از",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                // height: 50,
                // width: Get.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,border: Border.all(color: AppColors.borderColor)),
                child: TextField(
                  controller: _firstYear,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "سال شروع",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    hintStyle:
                        TextStyle(color: AppColors.black, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: CustomText(
                title: "تا",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Obx(
                    () =>Container(
                // height: 50,
                // width: Get.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:_documentController.isActiveJobSwitch.value? AppColors.veryLightGrey:Colors.white,border: Border.all(color: AppColors.borderColor)),
                child:  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _documentController.isActiveJobSwitch.value
                            ? AppColors.darkGrey
                            : AppColors.black),
                    controller: _lastYear,
                    keyboardType: TextInputType.number,
                    enabled: _documentController.isActiveJobSwitch.value
                        ? false
                        : true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "سال پایان",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 5),
                      hintStyle: TextStyle(
                          color:
                              _documentController.isActiveJobSwitch.value
                                  ? AppColors.darkGrey
                                  : AppColors.black,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
