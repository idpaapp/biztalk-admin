import 'package:biztalk_panel_admin/model/login/login_model.dart';
import 'package:biztalk_panel_admin/service/repository.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  //***********************************Login variable********************************************

//************************************Send verify cod*********************************************

  var validVerifyCode = false.obs;
  var isSuccessfulResultVerify = false.obs;
  final getStorage = GetStorage();
  static const _tokenKEY = 'token';
  RxString token = ''.obs;
  RxString mobileNumber = "".obs;

//************************************************* login ******************************************

  RxBool isLoadingLogin = false.obs;

  RxString failureMessageLogin = "".obs;
  var resultLogin = LoginModel().obs;

  login(String number, String password) async {
    failureMessageLogin.value = "";
    isLoadingLogin.value = true;
    final result = await _repository.login(number, password);
    result.fold(
          (left) {
        failureMessageLogin.value = left.message;
      },
          (right) async{
        resultLogin.value = right;
        token.value=resultLogin.value.data!.token.toString();
        await saveToken(resultLogin.value.data!.token.toString());
        isLoadingLogin.value = false;
      },
    );
  }




  saveToken(String token) async {
    await getStorage.write(_tokenKEY, token);

    await getStorage.save();
    print('save!');
    print(getStorage.read(_tokenKEY));
  }

  String fetchToken() {
    return getStorage.read(_tokenKEY) ?? "";

  }

  removeToken() async {
    await getStorage.remove(_tokenKEY);

    token.value = "";

    Get.offAll(LoginPage());
  }

  bool hasToken() {
    return getStorage.hasData(_tokenKEY);
  }
}
