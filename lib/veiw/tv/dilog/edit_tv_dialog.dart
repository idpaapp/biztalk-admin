import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_controller.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_page.dart';
import 'package:biztalk_panel_admin/veiw/tv/widgets/grid_media_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final TvController _tvController =Get.put(TvController());
final HomeController _homeController = Get.find();
Future<void> editTvDialog(BuildContext context,
    {String? title,
    String? mainId,
    String? userId,
      bool ? isCreate,
    onConfirm,
    onDelete,
    bool? switchBtn,
    String? type,
    String? imageType,
      String? mentorImage,
      String? mentorFullName,
      String? mentorJobTitle,
    String? link}) async {
  _tvController.tvTitle.value="";
  _tvController.tvId.value="";
  _tvController.tvAddress.value.text="";
  _tvController.isActiveTvSwitch.value=false;
  _tvController.tvImage.value="";

 if(isCreate  == false){
   _tvController.tvTitle.value="";
   var data = _homeController.resultAllTvs.value.data!.where((element) => element.title == type);

   _tvController.tvId.value=data.first.id!;
   _tvController.isActiveTvSwitch.value =switchBtn!;
   _tvController.tvTitle.value = type!;
   _tvController.tvImage.value =imageType!;
   _tvController.tvAddress.value.text = link!;
   print(switchBtn);
   print(_tvController.isActiveTvSwitch.value );
 }else{
   var data = _homeController.resultAllTvs.value.data!.first;
   _tvController.tvId.value=data.id!;
   _tvController.contactImage.value=data.logo!;
   _tvController.tvTitle.value =data.title!;

 }
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
            size: 4,
            title:title!,
          ),
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.35,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child:Obx(()=>GridMediaItem(
                switchBtn: _tvController.isActiveTvSwitch.value,
                addressMedia: _tvController.tvAddress.value,
                icon: _tvController.tvImage.value,
                typeMedia: _tvController.tvTitle.value,
                tvs: _homeController.resultAllTvs.value.data!,
                onChangeSwitch: (value){
                  _tvController.isActiveTvSwitch.value=value;
                },
                onChangeDropDown: (value){
                  _tvController.tvId.value="";
                  print(value);
                  _tvController.tvTitle.value=value;
                  var data = _homeController.resultAllTvs.value.data!.where((element) => element.title == value);

                  _tvController.tvId.value=data.first.id!;
                },



              ),),),
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
                  onPressed: ()async{
                    if(isCreate == true){

                      Map<String, dynamic> body = {
                        "tv": _tvController.tvId.value,
                        "userName": _tvController.tvAddress.value.text,
                        "rePublish": _tvController.isActiveTvSwitch.value
                      };
                      MyAlert.loding();
                      await _tvController.createTv(body, userId!);
                      if (_tvController.failureMessageCreateTv.value == "" &&
                          _tvController.resultCreateTv.value.ok == true) {
                        Get.back();
                        Get.back();
                        Get.offAndToNamed(TvPage.route, arguments: {
                          "image": mentorImage,
                          "fullName": mentorFullName,

                          "jobTitle": mentorJobTitle,
                          "id": userId,
                        });
                      }


                    }else {
                      Map<String, dynamic> body = {
                        "_id": mainId,
                        "tv": _tvController.tvId.value,
                        "userName": _tvController.tvAddress.value.text,
                        "rePublish": _tvController.isActiveTvSwitch.value
                      };
                      print(body);
                      MyAlert.loding();
                      await _tvController.updateTv(body, userId!);
                      if (_tvController.failureMessageUpdateTv.value == "" &&
                          _tvController.resultUpdateTv.value.ok == true) {
                        Get.back();
                        Get.back();
                        Get.offAndToNamed(TvPage.route, arguments: {
                          "image": mentorImage,
                          "fullName": mentorFullName,

                          "jobTitle": mentorJobTitle,
                          "id": userId,
                        });
                      }
                    }
                  },
                  text: "ذخیره",
                  height: 40,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.darkerGreen,
                  borderRadios: 3,

                  fontWeight: FontWeight.w500,

                  width: Get.width * 0.1,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  onPressed: () async{
                  confirmDialog(context,title: "آیا برای حذف راه ارتباطی اطمینان دارید؟",onConfirm: ()async{
                    Map<String, dynamic> body = {
                      "_id": mainId,
                    };
                    print(body);
                    MyAlert.loding();
                    await _tvController.deleteTv(body, userId!);
                    if (_tvController.failureMessageDeleteTv.value == "" &&
                        _tvController.resultDeleteTv.value.ok == true) {
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.offAndToNamed(TvPage.route, arguments: {
                        "image": mentorImage,
                        "fullName": mentorFullName,

                        "jobTitle": mentorJobTitle,
                        "id": userId,
                      });
                    }else{
                      Get.back();
                      MyAlert.mySnakbarRed(text: _tvController.failureMessageDeleteTv.value);
                    }
                  });

                  },
                  text: "حذف ",
                  height: 40,
                  fontSize: 14,
                  borderRadios: 3,

                  fontWeight: FontWeight.w500,

                  width: Get.width * 0.1,
                  textColor: Colors.white,
                  bgColor: AppColors.red,
                ),



              ],
            ),
          )
        ],
      );
    },
  );
}
