import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_page.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/new_document/new_document_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewDocumentSection extends StatelessWidget {
   NewDocumentSection({Key? key}) : super(key: key){
    _homeController.newDocument();
  }
  final HomeController _homeController =Get.find();
   final SingleMentorController _singleMentorController=Get.put(SingleMentorController());

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            const NewDocumentWidget(
              isTitle: true,
              oneColumn: "نام و نام خانوادگی",
              twoColumn: "نام کاربری",

            ),
            Column(
              children: [
                Obx((){if(_homeController.failureMessageNewDocument.value !=""){
                  return Center(child: CustomText(title:_homeController.failureMessageNewDocument.value ),);
                }else if(_homeController.isLoadingNewDocument.value){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _homeController.resultNewDocument.value.data!.length,
                    itemBuilder: (context, index) {
                      var data=_homeController.resultNewDocument.value.data![index];
                      return NewDocumentWidget(
                        onTap: () async{
                          MyAlert.loding();
                         await _singleMentorController.fetchMentor(data.id!);
                          Get.back();
                          if(_singleMentorController.failureMessageFetchUser.value !=""){
                            MyAlert.mySnakbarRed(text:_singleMentorController.failureMessageFetchUser.value );
                          }else{
                            Get.to(() => DocumentPage(
                              data: _singleMentorController.resultFetchUser.value,
                              profile: _singleMentorController.resultFetchUser.value.data!.profile!,
                            ));

                          }

                        },

                        twoColumn: data.userName,
                        oneColumn: data.fullName,
                        isTitle: false,

                      );
                    },
                  );
                }}),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                //  pageSection(homeController.resultHomeUsers.value),
              ],
            )
          ],
        ),
      );
}
