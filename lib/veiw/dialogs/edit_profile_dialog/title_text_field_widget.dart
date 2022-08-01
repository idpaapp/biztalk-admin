import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/credit_card_formatter.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/delete_accept_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TitleTextFieldWidget extends StatelessWidget {
  final String? title;
  final String? hint;
  final int? maxLines;
  final Widget? pre;
  final TextInputType? textInputType;
  final TextEditingController? editingController;
  final bool format;
  final bool enabled;
  final onConfirm;
  final onDelete;
  final bool activeDelete;

  const TitleTextFieldWidget(
      {Key? key,
      this.title,
        this.enabled =true,
      this.hint,
      this.editingController,
      this.maxLines,
      this.pre,
      this.textInputType,
      this.format = false,
      this.onDelete,
      this.onConfirm,
      this.activeDelete = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                color: AppColors.greyMiddle,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                title: title,
              ),
              !activeDelete
                  ? const SizedBox()
                  : DeleteAcceptWidget(

                      onConfirm: onConfirm,
                      onDelete: onDelete,
                    ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            //height: Get.height*0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.borderColor,
                ),
                color: Colors.white),
            child: Center(
              child: TextField(
                enabled: enabled,
                keyboardType: textInputType,
                maxLines: maxLines,
                inputFormatters: format
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter()
                      ]
                    : null,
                controller: editingController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    prefixIcon: pre,
                    hintStyle: const TextStyle(color: AppColors.borderColor),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10)),
              ),
            ),
          )
        ],
      );
}

class TitleTextWidget extends StatelessWidget {
  final String? title;
  final String? hint;
  final Color bgColor;
  final Color textColor;
  final Color titleColor;
  final Color borderColor;

  const TitleTextWidget({
    Key? key,
    this.title,
    this.hint,
    this.textColor=AppColors.lighterBlack,
    this.titleColor=AppColors.lighterBlack,
    this.bgColor=AppColors.veryLightGrey,
    this.borderColor=AppColors.dividerDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            color: titleColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            title: title,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: Get.height * 0.06,
            padding: const EdgeInsets.only(right: 8),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: borderColor,
                ),
                color: bgColor),
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                color: textColor,
                  title: hint, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          )
        ],
      );
}
