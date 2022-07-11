import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AllMethods{
 static Color handelTextColor(String data) {
    if (data == "DOC_NOT_SEND") {
      return AppColors.darkGrey;
    } else if (data == "DOC_CONFIRM") {
      return AppColors.darkerGreen;
    } else if (data == "DOC_CHECKING") {
      return AppColors.blueSession;
    } else {
      return AppColors.redText;
    }
  }

 static Color handelBackColor(String data) {
    if (data == "DOC_NOT_SEND") {
      return AppColors.disabledGrey;
    } else if (data == "DOC_CONFIRM") {
      return AppColors.veryLightGreen;
    } else if (data == "DOC_CHECKING") {
      return AppColors.blueSession;
    } else {
      return AppColors.redBg;
    }
  }
}