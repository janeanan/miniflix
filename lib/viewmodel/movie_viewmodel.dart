import 'package:flutter/material.dart';
import 'package:miniflix/model/apis/dio_configuration.dart';
import 'package:miniflix/model/movie.dart';
import 'package:miniflix/model/service/res_client.dart';
import 'package:miniflix/utils/enum.dart';
import 'package:miniflix/utils/utils.dart';

class MovieViewModel extends ChangeNotifier {
  //! getTrendingList
  ConnectionStatus _statusGetTrending = ConnectionStatus.none;
  ConnectionStatus get statusGetTrending => _statusGetTrending;
  Movie _responseGetTrending = Movie();
  Movie get responseGetTrending => _responseGetTrending;

  Future<void> getTrendingList() async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetTrending = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getTrendingMovies(apiKey: '93b5941ee4b87ed816693cfa75375609')
            .then((value) {
              _responseGetTrending = value;
              _statusGetTrending = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetTrending = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetTrending = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
  //! End getPopularList

  //! getPopularList
  ConnectionStatus _statusGetPopular = ConnectionStatus.none;
  ConnectionStatus get statusGetPopular => _statusGetPopular;
  Movie _responseGetPopular = Movie();
  Movie get responseGetPopular => _responseGetPopular;

  Future<void> getPopularList() async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetPopular = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getPopularMovies(apiKey: '93b5941ee4b87ed816693cfa75375609')
            .then((value) {
              _responseGetPopular = value;
              _statusGetPopular = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetPopular = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetPopular = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
  //! End getPopularList

  //! getUpcomingList
  ConnectionStatus _statusGetUpcoming = ConnectionStatus.none;
  ConnectionStatus get statusGetUpcoming => _statusGetUpcoming;
  Movie _responseGetUpcoming = Movie();
  Movie get responseGetUpcoming => _responseGetUpcoming;

  Future<void> getUpcomingList() async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetUpcoming = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getUpComingMovies(apiKey: '93b5941ee4b87ed816693cfa75375609')
            .then((value) {
              _responseGetUpcoming = value;
              _statusGetUpcoming = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetUpcoming = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetUpcoming = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }

  //! End getUpcomingList
}
