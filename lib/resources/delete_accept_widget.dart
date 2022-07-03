import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:flutter/material.dart';






class DeleteAcceptWidget extends StatelessWidget {
  final onDelete;
  final onConfirm;
  const DeleteAcceptWidget({Key? key,this.onConfirm,this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ButtonText(
        activeBorder: 1,
        borderColor: AppColors.green,
        isIcon: true,
        iconColor: AppColors.green,
        iconData: Icons.check,
        onPressed: onConfirm,
        text: "حذف تصویر",

        width: 35,
        height: 25,
        fontSize: 14,
        textColor: Colors.white,
        bgColor: Colors.white,
      ),
      const SizedBox(
        width: 10,
      ),
      ButtonText(
        isIcon: true,
        iconColor: AppColors.red,
        iconData: Icons.clear,
        onPressed: onDelete,
        text: "حذف تصویر",
        height: 25,
        width: 35,
        fontSize: 14,
        textColor: Colors.white,
        bgColor: Colors.white,
        activeBorder: 1,
        borderColor: AppColors.red,
      ),


    ],
  );
}
