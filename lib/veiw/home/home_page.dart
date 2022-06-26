import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/responsive/screen_type_layout.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/home_mobile.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/home_desctop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const route = "/homePage";

  HomePage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());
  final OffController _offController = Get.put(OffController());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: Obx(() {
          if (_homeController.failureMessageFetchHome.value != "") {
            return Center(
              child: CustomText(
                  title: _homeController.failureMessageFetchHome.value),
            );
          } else if (_homeController.isLoadingFetchHome.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ScreenTypeLayout(
              desktop: HomeDesctopPage(
                  homeController: _homeController,
                  offController: _offController),
              tablet: HomeMobilePage(
                  homeController: _homeController,
                  offController: _offController),
              mobile: HomeMobilePage(
                  homeController: _homeController,
                  offController: _offController),
            );
          }
        }),
      );
}
