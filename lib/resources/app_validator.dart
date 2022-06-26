import 'package:biztalk_panel_admin/resources/persina_number_convert.dart';


class AppValidators {
  static String? phoneNumber(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "شماره موبایل الزامی است";

    bool errorCondition =
        !NumberConverter.toEnglish(value)!.trim().startsWith("09") ||
            value.trim().length != 11;
    String errorTxt = "شماره موبایل نامعتبر است";

    if (emptyCondition) return emptyTxt;
    if (errorCondition) return errorTxt;
    return null;
  }



  static String? password(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "رمز عبور الزامی است";

    bool errorCondition = value.trim().length < 8;
    String errorTxt = "رمز عبور باید شامل 8 عدد باشد";

    return emptyCondition
        ? emptyTxt
        : errorCondition
        ? errorTxt
        : null;
  }
}
