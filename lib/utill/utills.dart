import 'package:connectivity_plus/connectivity_plus.dart';

class Utills {
  static Future<bool> checkInternetConnection() async {
    bool isConnect = false;
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      isConnect = true;
    } else {
      isConnect = false;
    }
    return isConnect;
  }
}
