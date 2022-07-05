import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileTitleTableWidget extends StatelessWidget {
  final String? subject;
  final String? createDate;
  final String? userName;
  final String? stateTitle;
  final String? state;
  final String? sessionDate;
  final bool isTitle;
  final onTap;

  const ProfileTitleTableWidget(
      {Key? key,
      this.onTap,
      this.userName,
      this.createDate,
      this.subject,
      this.stateTitle,
      this.state,
      this.isTitle = false,
      this.sessionDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 40),
        decoration: BoxDecoration(
          color: isTitle == true ? AppColors.blueSession : Colors.white,
          borderRadius: isTitle
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: isTitle == true ? Colors.white : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: subject),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: isTitle == true ? Colors.white : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: createDate),
            ),
            Expanded(
              flex: 2,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: isTitle == true ? Colors.white : AppColors.columnText,
                  fontWeight: FontWeight.w500,
                  title: userName),
            ),
            Expanded(
              flex: 2,
              child: isTitle ? CustomText(
                  fontSize:16 ,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  title: stateTitle):
                              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:AppColors.bgBlue
                              ),

                      child: CustomText(
                          fontSize:  12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          title: stateTitle)
                         ),
                ],
              ),

            ),
            Expanded(
              flex: 1,
              child: CustomText(
                  fontSize: isTitle == true ? 16 : 14,
                  color: isTitle == true ? Colors.white : AppColors.black,
                  fontWeight: FontWeight.w500,
                  title: sessionDate),
            ),
          ],
        ),
      );
}
