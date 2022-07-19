import 'package:flutter/material.dart';
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
  final bool isIcon;
  final IconData? iconData;
  final Color? iconColor;
  final Color borderColor;

  const ButtonText(
      {Key? key,
      @required this.onPressed,
      required this.text,
      this.borderRadios = 6,
      this.padding,
      this.fontWeight = FontWeight.bold,
      this.width,
      this.fontSize = 14,
      this.activeBorder,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.height,
        this.iconColor,
      this.iconData,
        this.borderColor=Colors.black,
      this.isIcon = false,
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
                ? Border.all(
                    color:borderColor,
                    width: 1)
                : null),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:isIcon? 0: 12),
            child: isIcon ? Center(child: Icon(iconData,color: iconColor,size: 18,)):CustomText(
                title: text,
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
