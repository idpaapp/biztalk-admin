import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hint;
  final TextInputType? textInputType;
  final IconData? iconData;
  final bool isObscureText;
  final validator;
  final int? maxLen;

  const LoginTextFieldWidget(
      {Key? key,
      this.textEditingController,
      this.hint,
        this.maxLen,
      this.textInputType,
        this.validator,
      this.iconData,required this.isObscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.veryLightGrey),
        child: TextFormField(
          validator: validator,
maxLength: maxLen,
          keyboardType: textInputType,
          obscureText: isObscureText,
          decoration: InputDecoration(
            counterText: "",
              border: InputBorder.none,
              hintText: hint,

              prefixIcon: Icon(iconData)),
          controller: textEditingController,
        ),
      );
}
