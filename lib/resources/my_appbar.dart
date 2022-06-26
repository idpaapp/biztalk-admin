import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? color;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final bool? centerTitle;
  final List<Widget>? actions;
  final BuildContext pageContext;
  final onBackPress;

  const CustomAppbar(
      {Key? key,
      this.actions,
      required this.pageContext,
      this.bgColor,
      this.centerTitle,
      this.title,
      this.color,
      this.fontWeight,
      this.onBackPress})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: CustomText(
        title: title,
        fontSize: 16,
        color: color,
        fontWeight: fontWeight,
      ),
      backgroundColor: bgColor,
      elevation: 0,
      actions: actions,
      leading: InkWell(
        onTap: () {
          if (onBackPress != null) {
            onBackPress();
          }
          Navigator.of(pageContext).pop();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }
}
