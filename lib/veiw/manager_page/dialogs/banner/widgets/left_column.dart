
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/widgets/row_widget_switch.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeftColumnBanner extends StatelessWidget {
  final onSelectedImage;
  final TextEditingController? titleList;
  final TextEditingController? link;
  final ManagerPageController _managerPageController = Get.find();

  LeftColumnBanner({Key? key, this.onSelectedImage, this.titleList, this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(()=>RowSwitchWidget(
            title: _managerPageController.titleSwitch.value,
            activeSwitch: _managerPageController.switchActive.value,
            onChangeSwitch: (val) {
              _managerPageController.switchActive.value = val;
              if (val == true) {
                _managerPageController.titleSwitch.value = "فعال";
              } else {
                _managerPageController.titleSwitch.value = "غیر فعال";
              }
            },
          ),),
          const SizedBox(height: 15,),
         Obx(()=> !_managerPageController.isLink.value?TitleTextFieldWidget(
           title: "عنوان لیست",
           editingController: titleList,
           hint: "عنوان لیست",
         ):const SizedBox(),),

          const SizedBox(height: 15,),
          Obx(()=>_managerPageController.isLink.value?TitleTextFieldWidget(
            title: "لینک بنر",
            editingController: link,
            hint: "لینک بنر",
          ):TitleTextFieldWidget(
            title: "شرح لیست",
            editingController: link,
            maxLines: 3,
            hint: "شرح لیست",
          ),)
        ],
      );
}
