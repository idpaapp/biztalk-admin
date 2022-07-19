import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'credit_card_formatter.dart';
import 'custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final int? isSuffix;
  final EdgeInsets? margin;
  final bool? isEnabled;
  final int? cardFormatter;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final bool? activeBorder;
  final int? multiLine;
  final bool? isLeftToRight;
  final Function(String)? onChange;

  const CustomTextField(
      {Key? key,
        this.hint,
        this.isLeftToRight = false,
        this.multiLine = 1,
        this.activeBorder = false,
        this.onChange,
        this.controller,
        this.isSuffix,
        this.margin,
        this.textAlign = TextAlign.right,
        this.isEnabled = true,
        this.cardFormatter,
        this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: TextField(
        maxLines: multiLine,
        autofocus: false,

        enabled: isEnabled,
        onChanged: onChange,
        keyboardType: isSuffix == 1 ? textInputType : TextInputType.number,
        inputFormatters: cardFormatter == 1
            ? [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyPtBrInputFormatter()
        ]
            : null,
        controller: controller,
        textAlign: textAlign!,
        decoration: InputDecoration(
          border: activeBorder == true ? InputBorder.none : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          suffixIcon: isSuffix == 1
              ? null
              : Padding(
            padding: EdgeInsets.only(
                right: 15, top: size.height * 0.01),
            child: const CustomText(
              title: "تومان",
              fontSize: 13,
              color: AppColors.darkGrey,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.darkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
