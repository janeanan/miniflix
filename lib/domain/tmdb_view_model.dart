import 'package:flutter/foundation.dart';
import 'package:miniflix/data/enum.dart';
import 'package:miniflix/model/api/dio_configuration.dart';
import 'package:miniflix/model/list_popular.dart';
import 'package:miniflix/model/service/rest_client.dart';
import 'package:miniflix/utill/utills.dart';

class TmdbViewModel extends ChangeNotifier {
  ConnectionStatus _statusListPopular = ConnectionStatus.none;
  ConnectionStatus get statusListPopular => _statusListPopular;

  late Popular _responseListPopular;
  Popular get responseListPopular => _responseListPopular;

  Future<void> getListPoplar() async {
    Utills.checkInternetConnection().then(
      (value) {
        if (value) {
          _statusListPopular = ConnectionStatus.loading;
          notifyListeners();
          RestClient(DioConfiguration.getInstance()).apiKey("93b5941ee4b87ed816693cfa75375609", "1").then((value) {
            _responseListPopular = value;
            _statusListPopular = ConnectionStatus.success;
            notifyListeners();
          });
        } else {
          _statusListPopular = ConnectionStatus.noInternet;
          notifyListeners();
        }
      },
    );
  }
}

