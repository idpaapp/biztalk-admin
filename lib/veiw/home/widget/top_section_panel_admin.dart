import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSectionPanelAdmin extends StatelessWidget {
  final String title;
  final onDashbord;
  final bool showBottom;
  final bool showLeading;
  final Widget? drawer;
  const TopSectionPanelAdmin({Key? key,required this.title,this.onDashbord,this.showBottom=true,this.showLeading=false,this.drawer }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.008),
            width: Get.width,
            height: Get.height * 0.07,
            color: Colors.indigo,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        showLeading ? drawer! :SizedBox(),
                        const CustomText(
                            title: "پنل مدیریت بیزتاک", color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white),
                        SizedBox(
                          width: Get.width * 0.004,
                        ),
                        const Icon(Icons.now_wallpaper, color: Colors.white),
                      ],
                    ),
                  ]),
            ),
          ),
        !showBottom ? SizedBox(height: 0,):  Container(
            padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
            width: Get.width,
            height: Get.height * 0.04,

            child: Row(children:  [
              InkWell(
                onTap:onDashbord,
                child: const CustomText(
                  title: "داشبورد  /  ",
                  color: Colors.indigo,
                ),
              ),
              CustomText(
                title:title ,
                color: Colors.black,
              ),
            ]),
          ),
        ],
      );
}
