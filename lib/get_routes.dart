import 'package:biztalk_panel_admin/veiw/calender/calender_page.dart';
import 'package:biztalk_panel_admin/veiw/home/home_page.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_page.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_page.dart';
import 'package:biztalk_panel_admin/veiw/splash.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_page.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_page.dart';
import 'package:get/get.dart';

final getPages = <GetPage>[
  GetPage(
    name: SplashPage.route,
    page: () => SplashPage(),
  ), GetPage(
    name: LoginPage.route,
    page: () => LoginPage(),
  ),

  GetPage(
    name: HomePage.route,
    page: () => HomePage(),
  ), GetPage(
    name: SingleUserPage.route,
    page: () => SingleUserPage(),
  ), GetPage(
    name: TransactionPage.route,
    page: () => TransactionPage(),
  ),GetPage(
    name: TvPage.route,
    page: () => TvPage(),
  ),GetPage(
    name: CalenderPage.route,
    page: () => CalenderPage(),
  ),
];
