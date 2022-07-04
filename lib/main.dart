import 'dart:io';
import 'package:biztalk_panel_admin/controller/auth_controller.dart';
import 'package:biztalk_panel_admin/resources/scroll_web.dart';
import 'package:biztalk_panel_admin/service/calendar_repository.dart';
import 'package:biztalk_panel_admin/service/document_repository.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:biztalk_panel_admin/service/manager_repository.dart';
import 'package:biztalk_panel_admin/service/mentor_repository.dart';
import 'package:biztalk_panel_admin/service/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'get_routes.dart';
void main() async{
  print(Get.width);
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Repository());

  Get.put(AuthController());

  Get.put(HomeRepository());
  Get.put(DocumentRepository());
  Get.put(MentorRepository());
  Get.put(CalendarRepository());
  Get.put(ManagerRepository());

  HttpOverrides.global = MyHttpOverrides();
  setPathUrlStrategy();


runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'biztalk panel admin',
      theme: ThemeData(
        fontFamily: 'iran_sans',
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: MyCustomScrollBehavior(),

      debugShowCheckedModeBanner: false,
      getPages: getPages,
      initialRoute: "/",
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: widget!,
          ),
        ),
      ),
    );
  }
}
