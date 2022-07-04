import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/resources/my_bottomsheet.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_dialog.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/textfield_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final DocumentController _documentController = Get.put(DocumentController());

class SetNewAch {
  static setAch(BuildContext context,String mentorID, String edit, {Achievement? achievement}) {
    final TextEditingController _year = TextEditingController();
    final TextEditingController _location = TextEditingController();
    final TextEditingController _titleAchivment = TextEditingController();
    if (edit == "edit") {
      _year.text = achievement!.year.toString();
      _location.text = achievement.place.toString();
      _titleAchivment.text = achievement.title.toString();
    }else{
      _year.text = "";
      _location.text = "";
      _titleAchivment.text = "";

    }

    DocumentDialog(context,title:"دستاوردها و جوایز کسب شده",content:Padding(
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 14),
          //   child: Row(
          //     children: [
          //       ButtonText(
          //         onPressed: () async {
          //
          //         },
          //         text: "افزودن",
          //         height: 35,
          //         fontSize: 14,
          //         width: 110,
          //         textColor: Colors.white,
          //         bgColor: AppColors.darkerGreen,
          //       ),
          //       SizedBox(
          //         width: 15,
          //       ),
          //       edit == "edit"
          //           ? ButtonText(
          //         onPressed: () async {
          //           MyAlert.deleteBottomSheet(
          //               text: "آیا برای حذف اطمینان دارید؟",
          //               onCancel: () {
          //                 Get.back();
          //               },
          //               title: "توجه",
          //               onConfirm: () async {
          //                 MyAlert.loding();
          //                 await _documentController.deleteAchievement(
          //                     mentorID, achievement!.id!);
          //                 Get.back();
          //                 if (_documentController
          //                     .failureMessageDeleteAchievement
          //                     .value !=
          //                     "") {
          //                   MyAlert.mySnakbarRed(
          //                       text: _documentController
          //                           .failureMessageDeleteAchievement
          //                           .value);
          //                 } else {
          //                   Get.back();
          //                   Get.back();
          //                   _documentController.getDocument(mentorID);
          //                 }
          //               });
          //         },
          //         text: "حذف",
          //         height: 35,
          //         fontSize: 14,
          //         width: 110,
          //         textColor: Colors.white,
          //         bgColor: AppColors.red,
          //       )
          //           : SizedBox(
          //         height: 0,
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    ),onSave: ()async{ Map<String, dynamic> body = {
      "title": _titleAchivment.text,
      "place": _location.text,
      "year": _year.text,
    };
    if (edit == "edit") {
      MyAlert.loding();
      await _documentController.editAchivement(
          body, mentorID, achievement!.id!);

      Get.back();
      if (_documentController
          .failureMessageEditAchivement.value !=
          "") {
        MyAlert.mySnakbarRed(
            text: _documentController
                .failureMessageEditAchivement.value);
      } else {
        _documentController.getDocument(mentorID);
        Get.back();
      }
    } else {
      MyAlert.loding();
      await _documentController.createAchive(body, mentorID);
      Get.back();
      if (_documentController
          .failureMessageCreateAchive.value !=
          "") {
        MyAlert.mySnakbarRed(
            text: _documentController
                .failureMessageCreateAchive.value);
      } else {
        _documentController.getDocument(mentorID);
        Get.back();
      }
    }}  );




    // CustomBottomSheet.myBottomSheet(
    //   title: "دستاوردها و جوایز کسب شده",
    //   widget: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         TextfieldTitleWidgets(
    //           textEditingController: _location,
    //           title: "محل اخذ",
    //           hint: "محل اخذ",
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         TextfieldTitleWidgets(
    //           textEditingController: _titleAchivment,
    //           title: "عنوان دستاورد یا جایزه کسب شده",
    //           hint: "عنوان دستاورد یا جایزه کسب شده",
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         TextfieldTitleWidgets(
    //           textEditingController: _year,
    //           title: "سال اخذ دستاورد یا جایزه کسب شده",
    //           hint: "مثلا : 1390",
    //           activeNumber: true,
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 14),
    //           child: Row(
    //             children: [
    //               ButtonText(
    //                 onPressed: () async {
    //                   Map<String, dynamic> body = {
    //                     "title": _titleAchivment.text,
    //                     "place": _location.text,
    //                     "year": _year.text,
    //                   };
    //                   if (edit == "edit") {
    //                     MyAlert.loding();
    //                     await _documentController.editAchivement(
    //                         body, mentorID, achievement!.id!);
    //
    //                     Get.back();
    //                     if (_documentController
    //                             .failureMessageEditAchivement.value !=
    //                         "") {
    //                       MyAlert.mySnakbarRed(
    //                           text: _documentController
    //                               .failureMessageEditAchivement.value);
    //                     } else {
    //                       _documentController.getDocument(mentorID);
    //                       Get.back();
    //                     }
    //                   } else {
    //                     MyAlert.loding();
    //                     await _documentController.createAchive(body, mentorID);
    //                     Get.back();
    //                     if (_documentController
    //                             .failureMessageCreateAchive.value !=
    //                         "") {
    //                       MyAlert.mySnakbarRed(
    //                           text: _documentController
    //                               .failureMessageCreateAchive.value);
    //                     } else {
    //                       _documentController.getDocument(mentorID);
    //                       Get.back();
    //                     }
    //                   }
    //                 },
    //                 text: "افزودن",
    //                 height: 35,
    //                 fontSize: 14,
    //                 width: 110,
    //                 textColor: Colors.white,
    //                 bgColor: AppColors.darkerGreen,
    //               ),
    //               SizedBox(
    //                 width: 15,
    //               ),
    //               edit == "edit"
    //                   ? ButtonText(
    //                       onPressed: () async {
    //                         MyAlert.deleteBottomSheet(
    //                             text: "آیا برای حذف اطمینان دارید؟",
    //                             onCancel: () {
    //                               Get.back();
    //                             },
    //                             title: "توجه",
    //                             onConfirm: () async {
    //                               MyAlert.loding();
    //                               await _documentController.deleteAchievement(
    //                                   mentorID, achievement!.id!);
    //                               Get.back();
    //                               if (_documentController
    //                                       .failureMessageDeleteAchievement
    //                                       .value !=
    //                                   "") {
    //                                 MyAlert.mySnakbarRed(
    //                                     text: _documentController
    //                                         .failureMessageDeleteAchievement
    //                                         .value);
    //                               } else {
    //                                 Get.back();
    //                                 Get.back();
    //                                 _documentController.getDocument(mentorID);
    //                               }
    //                             });
    //                       },
    //                       text: "حذف",
    //                       height: 35,
    //                       fontSize: 14,
    //                       width: 110,
    //                       textColor: Colors.white,
    //                       bgColor: AppColors.red,
    //                     )
    //                   : SizedBox(
    //                       height: 0,
    //                     )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
