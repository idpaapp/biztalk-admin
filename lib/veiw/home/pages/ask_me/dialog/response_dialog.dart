import 'package:biztalk_panel_admin/model/ask_me/get_mentor_for_ask_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final HomeController _homeController = Get.find();

Future<void> responseDialogS(BuildContext context,
    {String? title, String? question, String? id}) async {
  TextEditingController _question = TextEditingController();
  TextEditingController _response = TextEditingController();
  _question.text = question ?? "";


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
        title: const TitleWidget(
          size: 1,
          title: "پاسخ به سوالات",
        ),
        content: SizedBox(
          height: Get.height * 0.72,
          width: Get.width * 0.5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextWidget(
                    title: "موضوع",
                    bgColor: Colors.white,
                    textColor: AppColors.greyMiddle,
                    titleColor: AppColors.greyMiddle,
                    hint: title,
                    borderColor: AppColors.borderColor,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TitleTextFieldWidget(
                    title: "توضیحات سوال",
                    editingController: _question,
                    maxLines: 5,
                    enabled: false,
                    hint: "",
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomText(
                    color: AppColors.greyMiddle,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    title: "پاسخ دهنده",
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                        color: Colors.white),
                    child: Obx(() => DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(height: 0),
                          value: _homeController.mentorId.value,
                          items: _homeController.resultGetMentor.value.data!
                              .map((MentroAsk value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: CustomText(title: value.fullName),
                            );
                          }).toList(),
                          onChanged: (val) {
                            _homeController.mentorId.value = val.toString();
                          },
                        )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TitleTextFieldWidget(
                    title: "پاسخ شما",
                    editingController: _response,
                    maxLines: 5,
                    hint: "پاسخ شما",
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonText(
                  onPressed: ()  {
                    confirmDialog(context,title: "آیا برای رد کردن سوال اطمینان دارید؟",onConfirm: ()async{
                      MyAlert.loding();
                      await _homeController.rejectQuestion(id!);
                      Get.back();
                      if(_homeController.failureMessageRejectQuestion.value !=""){
                        MyAlert.mySnakbarRed(text:_homeController.failureMessageRejectQuestion.value );
                      }else{
                        _homeController.getQuestions();
                        _homeController.askMeFilter.value = "All";
                        Get.back();
                        Get.back();

                      }
                    });



                  },
                  text: "رد کردن سوال",
                  borderRadios: 10,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.08,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.red,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonText(
                      onPressed: () async {
                        if(_homeController.mentorId.value == "" || _response.text == ""  ){
                          MyAlert.mySnakbarRed(text: "وارد کردن تمامی موارد الزامی است");
                        }else {
                          Map<String, String> body = {
                            "userAnswer": _homeController.mentorId.value,
                            "answer": _response.text
                          };
                          MyAlert.loding();
                          await _homeController.sendAnswer(id!, body);
                          Get.back();
                          if (_homeController.failureMessageSendAnswer.value !=
                              "") {
                            MyAlert.mySnakbarRed(
                                text: _homeController
                                    .failureMessageSendAnswer.value);
                          } else {

                            _homeController.getQuestions();
                            Get.back();

                            _homeController.askMeFilter.value = "All";
                            _response.text="";

                          }
                        }
                      },
                      text: "ذخیره",
                      borderRadios: 10,
                      fontWeight: FontWeight.w500,
                      height: 40,
                      width: 70,
                      fontSize: 14,
                      textColor: Colors.white,
                      bgColor: AppColors.blueSession,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ButtonText(
                      borderRadios: 10,
                      onPressed: () {
                        Get.back();
                      },
                      text: "انصراف",
                      height: 40,
                      fontSize: 14,
                      width: 70,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.blueSession,
                      bgColor: Colors.white,
                      borderColor: AppColors.blueSession,
                      activeBorder: 1,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
