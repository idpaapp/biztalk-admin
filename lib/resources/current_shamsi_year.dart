
import  'package:persian_number_utility/persian_number_utility.dart';

iranCurrentDate(){
  var now =  DateTime.now();
  String dateCurrent=now.toString();
  String iranDate=(dateCurrent.substring(0,10).toPersianDate()).toEnglishDigit();
  return iranDate;
}


english(){
  var now =  DateTime.now();
  String dateCurrent=now.toString();
  String englishDate=(dateCurrent.substring(0,10));
  return englishDate;

}
currentYear() {
  var now = DateTime.now();
  String dateCurrent = now.toString();
  String iranDate =
  (dateCurrent.substring(0, 10).toPersianDate()).toEnglishDigit();
  var date = iranDate.split("/");
  String year = date[0];
  return year;
}