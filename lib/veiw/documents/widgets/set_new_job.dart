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

class SetNewJob{
  static setJob(BuildContext context,String mentorID,String edit,{Work? work}){
    final TextEditingController _manualTitleOfOrgan = TextEditingController();
    final TextEditingController _positionTitle = TextEditingController();
    final TextEditingController _firstYear = TextEditingController();
    final TextEditingController _lastYear = TextEditingController();
    if(edit == "edit"){
      _positionTitle.text = work!.job!;
      _firstYear.text = work.startYear!;
      _lastYear.text = work.endYear!;
      _documentController.isActiveJobSwitch.value = work.currentPosition!;


      if (work.company!.type == "other") {
        _documentController.activeSetNameOrgan.value = true;
        _manualTitleOfOrgan.text = work.companyTitle!;
      } else {
        _documentController.activeSetNameOrgan.value = false;

        _documentController.companyId.value = work.company!.id!;
        _documentController.companyIcon.value = work.company!.imageUrl!;
        _documentController.companyName.value = work.company!.title!;
      }

    }else{
      _positionTitle.text="";
      _firstYear.text="";
      _lastYear.text="";
      _documentController.isActiveJobSwitch.value=false;
      _documentController.activeSetNameOrgan.value = false;
      _manualTitleOfOrgan.text="";
      _documentController.companyId.value = "";
      _documentController.companyIcon.value ="";
      _documentController.companyName.value = "";

    }



    DocumentDialog(context,title: "سوابق شغلی",onSave: () async{

      Map<String, dynamic> body = {
        "job": _positionTitle.text,
        "startYear": _firstYear.text,
        "endYear": _lastYear.text,
        "currentPosition": _documentController.isActiveJobSwitch.value
      };

      if (_documentController.activeSetNameOrgan.value) {
        body['companyTitle'] = _manualTitleOfOrgan.text;
      } else {
        body['company'] = _documentController.companyId.value;
        body['companyTitle'] = _documentController.companyName.value;
      }

      if(edit == "edit"){
        print(body);

        MyAlert.loding();
        await _documentController.editJob(body, mentorID,work!.id!);
        Get.back();
        if (_documentController.failureMessageEditJob
            .value != "") {
          MyAlert.mySnakbarRed(text: _documentController
              .failureMessageEditJob.value);
        } else {
          _documentController.getDocument(mentorID);
          Get.back();
        }


      }else {
        MyAlert.loding();
        await _documentController.createJob(body, mentorID);
        Get.back();
        if (_documentController.failureMessageCreateJob
            .value != "") {
          MyAlert.mySnakbarRed(text: _documentController
              .failureMessageCreateJob.value);
        } else {
          _documentController.getDocument(mentorID);
          Get.back();
        }
      }



    },content: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: "نام سازمان",
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(() => RowContainerClickWidgets(
              title: _documentController.companyName.value,
              imgPath: _documentController.companyIcon.value == ""
                  ? ""
                  : _documentController.companyIcon.value,
              onTap: () async {
                MyAlert.loding();
                await _documentController.getOption("company");
                if (_documentController.failureMessageGetOption.value != "") {
                  Get.back();
                  MyAlert.mySnakbarRed(
                      text: _documentController.failureMessageGetOption.value);
                  return;
                } else  {
                  Get.back();
                  setNewJob(context);
                }
              },
            )),
            Obx(() => _documentController.activeSetNameOrgan.value
                ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextfieldTitleWidgets(
                textEditingController: _manualTitleOfOrgan,
                title: "عنوان سازمان",
                hint: _documentController.activeSetNameOrgan.value == true
                    ? "سایر شرکت ها یا سازمان ها"
                    : _documentController.companyName.value,
              ),
            )
                : const SizedBox(
              height: 0,
            )),
            const SizedBox(
              height: 12,
            ),
            TextfieldTitleWidgets(
              textEditingController: _positionTitle,
              title: "سمت و موقعیت شغلی",
              hint: "سمت شغلی",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: "سال شروع و پایان فعالیت",
                  color: AppColors.black,
                  fontWeight:
                  Get.height < 700 ? FontWeight.w400 : FontWeight.bold,
                  fontSize: Get.height < 700 ? 10 : 12,
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
                      title: "هم اکنون مشغول به کارهستم",
                      color: AppColors.black,
                      fontSize: Get.height < 700 ? 10 : 12,
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
                    child: Obx(
                          () => TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _documentController.isActiveJobSwitch.value
                                ? AppColors.darkGrey
                                : AppColors.black),
                        controller: _lastYear,
                        keyboardType: TextInputType.number,
                        enabled:
                        _documentController.isActiveJobSwitch.value ? false : true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "سال پایان",
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 5),
                          hintStyle: TextStyle(
                              color: _documentController.isActiveJobSwitch.value
                                  ? AppColors.darkGrey
                                  : AppColors.black,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),

          ],
        ),
      ),

    ) );




    // CustomBottomSheet.myBottomSheet(
    //   // height: 700,
    //   title: "سوابق شغلی",
    //   widget: ConstrainedBox(
    //     constraints: BoxConstraints(maxWidth: 1000.0),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const CustomText(
    //             title: "نام سازمان",
    //             color: AppColors.black,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 12,
    //           ),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //           Obx(() => RowContainerClickWidgets(
    //             title: _documentController.companyName.value,
    //             imgPath: _documentController.companyIcon.value == ""
    //                 ? ""
    //                 : _documentController.companyIcon.value,
    //             onTap: () async {
    //               MyAlert.loding();
    //               await _documentController.getOption("company");
    //               if (_documentController.failureMessageGetOption.value != "") {
    //                 Get.back();
    //                 MyAlert.mySnakbarRed(
    //                     text: _documentController.failureMessageGetOption.value);
    //                 return;
    //               } else  {
    //                 Get.back();
    //                 setNewJob();
    //               }
    //             },
    //           )),
    //           Obx(() => _documentController.activeSetNameOrgan.value
    //               ? Padding(
    //             padding: const EdgeInsets.only(top: 10),
    //             child: TextfieldTitleWidgets(
    //               textEditingController: _manualTitleOfOrgan,
    //               title: "عنوان سازمان",
    //               hint: _documentController.activeSetNameOrgan.value == true
    //                   ? "سایر شرکت ها یا سازمان ها"
    //                   : _documentController.companyName.value,
    //             ),
    //           )
    //               : const SizedBox(
    //             height: 0,
    //           )),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //           TextfieldTitleWidgets(
    //             textEditingController: _positionTitle,
    //             title: "سمت و موقعیت شغلی",
    //             hint: "سمت شغلی",
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               CustomText(
    //                 title: "سال شروع و پایان فعالیت",
    //                 color: AppColors.black,
    //                 fontWeight:
    //                 Get.height < 700 ? FontWeight.w400 : FontWeight.bold,
    //                 fontSize: Get.height < 700 ? 10 : 12,
    //               ),
    //               Row(
    //                 children: [
    //                   Obx(
    //                         () => Directionality(
    //                       textDirection: TextDirection.ltr,
    //                       child: Switch(
    //                         value: _documentController.isActiveJobSwitch.value,
    //                         onChanged: (bool value) {
    //                           _documentController.isActiveJobSwitch.value = value;
    //                           if (value == true) {
    //                             _lastYear.text = currentYear();
    //                           } else {
    //                             _lastYear.text = "";
    //                           }
    //                         },
    //                         activeColor: AppColors.darkerGreen,
    //                       ),
    //                     ),
    //                   ),
    //                   CustomText(
    //                     title: "هم اکنون مشغول به کارهستم",
    //                     color: AppColors.black,
    //                     fontSize: Get.height < 700 ? 10 : 12,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                 height: 50,
    //                 width: Get.width * 0.3,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(12),
    //                     color: AppColors.veryLightGrey),
    //                 child: TextField(
    //                   controller: _firstYear,
    //                   textAlign: TextAlign.center,
    //                   keyboardType: TextInputType.number,
    //                   decoration: const InputDecoration(
    //                     border: InputBorder.none,
    //                     hintText: "سال شروع",
    //                     contentPadding: EdgeInsets.symmetric(horizontal: 5),
    //                     hintStyle:
    //                     TextStyle(color: AppColors.black, fontSize: 12),
    //                   ),
    //                 ),
    //               ),
    //               const CustomText(
    //                 title: "تا",
    //               ),
    //               Container(
    //                 height: 50,
    //                 width: Get.width * 0.3,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(12),
    //                     color: AppColors.veryLightGrey),
    //                 child: Obx(
    //                       () => TextField(
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         color: _documentController.isActiveJobSwitch.value
    //                             ? AppColors.darkGrey
    //                             : AppColors.black),
    //                     controller: _lastYear,
    //                     keyboardType: TextInputType.number,
    //                     enabled:
    //                     _documentController.isActiveJobSwitch.value ? false : true,
    //                     decoration: InputDecoration(
    //                       border: InputBorder.none,
    //                       hintText: "سال پایان",
    //                       contentPadding:
    //                       const EdgeInsets.symmetric(horizontal: 5),
    //                       hintStyle: TextStyle(
    //                           color: _documentController.isActiveJobSwitch.value
    //                               ? AppColors.darkGrey
    //                               : AppColors.black,
    //                           fontSize: 12),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //
    //
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 14),
    //             child: Row(
    //               children: [
    //                 ButtonText(
    //                   onPressed: ()async {
    //
    //                     Map<String, dynamic> body = {
    //                       "job": _positionTitle.text,
    //                       "startYear": _firstYear.text,
    //                       "endYear": _lastYear.text,
    //                       "currentPosition": _documentController.isActiveJobSwitch.value
    //                     };
    //
    //                     if (_documentController.activeSetNameOrgan.value) {
    //                       body['companyTitle'] = _manualTitleOfOrgan.text;
    //                     } else {
    //                       body['company'] = _documentController.companyId.value;
    //                       body['companyTitle'] = _documentController.companyName.value;
    //                     }
    //
    //                     if(edit == "edit"){
    //                       print(body);
    //
    //                       MyAlert.loding();
    //                       await _documentController.editJob(body, mentorID,work!.id!);
    //                       Get.back();
    //                       if (_documentController.failureMessageEditJob
    //                           .value != "") {
    //                         MyAlert.mySnakbarRed(text: _documentController
    //                             .failureMessageEditJob.value);
    //                       } else {
    //                         _documentController.getDocument(mentorID);
    //                         Get.back();
    //                       }
    //
    //
    //                     }else {
    //                       MyAlert.loding();
    //                       await _documentController.createJob(body, mentorID);
    //                       Get.back();
    //                       if (_documentController.failureMessageCreateJob
    //                           .value != "") {
    //                         MyAlert.mySnakbarRed(text: _documentController
    //                             .failureMessageCreateJob.value);
    //                       } else {
    //                         _documentController.getDocument(mentorID);
    //                         Get.back();
    //                       }
    //                     }
    //
    //                   },
    //                   text:edit == "edit" ? "ویرایش": "افزودن",
    //                   height: 35,
    //                   fontSize: 14,
    //                   width: 110,
    //                   textColor: Colors.white,
    //                   bgColor: AppColors.darkerGreen,
    //                 ),
    //                 SizedBox(width: 15,),
    //               edit =="edit"?  ButtonText(
    //                   onPressed: ()async {
    //                     MyAlert.deleteBottomSheet(text: "آیا برای حذف اطمینان دارید؟",onCancel: (){
    //                       Get.back();
    //                     },title: "توجه",onConfirm: ()async{
    //                       MyAlert.loding();
    //                       await _documentController.deleteJob(mentorID,work!.id!);
    //                       Get.back();
    //                       if(_documentController.failureMessageDeleteJob.value !=""){
    //                         MyAlert.mySnakbarRed(text: _documentController.failureMessageDeleteJob.value);
    //                       }else{
    //                         Get.back();
    //                         Get.back();
    //                         _documentController.getDocument(mentorID);
    //
    //                       }
    //                     });
    //
    //
    //
    //                   },
    //                   text:"حذف",
    //                   height: 35,
    //                   fontSize: 14,
    //                   width: 110,
    //                   textColor: Colors.white,
    //                   bgColor: AppColors.red,
    //                 )
    //                   :SizedBox(height: 0,)
    //
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );


  }
  static void setNewJob(BuildContext context) {
    final TextEditingController _jobSearch = TextEditingController();

    _documentController.isSearch.value = false;
    _documentController.filterSearch.clear();

     DocumentDialog(context,title: "لیست سازمان ها",activeBTN: true,content: SingleChildScrollView(
       child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

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
                         controller: _jobSearch,
                         onChanged: (val) {
                           if (val.length > 0) {
                             _documentController.isSearch.value = true;
                             _documentController.filterSearch.clear();
                           } else {
                             _documentController.filterSearch.clear();
                             _documentController.isSearch.value = false;
                           }

                           _documentController.filterSearch.addAll(_documentController
                               .resultGetOption.value.data!
                               .where((e) => e.title
                               .toString()
                               .toLowerCase()
                               .contains(val.toLowerCase())));
                         },
                         decoration: const InputDecoration(
                           border: InputBorder.none,
                           hintText: "جست وجو",
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
                   _documentController.activeSetNameOrgan.value = true;
                   _documentController.companyName.value = "سایر";
                   _documentController.companyId = "".obs;
                   _documentController.companyIcon = "".obs;
                   Get.back();
                 },
                 text: "سایر شرکت ها یا سازمان ها",
                 bgColor: AppColors.darkerGreen,
                 textColor: Colors.white,
               ),
             ],
           ),
         ),
         SizedBox(height: 25,),
         Obx(
               () => _documentController.isSearch.value == true &&
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
               : Column(
                 children: [
                   ListView.builder(

                   physics: ScrollPhysics(),
                   itemCount: _documentController.isSearch.value
                       ? _documentController.filterSearch.length
                       : _documentController.resultGetOption.value.data!.length,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     var data = _documentController.isSearch.value
                         ? _documentController.filterSearch[index]
                         : _documentController.resultGetOption.value.data![index];
                     return ListTile(
                       onTap: () {
                         _documentController.companyId.value = data.id.toString();
                         _documentController.companyName.value = data.title.toString();
                         _documentController.companyIcon.value =
                             data.imageUrl.toString();
                         _documentController.activeSetNameOrgan.value = false;
                         _jobSearch.text = "";
                         _documentController.isSearch.value = false;
                         _documentController.filterSearch.clear();
                         Get.back();
                       },
                       title: CustomText(
                         title: data.title,
                       ),
                       leading: Container(
                         width: 35,
                         height: 35,
                         decoration: BoxDecoration(
                           color: AppColors.lighterGrey,
                           borderRadius: BorderRadius.circular(12),
                           image: DecorationImage(
                               image: NetworkImage(
                                 data.imageUrl!,
                               ),
                               fit: BoxFit.contain),
                         ),
                       ),
                     );
                   }),
                 ],
               ),
         ),
       ]),
     ));

    // CustomBottomSheet.widgetBottomSheet(
    //   height: Get.height * 0.8,
    //   titleWidget: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    //     child: Column(
    //       children: [
    //         Container(
    //           height: 50,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               color: AppColors.veryLightGrey),
    //           child: Row(
    //             children: [
    //               const Expanded(child: Icon(Icons.search)),
    //               Expanded(
    //                 flex: 9,
    //                 child: TextField(
    //                   controller: _jobSearch,
    //                   onChanged: (val) {
    //                     if (val.length > 0) {
    //                       _documentController.isSearch.value = true;
    //                       _documentController.filterSearch.clear();
    //                     } else {
    //                       _documentController.filterSearch.clear();
    //                       _documentController.isSearch.value = false;
    //                     }
    //
    //                     _documentController.filterSearch.addAll(_documentController
    //                         .resultGetOption.value.data!
    //                         .where((e) => e.title
    //                         .toString()
    //                         .toLowerCase()
    //                         .contains(val.toLowerCase())));
    //                   },
    //                   decoration: const InputDecoration(
    //                     border: InputBorder.none,
    //                     hintText: "جست وجو",
    //                     contentPadding: EdgeInsets.symmetric(horizontal: 5),
    //                     hintStyle:
    //                     TextStyle(color: AppColors.black, fontSize: 12),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         ButtonText(
    //           margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    //           height: 40,
    //           onPressed: () {
    //             _documentController.activeSetNameOrgan.value = true;
    //             _documentController.companyName.value = "سایر";
    //             _documentController.companyId = "".obs;
    //             _documentController.companyIcon = "".obs;
    //             Get.back();
    //           },
    //           text: "سایر شرکت ها یا سازمان ها",
    //           bgColor: AppColors.darkerGreen,
    //           textColor: Colors.white,
    //         ),
    //       ],
    //     ),
    //   ),
    //   widget: Obx(
    //         () => _documentController.isSearch.value == true &&
    //             _documentController.filterSearch.isEmpty
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
    //             : _documentController.resultGetOption.value.data!.length,
    //         shrinkWrap: true,
    //         itemBuilder: (context, index) {
    //           var data = _documentController.isSearch.value
    //               ? _documentController.filterSearch[index]
    //               : _documentController.resultGetOption.value.data![index];
    //           return ListTile(
    //             onTap: () {
    //               _documentController.companyId.value = data.id.toString();
    //               _documentController.companyName.value = data.title.toString();
    //               _documentController.companyIcon.value =
    //                   data.imageUrl.toString();
    //               _documentController.activeSetNameOrgan.value = false;
    //               _jobSearch.text = "";
    //               _documentController.isSearch.value = false;
    //               _documentController.filterSearch.clear();
    //               Get.back();
    //             },
    //             title: CustomText(
    //               title: data.title,
    //             ),
    //             leading: Container(
    //               width: 35,
    //               height: 35,
    //               decoration: BoxDecoration(
    //                 color: AppColors.lighterGrey,
    //                 borderRadius: BorderRadius.circular(12),
    //                 image: DecorationImage(
    //                     image: NetworkImage(
    //                       data.imageUrl!,
    //                     ),
    //                     fit: BoxFit.contain),
    //               ),
    //             ),
    //           );
    //         }),
    //   ),
    // );
  }

}