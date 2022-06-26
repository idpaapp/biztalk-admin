import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_text.dart';

class ButtonRow extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String? text;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final Color? textColor;
  final int? activeBorder;
  final double? fontSize;
  final Color? iconColor;
  final Color? svgColor;
  final Color borderColor;
  final IconData? icon;
  final String? assetIcon;
  final double? circular;

  const ButtonRow(
      {Key? key,
        this.iconColor = Colors.white,
        @required this.onPressed,
        this.assetIcon,
        this.borderColor = Colors.white,
        this.icon,
        this.circular = 8,
        required this.text,
        this.svgColor = Colors.white,
        this.width,
        this.fontSize = 14,
        this.activeBorder,
        this.bgColor = Colors.yellow,
        this.textColor = Colors.black,
        this.height = 60,
        this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(circular!),
            border: activeBorder == 1 ? Border.all(color: borderColor) : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              assetIcon != null
                  ? SvgPicture.asset(
                assetIcon!,
                height: 20,
                width: 33,
                color: svgColor,
              )
                  : const SizedBox(
                height: 0,
              ),
              icon == null
                  ? const SizedBox(
                width: 0,
              )
                  : Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
              const SizedBox(
                width: 8,
              ),
              CustomText(
                  title: text,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
