import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSectionPanelAdmin extends StatelessWidget {
  final String title;
  final onDashbord;
  const TopSectionPanelAdmin({Key? key,required this.title,this.onDashbord}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.008),
            width: Get.width,
            height: Get.height * 0.05,
            color: Colors.indigo,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.image, color: Colors.white),
                      SizedBox(
                        width: Get.width * 0.004,
                      ),
                      const CustomText(
                          title: "پنل مدیریت بیزتاک", color: Colors.white)
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.008),
            width: Get.width,
            height: Get.height * 0.04,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
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
