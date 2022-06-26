import 'package:connectivity_plus/connectivity_plus.dart';

class DataConnectionChecker {
  static Future<bool> get hasConnection async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
