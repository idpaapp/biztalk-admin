import 'package:biztalk_panel_admin/controller/auth_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/home_page.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class CheckTokenController extends GetxController{
  final AuthController _authController =Get.put(AuthController());

  @override
  void onInit() {
    checkToken();

    // TODO: implement onInit
    super.onInit();
  }

  void checkToken() async{
    await GetStorage.init();
    await _authController.fetchToken();
    print("*******************************");
    print(_authController.token.value);
    if(_authController.token.value == ""){
      Get.to(()=>LoginPage());
    }else{
      Get.toNamed(HomePage.route);
    }
  }
}