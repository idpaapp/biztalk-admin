
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

Future<void> showImage(BuildContext context, String title,String image) async {
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
            size: 3,
            title: title,
            onClose: () {
              Get.back();
            }),
        content: SizedBox(
          height: Get.height * 0.7,
          width: Get.width * 0.6,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Image.network(GlobalInfo.serverAddress +"/"+image,)),
        ),

      );
    },
  );
}



