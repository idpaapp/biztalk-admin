import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/responsive/screen_type_layout.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page_desctop.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page_mobile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const route = "/loginPage";

  LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: ScreenTypeLayout(
          desktop: LoginPageDesctop(),
          tablet: LoginPageMobile(),
          mobile: LoginPageMobile(),
        ),
      );
}
