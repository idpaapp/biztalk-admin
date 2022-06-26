import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserChat extends StatelessWidget {
  final String ? message;
  final String ? image;
  final String? date;
  const UserChat({Key? key,this.message,this.date,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: image == null?  CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/images/avatar_placeholder.png")):CircleAvatar(radius: 20,backgroundImage: NetworkImage(GlobalInfo.serverAddress + "/"+image!)),
          ),
          Container(
            width: Get.width*0.12,


              decoration: const BoxDecoration(
                  color: AppColors.darkerGreen,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(15) ,topRight:Radius.circular(15)  ,bottomLeft:Radius.circular(15) )),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              margin: EdgeInsets.only(
                  left: Get.width * 0.11,
                  right: Get.width * 0.01,
                  bottom: Get.height * 0.01,
                  top: Get.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: message,
                    color: Colors.white,
                    fontSize: 12,


                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      CustomText(
                        title:date,
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),),
        ],
      ),
    );
  }
}
