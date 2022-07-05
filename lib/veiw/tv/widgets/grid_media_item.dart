import 'package:biztalk_panel_admin/model/contact/all_contact_model.dart';
import 'package:biztalk_panel_admin/model/tv/all_tvs_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dialogs/edit_profile_dialog/title_text_field_widget.dart';

class GridMediaItem extends StatelessWidget {
  final TextEditingController? addressMedia;
  final String? icon;
  final String? typeMedia;
  final bool? switchBtn;
  final onChangeSwitch;
  final onChangeDropDown;
  final List<Tvs>? tvs;
  final bool isContact;
  final List<Contact>? contact;

  GridMediaItem(
      {Key? key,
      this.isContact = false,
      this.onChangeSwitch,
      this.contact,
      this.onChangeDropDown,
      this.switchBtn,
      this.tvs,
      this.addressMedia,
      this.icon,
      this.typeMedia})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
            title: "نوع رسانه",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.lighterBlack,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.dividerDark,
                ),
                color: AppColors.veryLightGrey),
            child: Row(
              children: [
                isContact
                    ? Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(height: 0),
                          value: typeMedia,
                          items: contact!.map((value) {
                            return DropdownMenuItem(
                              value: value.title,
                              child: ListTile(
                                  title: CustomText(title: value.title),
                                  leading: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            GlobalInfo.serverAddress +
                                                "/" +
                                                value.logo!,
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  )),
                            );
                          }).toList(),
                          onChanged: onChangeDropDown,
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(height: 0),
                          value: typeMedia,
                          items: tvs!.map((value) {
                            return DropdownMenuItem(
                              value: value.title,
                              child: ListTile(
                                  title: CustomText(title: value.title),
                                  leading: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              GlobalInfo.serverAddress +
                                                  "/" +
                                                  value.logo!,
                                            ),
                                            fit: BoxFit.fill)),
                                  )),
                            );
                          }).toList(),
                          onChanged: onChangeDropDown,
                        ),
                      )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TitleTextFieldWidget(
            title: "آدرس رسانه",
            editingController: addressMedia,
          ),
          const SizedBox(
            height: 20,
          ),
          isContact
              ? SizedBox(
                  height: 0,
                )
              : Row(
                  children: [
                    const CustomText(
                      title: "رسانه در قسمت مطالب آموزشی باز نشر داده شود",
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Switch(
                        value: switchBtn == false ? false : true,
                        onChanged: onChangeSwitch,
                        activeColor: AppColors.darkerGreen,
                      ),
                    ),
                  ],
                ),
        ]),
      );
}
