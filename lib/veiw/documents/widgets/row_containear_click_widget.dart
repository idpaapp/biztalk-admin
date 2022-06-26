import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';


class RowContainerClickWidgets extends StatelessWidget {
  final onTap;
  final String? title;
  final String? imgPath;

  const RowContainerClickWidgets(
      {Key? key, this.onTap, this.title, this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.veryLightGrey),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.lighterGrey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(
                        imgPath!,
                      ),
                      fit: BoxFit.contain),

                ),

              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: CustomText(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              title: title,
            ),
          ),
          const Expanded(
            child: Center(
              child: Icon(
                Icons.expand_more,
                size: 20,
                color: AppColors.darkerGreen,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
