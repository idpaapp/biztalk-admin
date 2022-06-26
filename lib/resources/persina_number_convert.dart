class NumberConverter {
  static const _persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  static const _english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  static String? toPersian(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value.trim().isEmpty) return value;

      for (int i = 0; i < _english.length; i++) {
        value = value!.replaceAll(_english[i], _persian[i]);
      }

      return value;
    }
  }

  static String? toEnglish(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value.trim().isEmpty) return value;

      for (int j = 0; j < _persian.length; j++) {
        value = value!.replaceAll(_persian[j], _english[j]);
      }

      return value;
    }
  }
}
