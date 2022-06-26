import 'package:biztalk_panel_admin/model/login/login_model.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/service/repository.dart';
import 'package:biztalk_panel_admin/veiw/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class AuthController extends GetxController {
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
  var resultLogin = LoginModel().obs;

  // login(String number,String password)async{
  //   var headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };
  //   var request = http.Request('POST', Uri.parse('${GlobalInfo.baseURL}login'));
  //   request.bodyFields = {
  //     'phone': '09128493373',
  //     'password': '2711'
  //   };
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  //
  // }
  login(String number, String password) async {

    isLoadingLogin.value = true;
    try {
      var data = await Repository.login(number, password);
      print("dataaaaaaaaaaaaa");
      print(data);
      if (data == "1") {
        Get.back();
        MyAlert.mySnakbarRed(text: "لطفا اتصال خود به شبکه را بررسی کنید");
        return;
      } else if(data !=null) {
        resultLogin(data);
        token.value=resultLogin.value.data!.token.toString();
        await saveToken(resultLogin.value.data!.token.toString());
      }
    } finally {
      isLoadingLogin.value = false;
    }
  }

  saveToken(String token) async {
    await getStorage.write(_tokenKEY, token);

    await getStorage.save();
    print('save!');
    print(getStorage.read(_tokenKEY));
  }

  String fetchToken() {
    return getStorage.read(_tokenKEY) ?? "";
    print('Feeeeeeeeeeeeeeeeeeeeeeeeeeeetch Tokeeeeeeb');
    print(token.value);
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
