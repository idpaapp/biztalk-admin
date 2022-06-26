import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class RowSwitchWidget extends StatelessWidget {
  final String? title;
  final bool? activeSwitch;
  final onChangeSwitch;

  const RowSwitchWidget(
      {Key? key, this.onChangeSwitch, this.activeSwitch, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyFill),
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 4,
              child: CustomText(
                title: title,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Switch(
                    onChanged: onChangeSwitch,
                    value: activeSwitch == true ? true : false,
                    activeColor: AppColors.blueBg,
                  ),
                ),
              ),
            )
          ],),
        ),
      );
}
