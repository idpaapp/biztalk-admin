import 'package:flutter/foundation.dart';

class GlobalInfo {
  //farzad
  static  String serverAddress = kDebugMode ?  "http://192.168.2.248:3010":"https://bizztalk.ir:3443";

  //new
   //static const String serverAddress = 'https://bizztalk.ir:3443';
  //reza
  // static const String serverAddress = 'http://192.168.2.20:3010';
  //home
  //static const String serverAddress = 'http://217.170.254.172:1857';

static double pagePadding = 250;
  static  String baseURL = serverAddress + '/admin/api/';
}
