import 'package:biztalk_panel_admin/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  static const route = "/";

  SplashPage({Key? key}) : super(key: key);
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
