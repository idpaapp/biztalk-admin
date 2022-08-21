import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AllMethods{
 static Color handelTextColor(String data,bool status) {
   print(data);
   if (data == "DOC_NOT_SEND" && status) {
     return AppColors.pink;
   } else if (data == "DOC_CONFIRM" && status) {
     return AppColors.greenBg;
   } else if (data == "CONFIRM" && status) {
     return AppColors.pink;
   } else if (data == "DOC_CHECKING" && status) {
     return AppColors.blueSession;
   } else if (data == "DOC_NOT_CONFIRM" && status) {
     return AppColors.orange;
   } else if (data == "DOC_NOT_CONFIRM" && !status) {
     return AppColors.redBg;
   }  else {
     return AppColors.lighterBlack;
   }
  }

 static Color handelBackColor(String data,bool status) {
   print(data);
    if (data == "DOC_NOT_SEND" && status) {
      return AppColors.pink.withOpacity(0.15);
    } else if (data == "DOC_CONFIRM" && status) {
      return AppColors.greenBg.withOpacity(0.15);
    } else if (data == "CONFIRM" && status) {
      return AppColors.pink.withOpacity(0.15);
    } else if (data == "DOC_CHECKING" && status) {
      return AppColors.blueSession.withOpacity(0.15);
    } else if (data == "DOC_NOT_CONFIRM" && !status) {
      return AppColors.redBg.withOpacity(0.15);
    } else if (data == "DOC_NOT_CONFIRM" && status) {
      return AppColors.orange.withOpacity(0.15);
    }  else {
      return AppColors.lighterBlack.withOpacity(0.15);
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