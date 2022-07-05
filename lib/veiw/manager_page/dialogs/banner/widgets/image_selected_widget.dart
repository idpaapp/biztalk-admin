import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSelectedWidget extends StatelessWidget {
  final onTap;
  final String title;
  final IconData iconData;
  final String? imgPath;

  const ImageSelectedWidget(
      {Key? key,
      this.onTap,
      this.title = "افزودن بنر",
      this.iconData = Icons.attachment,
      this.imgPath,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.17,
      decoration: DottedDecoration(
        color: AppColors.darkGrey,
        shape: Shape.box,
        borderRadius: BorderRadius.circular(10),
      ),
      child: imgPath !=""
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(imgPath!), fit: BoxFit.fill)),
            )
          : InkWell(
              onTap: onTap,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      color: Colors.black,
                      size: 30,
                    ),
                    CustomText(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      title: title,
                    )
                  ]),
            ),
    );
  }
}
