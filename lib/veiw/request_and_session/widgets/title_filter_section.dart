import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class TitleFilterSection extends StatelessWidget {
  final String? title;

  const TitleFilterSection({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20,left: 10,top: 5),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(color: AppColors.lighterBlack,fontSize: 14,fontWeight: FontWeight.w500,title: title,),
                const Icon(Icons.keyboard_arrow_up_outlined,color: AppColors.black,)

              ],
            ),
      ),
      const SizedBox(height: 10,),
      Container(width: double.infinity,height: 2,color: AppColors.disabledGrey,)
    ],
  );
}
