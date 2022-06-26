import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/resources/my_bottomsheet.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/textfield_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final DocumentController _documentController =Get.put(DocumentController());

class SetNewAch{
  static setAch(String mentorID){
    final TextEditingController _year = TextEditingController();
    final TextEditingController _location = TextEditingController();
    final TextEditingController _titleAchivment = TextEditingController();
    CustomBottomSheet.myBottomSheet(
      title: "دستاوردها و جوایز کسب شده",
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextfieldTitleWidgets(
              textEditingController: _location,
              title: "محل اخذ",
              hint: "محل اخذ",
            ),
            const SizedBox(
              height: 12,
            ),
            TextfieldTitleWidgets(
              textEditingController: _titleAchivment,
              title: "عنوان دستاورد یا جایزه کسب شده",
              hint: "عنوان دستاورد یا جایزه کسب شده",
            ),
            const SizedBox(
              height: 12,
            ),
            TextfieldTitleWidgets(
              textEditingController: _year,
              title: "سال اخذ دستاورد یا جایزه کسب شده",
              hint: "مثلا : 1390",
              activeNumber: true,
            ),
            const SizedBox(
              height: 12,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  ButtonText(
                    onPressed: () async{
                      Map<String, dynamic> body = {
                        "title": _titleAchivment.text,
                        "place": _location.text,
                        "year": _year.text,
                      };
                      MyAlert.loding();
                      await _documentController.createAchive(body, mentorID);
                      Get.back();
                      if(_documentController.failureMessageCreateAchive.value !=""){
                        MyAlert.mySnakbarRed(text: _documentController.failureMessageCreateAchive.value);
                      }else{
                        _documentController.getDocument(mentorID);
                        Get.back();
                      }

                    },
                    text:  "افزودن",
                    height: 35,
                    fontSize: 14,
                    width: 110,
                    textColor: Colors.white,
                    bgColor: AppColors.darkerGreen,
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );

  }

}