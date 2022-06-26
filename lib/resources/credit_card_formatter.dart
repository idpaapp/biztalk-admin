import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits });
  final int? maxDigits ;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter =  NumberFormat("#,###");
    String newText =  formatter.format(value );
    return newValue.copyWith(
        text: newText,
        selection:  TextSelection.collapsed(offset: newText.length));
  }
}
