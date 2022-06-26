import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isCenter;
  final double? lineSpacing;
  final int? state;
  final TextOverflow? textOverflow;

  const CustomText(
      {Key? key,
      this.state,
        this.textOverflow,
      this.title,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.isCenter,
      this.lineSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title!,
      textAlign: isCenter == true ? TextAlign.center : TextAlign.right,
      overflow:textOverflow ,
      style: TextStyle(
        height: lineSpacing,
        color: color,
        fontSize: state == 1
            ? 14
            : state == 2
                ? 14
                : state == 3
                    ? 16
                    : state == 4
                        ? 14
                        : state == 5
                            ? 14
                            : state == 6
                                ? 12
                                : fontSize,
        fontWeight: state == 1
            ? FontWeight.w500
            : state == 2
                ? FontWeight.normal
                : state == 3
                    ? FontWeight.w500
                    : state == 4
                        ? FontWeight.bold
                        : state == 5
                            ? FontWeight.w500
                            : state == 6
                                ? FontWeight.normal
                                : fontWeight,
      ),
    );
  }
}
