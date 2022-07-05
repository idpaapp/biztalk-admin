import 'package:biztalk_panel_admin/controller/auth_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/home_page.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final AuthController _authController = Get.put(AuthController());

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 1), () async {
      await GetStorage.init();
       _authController.fetchToken();

      if (_authController.fetchToken() == "") {
        Get.offAllNamed(LoginPage.route, predicate: (route) => false);
      } else {
        Get.offAllNamed(HomePage.route, predicate: (route) => false);
      }
    }); // TODO: implement onInit
    super.onInit();
  }

// RxString failureMessageRemoteConfig = "".obs;
// RxBool isLoadingRemoteConfig = false.obs;
// var resultRemoteConfig = RemoteConfigModel().obs;
//
// RemoteConfig() async {
//   failureMessageRemoteConfig.value = "";
//   isLoadingRemoteConfig.value = true;
//   final result = await _homeRepository.remoteConfig();
//   result.fold(
//         (left) {
//       failureMessageRemoteConfig.value = left.message;
//     },
//         (right) {
//       resultRemoteConfig.value = right;
//       isLoadingRemoteConfig.value = false;
//     },
//   );
// }
}
