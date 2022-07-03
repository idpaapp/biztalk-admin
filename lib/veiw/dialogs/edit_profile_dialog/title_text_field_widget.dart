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
  final onConfirm;
  final onDelete;
  final bool activeDelete;

  const TitleTextFieldWidget(
      {Key? key, this.title, this.hint, this.editingController,this.maxLines=null,this.pre,this.textInputType,this.format=false,this.onDelete,this.onConfirm,this.activeDelete =false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CustomText(
                  color: AppColors.lighterBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  title: title,
                ),
              ),
            !activeDelete ? SizedBox():  DeleteAcceptWidget(
                onConfirm:onConfirm,onDelete: onDelete,


              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //height: Get.height*0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.dividerDark,
                ),
                color: AppColors.veryLightGrey),
            child: Center(
              child: TextField(
                keyboardType: textInputType,
                maxLines: maxLines !=null ?maxLines:null,
                inputFormatters:format ? [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ]:null,

                controller: editingController,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: hint,prefixIcon: pre,),
              ),
            ),
          )
        ],
      );
}
class TitleTextWidget extends StatelessWidget {
  final String? title;
  final String? hint;

  const TitleTextWidget(
      {Key? key, this.title, this.hint,})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomText(
              color: AppColors.lighterBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              title: title,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: Get.height*0.06,
            margin: EdgeInsets.only(right: 8),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.dividerDark,
                ),
                color: AppColors.veryLightGrey),
            child: CustomText(title: hint,fontSize: 14,fontWeight: FontWeight.w700),
          )
        ],
      );
}
