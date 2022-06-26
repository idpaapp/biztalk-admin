import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldsCustomWidget extends StatelessWidget {
  final onTap;
  final String btnTitle;
  final double? height;
  final int flex;
  final TextEditingController? searchController;
   const TextFieldsCustomWidget({Key? key,this.onTap,this.searchController,this.btnTitle = "مشاهده اطلاعات",this.height,this.flex =2}) : super(key: key);

  @override
  Widget build(BuildContext context) =>Row(
    children: [
      Expanded(
        flex: 14,
        child: Container(

          height:height??Get.height*0.06 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greyBorder),
          ),
          child:  Center(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "جستجو",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.001,
      ),
      Expanded(
        flex: flex ,
        child: Center(
          child: ButtonText(
            onPressed:onTap,
            text:btnTitle,
            bgColor: AppColors.blueIndigo,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            textColor: Colors.white,
            width: Get.width*0.1,
            height: height ??Get.height*0.06,
          ),
        ),
      ),
    ],
  );
}
