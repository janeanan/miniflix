import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {
  static Future<bool> checkInternetConnection() async {
    bool isConnected = false;
    final List<ConnectivityResult> connectivityResults = await (Connectivity()
        .checkConnectivity());
    if (connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.ethernet)) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return isConnected;
  }
}
