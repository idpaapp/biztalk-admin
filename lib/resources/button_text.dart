import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'custom_text.dart';

class ButtonText extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String? text;
  final EdgeInsets? margin;
  final Color? bgColor;
  final Color? textColor;
  final int? activeBorder;
  final double? fontSize;
  final double? borderRadios;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final int? borderColor;

  const ButtonText(
      {Key? key,
      @required this.onPressed,
      required this.text,
        this.borderRadios=6,
        this.padding,
        this.fontWeight =FontWeight.bold,
      this.width ,
        this.borderColor,
      this.fontSize = 14,
      this.activeBorder,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.height ,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadios!),
            border: activeBorder == 1
                ? Border.all(color: borderColor == 2 ?AppColors.tosi :AppColors.greyBorder,width: 1)
                : null),
        child: Center(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomText(
                title: text,
                color: textColor,
                fontSize: fontSize,
                fontWeight:fontWeight ),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
