import 'package:biztalk_panel_admin/controller/auth_controller.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/app_validator.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/home/home_page.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/login/widget/login_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageMobile extends StatelessWidget {

  LoginPageMobile({Key? key}) : super(key: key);
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.dividerLight,
    body: Column(
      children: [
        const TopSectionPanelAdmin(title: "ورود"),
        SizedBox(
          height: Get.height * 0.1,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),

                    child: LoginTextFieldWidget(
                      maxLen: 11,
                      validator: AppValidators.phoneNumber,
                      iconData: Icons.person,
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      textEditingController: _userName,
                      hint: "شماره همراه",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),

                    child: LoginTextFieldWidget(
                      maxLen: null,
                      validator: AppValidators.password,
                      isObscureText: true,
                      iconData: Icons.vpn_key,
                      textInputType: TextInputType.text,
                      textEditingController: _password,
                      hint: "کلمه عبور",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonText(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        MyAlert.loding();
                        await _authController.login(
                            _userName.text, _password.text);
                        if (_authController.resultLogin.value.ok == true) {
                          Get.back();

                          Get.offAllNamed(HomePage.route);
                        }
                      }
                    },
                    text: "ورود",
                    height: 45,
                    width: Get.width,
                    bgColor: AppColors.blueIndigo,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
