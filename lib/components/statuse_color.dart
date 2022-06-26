import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CheckColor {
  static Color handelStatuseColors(String state) {

    if (state == 'draft') {
      return AppColors.darkGrey;
    } else if (state == "patience" || state == "in_progress") {
      return AppColors.orange;
    } else if (state == "confirmed" || state == "reserved") {
      return AppColors.darkerGreen;
    } else if (state == "completed") {
      return AppColors.blue;
    } else {
      return AppColors.red;
    }
  }
}
