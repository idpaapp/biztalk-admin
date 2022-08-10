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
  static String datePiker(String date ){
   var current=date.split("/");
   String year =current[0];
   String mounth =current[1];
   String dey =current[2];

   if(int.parse(current[1]) < 10){
     mounth="0"+mounth;

   }
   if(int.parse(current[2]) <10){
     dey ="0" +dey;
   }
   String finallyDate=year +"/"+mounth+"/"+dey;
   print(finallyDate);
   return finallyDate;
  }
}