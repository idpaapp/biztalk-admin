import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AllMethods{
 static Color handelTextColor(String data) {
    if (data == "DOC_NOT_SEND") {
      return AppColors.darkGrey;
    } else if (data == "DOC_CONFIRM") {
      return AppColors.darkerGreen;
    } else if (data == "DOC_CHECKING") {
      return Colors.white;
    } else {
      return AppColors.redText;
    }
  }

 static Color handelBackColor(String data,bool status) {
   print(data);
    if (data == "DOC_NOT_SEND" && status) {
      return AppColors.pink;
    } else if (data == "DOC_CONFIRM" && status) {
      return AppColors.veryLightGreen;
    } else if (data == "DOC_CHECKING" && status) {
      return AppColors.blueSession;
    } else if (data == "CHECKING" && status) {
      return AppColors.orange;
    } else if (data == "DOC_NOT_CONFIRM" && !status) {
      return AppColors.redBg;
    }  else {
      return AppColors.disabledGrey;
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