import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerSectionWidget extends StatelessWidget {
  final int? number;
  final String? title;
  final onTap;
  final Color? bgColors;
  final Color borderColor;

  const ContainerSectionWidget(
      {Key? key, this.onTap, this.title, this.number, this.bgColors,this.borderColor =Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: Get.width*0.17,
    padding: EdgeInsets.only(right: Get.width*0.012,left: Get.width*0.004,top: Get.height*0.01,bottom:Get.height*0.01 ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(5), color: bgColors,border: Border.all(color: borderColor)),
        child: InkWell(
          onTap: onTap,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
         number == 1371 ? CustomText(
          title:" ",
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ):   CustomText(
              title: number.toString(),
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                Expanded(flex: 4,
                  child: CustomText(
                    title: title,
                    color: Colors.white,
                    fontSize: Get.width*0.01,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Expanded(

                  child: Center(
                    child: Container(

                      decoration: const BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                      width: Get.width*0.03,height: Get.height*0.03,
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward,
                        color: bgColors,
                            size: Get.width*0.015,
                      ),),
                    ),
                  ),
                )
              ],
            )
          ],),
        ),
      );
}
