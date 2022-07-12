import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';

class TitleRowInTableWidget extends StatelessWidget {
  final String? mainUserName;
  final String? userType;
  final String? userName;
  final String? phoneNumber;
  final String? image;
  final bool? isTitle;
  final Color bgColor;
  final onTap;

  const TitleRowInTableWidget(
      {Key? key,
      this.onTap,
        this.bgColor=Colors.white,
      this.userName,
      this.userType,
      this.mainUserName,
      this.phoneNumber,
      this.image,
      this.isTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            bottom: BorderSide(
                color: isTitle == true
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: isTitle == true
                      ? Container()
                      : image == ""
                          ? const Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(

                                      "assets/images/avatar_placeholder.png")),
                            )
                          : Center(
                              child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(GlobalInfo.serverAddress +"/"+ image!)),
                            )),
              Expanded(
                flex: 2,
                child: CustomText(
                    fontSize: isTitle == true ? 16 : 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    title: mainUserName),
              ),
              Expanded(
                  flex: 2,
                  child: CustomText(
                      fontSize: isTitle == true ? 16 : 14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      title: userType)),
              Expanded(
                  flex: 2,
                  child: CustomText(
                      fontSize: isTitle == true ? 16 : 14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      title: userName)),
              Expanded(
                  flex: 2,
                  child: CustomText(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      title: phoneNumber)),
              Expanded(
                  flex: 2,
                  child: isTitle == true
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(onTap: onTap,child: Icon(Icons.more_horiz,color: AppColors.lighterBlack,size: 25),)
                          ],
                        )),
            ],
          ),
        ),
      );
}
