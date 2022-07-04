import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/current_shamsi_year.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/resources/my_bottomsheet.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_dialog.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/row_containear_click_widget.dart';
import 'package:biztalk_panel_admin/veiw/documents/widgets/textfield_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final DocumentController _documentController =Get.put(DocumentController());

class SetNewEdu{
  static setEdu(BuildContext context,String mentorID,String edit,{Education? education}){
    final TextEditingController _firstYear = TextEditingController();
    final TextEditingController _lastYear = TextEditingController();
    final TextEditingController _fieldOfStudy = TextEditingController();
    final TextEditingController _searchUni = TextEditingController();
    final TextEditingController _manualUniController = TextEditingController();

    if(edit == "edit"){
      _fieldOfStudy.text = education!.degree??"";
      _firstYear.text = education.startYear??"";
      _lastYear.text = education.endYear??"";
      _documentController.isActiveEducationSwitch.value =
      education.currentCourse!;



      if (education.school!.type == "other") {
        _documentController.isManualTitleUniverCity.value = true;
        _manualUniController.text = education.schoolTitle??"";
      } else {
        _documentController.isManualTitleUniverCity.value = false;

        _documentController.selectedEducationId.value = education.school!.id!;
        _documentController.selectedEducationImage.value =
        education.school!.imageUrl??"";
        _documentController.selectedEducationTitle.value =
        education.school!.title??"";
      }

    }else{
      _fieldOfStudy.text = "";
      _firstYear.text = "";
      _lastYear.text = "";
      _documentController.isActiveEducationSwitch.value =false;
      _documentController.selectedEducationId.value = "";
      _documentController.selectedEducationImage.value ="";
      _documentController.selectedEducationTitle.value ="";

    }

    DocumentDialog(context,title: "سوابق تحصیلی و مدارک علمی",content:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            title: " دانشگاه یا موسسه آموزشی",
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          const SizedBox(
            height: 12,
          ),
          Obx(() => RowContainerClickWidgets(
            title: _documentController.isManualTitleUniverCity.value
                ? "سایر دانشگاه و موسسه آموزشی"
                : _documentController.selectedEducationTitle.value,
            imgPath: _documentController.isManualTitleUniverCity.value
                ? ""
                : _documentController.selectedEducationImage.value,
            onTap: () async {
              MyAlert.loding();
              await _documentController.getOption("school");
              if (_documentController.failureMessageGetOption.value !=
                  "") {
                Get.back();
                MyAlert.mySnakbarRed(
                    text: _documentController
                        .failureMessageGetOption.value);
                return;
              } else {
                Get.back();
                onStudyFieldClick(context);
              }
            },
          )),
          const SizedBox(
            height: 12,
          ),
          Obx(() => _documentController.isManualTitleUniverCity.value
              ? TextfieldTitleWidgets(
            textEditingController: _manualUniController,
            title: "نام دانشگاه یا موسسه",
            hint: "دانشگاه مورد نظر",

          )
              : const SizedBox(
            height: 0,
          )),
          const SizedBox(
            height: 12,
          ),
          TextfieldTitleWidgets(
            textEditingController: _fieldOfStudy,
            title: "رشته یا عنوان دوره آموزشی",
            hint: "رشته یا عنوان دوره آموزشی",
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                title: "سال شروع و پایان فعاللیت",
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
                        value: _documentController
                            .isActiveEducationSwitch.value,
                        onChanged: (bool value) {
                          _documentController.isActiveEducationSwitch.value =
                              value;
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
                  const CustomText(
                    title: "هم اکنون مشغول به تحصیل هستم",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.veryLightGrey),
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
              SizedBox(width: 20,),
              const CustomText(
                title: "تا",
              ),

              SizedBox(width: 20,),

              Expanded(
                child: Container(

                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.veryLightGrey),
                  child: Obx(() => TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    enabled:
                    _documentController.isActiveEducationSwitch.value
                        ? false
                        : true,
                    controller: _lastYear,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "سال پایان",
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5),
                      hintStyle: TextStyle(
                          color: _documentController
                              .isActiveEducationSwitch.value
                              ? AppColors.darkGrey
                              : AppColors.black,
                          fontSize: 12),
                    ),
                  )),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 6,
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 14),
          //   child: Row(
          //     children: [
          //       ButtonText(
          //         onPressed: ()async {
          //
          //
          //         },
          //         text: "افزودن",
          //         height: 35,
          //         fontSize: 14,
          //         width: 110,
          //         textColor: Colors.white,
          //         bgColor: AppColors.darkerGreen,
          //       ),
          //       SizedBox(width: 15,),
          //       edit =="edit"?  ButtonText(
          //         onPressed: ()async {
          //           MyAlert.deleteBottomSheet(text: "آیا برای حذف اطمینان دارید؟",onCancel: (){
          //             Get.back();
          //           },title: "توجه",onConfirm: ()async{
          //             MyAlert.loding();
          //             await _documentController.deleteEducation(mentorID,education!.id!);
          //             Get.back();
          //             if(_documentController.failureMessageDeleteEducation.value !=""){
          //               MyAlert.mySnakbarRed(text: _documentController.failureMessageDeleteEducation.value);
          //             }else{
          //               Get.back();
          //               Get.back();
          //               _documentController.getDocument(mentorID);
          //
          //             }
          //           });
          //
          //
          //
          //         },
          //         text:"حذف",
          //         height: 35,
          //         fontSize: 14,
          //         width: 110,
          //         textColor: Colors.white,
          //         bgColor: AppColors.red,
          //       )
          //           :SizedBox(height: 0,)
          //
          //     ],
          //   ),
          // )
        ],
      ),
    ),onSave: ()async{
      Map<String, dynamic> body = {

        "degree": _fieldOfStudy.text,
        "startYear": _firstYear.text,
        "endYear": _lastYear.text,
        "currentCourse": _documentController.isActiveEducationSwitch.value
      };

      if (_documentController.isManualTitleUniverCity.value) {
        body['schoolTitle'] = _manualUniController.text;
      } else {
        body['school'] = _documentController.selectedEducationId.value;
        body['schoolTitle'] = _documentController.selectedEducationTitle.value;
      }
      if(edit == "edit"){

        print(body);

        MyAlert.loding();
        await _documentController.editEducation(body, mentorID,education!.id!);
        Get.back();
        if (_documentController.failureMessageEditEducation
            .value != "") {
          MyAlert.mySnakbarRed(text: _documentController
              .failureMessageEditEducation.value);
        } else {
          _documentController.getDocument(mentorID);
          Get.back();
        }


      }else{
        MyAlert.loding();
        await _documentController.createEducation(body, mentorID);
        Get.back();
        if(_documentController.failureMessageCreateEducation.value !=""){
          MyAlert.mySnakbarRed(text: _documentController.failureMessageCreateEducation.value);
        }else{
          _documentController.getDocument(mentorID);
          Get.back();
        }}
    }  );
    // CustomBottomSheet.myBottomSheet(
    //   title: "سوابق تحصیلی و مدارک علمی",
    //   widget: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const CustomText(
    //           title: " دانشگاه یا موسسه آموزشی",
    //           color: AppColors.black,
    //           fontWeight: FontWeight.w600,
    //           fontSize: 12,
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Obx(() => RowContainerClickWidgets(
    //           title: _documentController.isManualTitleUniverCity.value
    //               ? "سایر دانشگاه و موسسه آموزشی"
    //               : _documentController.selectedEducationTitle.value,
    //           imgPath: _documentController.isManualTitleUniverCity.value
    //               ? ""
    //               : _documentController.selectedEducationImage.value,
    //           onTap: () async {
    //             MyAlert.loding();
    //             await _documentController.getOption("school");
    //             if (_documentController.failureMessageGetOption.value !=
    //                 "") {
    //               Get.back();
    //               MyAlert.mySnakbarRed(
    //                   text: _documentController
    //                       .failureMessageGetOption.value);
    //               return;
    //             } else {
    //               Get.back();
    //               onStudyFieldClick();
    //             }
    //           },
    //         )),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Obx(() => _documentController.isManualTitleUniverCity.value
    //             ? TextfieldTitleWidgets(
    //           textEditingController: _manualUniController,
    //           title: "نام دانشگاه یا موسسه",
    //           hint: "دانشگاه مورد نظر",
    //
    //         )
    //             : const SizedBox(
    //           height: 0,
    //         )),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         TextfieldTitleWidgets(
    //           textEditingController: _fieldOfStudy,
    //           title: "رشته یا عنوان دوره آموزشی",
    //           hint: "رشته یا عنوان دوره آموزشی",
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const CustomText(
    //               title: "سال شروع و پایان فعاللیت",
    //               color: AppColors.black,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 12,
    //             ),
    //             Row(
    //               children: [
    //                 Obx(
    //                       () => Directionality(
    //                     textDirection: TextDirection.ltr,
    //                     child: Switch(
    //                       value: _documentController
    //                           .isActiveEducationSwitch.value,
    //                       onChanged: (bool value) {
    //                         _documentController.isActiveEducationSwitch.value =
    //                             value;
    //                         if (value == true) {
    //                           _lastYear.text = currentYear();
    //                         } else {
    //                           _lastYear.text = "";
    //                         }
    //                       },
    //                       activeColor: AppColors.darkerGreen,
    //                     ),
    //                   ),
    //                 ),
    //                 const CustomText(
    //                   title: "هم اکنون مشغول به تحصیل هستم",
    //                   color: AppColors.black,
    //                   fontSize: 12,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               height: 50,
    //               width: Get.width * 0.3,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(12),
    //                   color: AppColors.veryLightGrey),
    //               child: TextField(
    //                 controller: _firstYear,
    //                 textAlign: TextAlign.center,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(
    //                   border: InputBorder.none,
    //                   hintText: "سال شروع",
    //                   contentPadding: EdgeInsets.symmetric(horizontal: 5),
    //                   hintStyle:
    //                   TextStyle(color: AppColors.black, fontSize: 12),
    //                 ),
    //               ),
    //             ),
    //             const CustomText(
    //               title: "تا",
    //             ),
    //             Container(
    //               height: 50,
    //               width: Get.width * 0.3,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(12),
    //                   color: AppColors.veryLightGrey),
    //               child: Obx(() => TextField(
    //                 textAlign: TextAlign.center,
    //                 keyboardType: TextInputType.number,
    //                 enabled:
    //                 _documentController.isActiveEducationSwitch.value
    //                     ? false
    //                     : true,
    //                 controller: _lastYear,
    //                 decoration: InputDecoration(
    //                   border: InputBorder.none,
    //                   hintText: "سال پایان",
    //                   contentPadding:
    //                   const EdgeInsets.symmetric(horizontal: 5),
    //                   hintStyle: TextStyle(
    //                       color: _documentController
    //                           .isActiveEducationSwitch.value
    //                           ? AppColors.darkGrey
    //                           : AppColors.black,
    //                       fontSize: 12),
    //                 ),
    //               )),
    //             ),
    //           ],
    //         ),
    //
    //         const SizedBox(
    //           height: 6,
    //         ),
    //
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 14),
    //           child: Row(
    //             children: [
    //               ButtonText(
    //                 onPressed: ()async {
    //                   Map<String, dynamic> body = {
    //
    //                     "degree": _fieldOfStudy.text,
    //                     "startYear": _firstYear.text,
    //                     "endYear": _lastYear.text,
    //                     "currentCourse": _documentController.isActiveEducationSwitch.value
    //                   };
    //
    //                   if (_documentController.isManualTitleUniverCity.value) {
    //                     body['schoolTitle'] = _manualUniController.text;
    //                   } else {
    //                     body['school'] = _documentController.selectedEducationId.value;
    //                     body['schoolTitle'] = _documentController.selectedEducationTitle.value;
    //                   }
    //                   if(edit == "edit"){
    //
    //                     print(body);
    //
    //                     MyAlert.loding();
    //                     await _documentController.editEducation(body, mentorID,education!.id!);
    //                     Get.back();
    //                     if (_documentController.failureMessageEditEducation
    //                         .value != "") {
    //                       MyAlert.mySnakbarRed(text: _documentController
    //                           .failureMessageEditEducation.value);
    //                     } else {
    //                       _documentController.getDocument(mentorID);
    //                       Get.back();
    //                     }
    //
    //
    //                   }else{
    //                   MyAlert.loding();
    //                   await _documentController.createEducation(body, mentorID);
    //                   Get.back();
    //                   if(_documentController.failureMessageCreateEducation.value !=""){
    //                     MyAlert.mySnakbarRed(text: _documentController.failureMessageCreateEducation.value);
    //                   }else{
    //                     _documentController.getDocument(mentorID);
    //                     Get.back();
    //                   }}
    //
    //                 },
    //                 text: "افزودن",
    //                 height: 35,
    //                 fontSize: 14,
    //                 width: 110,
    //                 textColor: Colors.white,
    //                 bgColor: AppColors.darkerGreen,
    //               ),
    //               SizedBox(width: 15,),
    //               edit =="edit"?  ButtonText(
    //                 onPressed: ()async {
    //                   MyAlert.deleteBottomSheet(text: "آیا برای حذف اطمینان دارید؟",onCancel: (){
    //                     Get.back();
    //                   },title: "توجه",onConfirm: ()async{
    //                     MyAlert.loding();
    //                     await _documentController.deleteEducation(mentorID,education!.id!);
    //                     Get.back();
    //                     if(_documentController.failureMessageDeleteEducation.value !=""){
    //                       MyAlert.mySnakbarRed(text: _documentController.failureMessageDeleteEducation.value);
    //                     }else{
    //                       Get.back();
    //                       Get.back();
    //                       _documentController.getDocument(mentorID);
    //
    //                     }
    //                   });
    //
    //
    //
    //                 },
    //                 text:"حذف",
    //                 height: 35,
    //                 fontSize: 14,
    //                 width: 110,
    //                 textColor: Colors.white,
    //                 bgColor: AppColors.red,
    //               )
    //                   :SizedBox(height: 0,)
    //
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );


  }
  static void onStudyFieldClick(BuildContext context) {
    final TextEditingController _searchUni = TextEditingController();
    final TextEditingController _manualUniController = TextEditingController();
    _documentController.isSearch.value = false;
    _documentController.filterSearch.clear();

    DocumentDialog(context,title: "لیست دانشگاه ها",activeBTN: true,content: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.veryLightGrey),
              child: Row(
                children: [
                  const Expanded(child: Icon(Icons.search)),
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: _searchUni,
                      onChanged: (val) {
                        if (val.length > 0) {
                          _documentController.isSearch.value = true;
                          _documentController.filterSearch.clear();
                        } else {
                          _documentController.filterSearch.clear();
                          _documentController.isSearch.value = false;
                        }

                        _documentController.filterSearch.addAll(
                            _documentController.resultGetOption.value.data!
                                .where((e) => e.title
                                .toString().toLowerCase()
                                .contains(val.toLowerCase())));
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "دانشگاه مورد نظرت رو جست و جو کن",
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintStyle:
                        TextStyle(color: AppColors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonText(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              height: 40,
              onPressed: () {
                _documentController.isManualTitleUniverCity.value = true;
                Get.back();
              },
              text: "سایر دانشگاه ها",
              bgColor: AppColors.darkerGreen,
              textColor: Colors.white,
            ),

          ],
        ),
      ),
      Obx(() => _documentController.isSearch.value == true &&
          _documentController.filterSearch.isEmpty
          ? const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 20),
          child: CustomText(
            title: "اطلاعاتی یافت نشد",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
          : ListView.builder(
          physics: ScrollPhysics(),
          itemCount: _documentController.isSearch.value
              ? _documentController.filterSearch.length
              : _documentController
              .resultGetOption.value.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var uni = _documentController.isSearch.value
                ? _documentController.filterSearch[index]
                : _documentController
                .resultGetOption.value.data![index];
            return ListTile(
                onTap: () {
                  _documentController.selectedEducationImage.value =
                      uni.imageUrl ?? "";
                  _documentController.selectedEducationId.value =
                  uni.id!;
                  _documentController.selectedEducationTitle.value =
                  uni.title!;
                  _documentController.isManualTitleUniverCity.value =
                  false;
                  _manualUniController.text = "";
                  _searchUni.text = "";
                  _documentController.isSearch.value = false;
                  _documentController.filterSearch.clear();

                  Get.back();
                },
                title: CustomText(
                  title: uni.title,
                ),
                leading: uni.imageUrl == null
                    ? Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.lighterGrey,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/avatar_placeholder.png"),
                        fit: BoxFit.fill),
                  ),
                )
                    : Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.lighterGrey,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(
                          uni.imageUrl,
                        ),
                        fit: BoxFit.contain),
                  ),
                ));
          }))




    ]),));


    //
    // CustomBottomSheet.widgetBottomSheet(
    //     height: Get.height*0.8,
    //
    //
    //     titleWidget: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 50,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(12),
    //                 color: AppColors.veryLightGrey),
    //             child: Row(
    //               children: [
    //                 const Expanded(child: Icon(Icons.search)),
    //                 Expanded(
    //                   flex: 9,
    //                   child: TextField(
    //                     controller: _searchUni,
    //                     onChanged: (val) {
    //                       if (val.length > 0) {
    //                         _documentController.isSearch.value = true;
    //                         _documentController.filterSearch.clear();
    //                       } else {
    //                         _documentController.filterSearch.clear();
    //                         _documentController.isSearch.value = false;
    //                       }
    //
    //                       _documentController.filterSearch.addAll(
    //                           _documentController.resultGetOption.value.data!
    //                               .where((e) => e.title
    //                               .toString().toLowerCase()
    //                               .contains(val.toLowerCase())));
    //                     },
    //                     decoration: const InputDecoration(
    //                       border: InputBorder.none,
    //                       hintText: "دانشگاه مورد نظرت رو جست و جو کن",
    //                       contentPadding: EdgeInsets.symmetric(horizontal: 5),
    //                       hintStyle:
    //                       TextStyle(color: AppColors.black, fontSize: 12),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           ButtonText(
    //             margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    //             height: 40,
    //             onPressed: () {
    //               _documentController.isManualTitleUniverCity.value = true;
    //               Get.back();
    //             },
    //             text: "سایر دانشگاه ها",
    //             bgColor: AppColors.darkerGreen,
    //             textColor: Colors.white,
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //     widget: Obx(() => _documentController.isSearch.value == true &&
    //         _documentController.filterSearch.isEmpty
    //         ? const Center(
    //       child: Padding(
    //         padding: EdgeInsets.only(top: 15, bottom: 20),
    //         child: CustomText(
    //           title: "اطلاعاتی یافت نشد",
    //           fontSize: 14,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //     )
    //         : ListView.builder(
    //         physics: ScrollPhysics(),
    //         itemCount: _documentController.isSearch.value
    //             ? _documentController.filterSearch.length
    //             : _documentController
    //             .resultGetOption.value.data!.length,
    //         shrinkWrap: true,
    //         itemBuilder: (context, index) {
    //           var uni = _documentController.isSearch.value
    //               ? _documentController.filterSearch[index]
    //               : _documentController
    //               .resultGetOption.value.data![index];
    //           return ListTile(
    //               onTap: () {
    //                 _documentController.selectedEducationImage.value =
    //                     uni.imageUrl ?? "";
    //                 _documentController.selectedEducationId.value =
    //                 uni.id!;
    //                 _documentController.selectedEducationTitle.value =
    //                 uni.title!;
    //                 _documentController.isManualTitleUniverCity.value =
    //                 false;
    //                 _manualUniController.text = "";
    //                 _searchUni.text = "";
    //                 _documentController.isSearch.value = false;
    //                 _documentController.filterSearch.clear();
    //
    //                 Get.back();
    //               },
    //               title: CustomText(
    //                 title: uni.title,
    //               ),
    //               leading: uni.imageUrl == null
    //                   ? Container(
    //                 width: 35,
    //                 height: 35,
    //                 decoration: BoxDecoration(
    //                   color: AppColors.lighterGrey,
    //                   borderRadius: BorderRadius.circular(12),
    //                   image: DecorationImage(
    //                       image: AssetImage(
    //                           "assets/images/avatar_placeholder.png"),
    //                       fit: BoxFit.fill),
    //                 ),
    //               )
    //                   : Container(
    //                 width: 35,
    //                 height: 35,
    //                 decoration: BoxDecoration(
    //                   color: AppColors.lighterGrey,
    //                   borderRadius: BorderRadius.circular(12),
    //                   image: DecorationImage(
    //                       image: NetworkImage(
    //                         uni.imageUrl,
    //                       ),
    //                       fit: BoxFit.contain),
    //                 ),
    //               ));
    //         })));
  }

}