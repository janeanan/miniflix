import 'package:flutter/material.dart';
import 'package:miniflix/model/apis/api_key.dart';
import 'package:miniflix/model/apis/dio_configuration.dart';
import 'package:miniflix/model/credits.dart';
import 'package:miniflix/model/movie.dart';
import 'package:miniflix/model/movie_detail.dart';
import 'package:miniflix/model/review.dart';
import 'package:miniflix/model/service/res_client.dart';
import 'package:miniflix/model/trending.dart';
import 'package:miniflix/model/video.dart';
import 'package:miniflix/utils/enum.dart';
import 'package:miniflix/utils/utils.dart';

class MovieViewModel extends ChangeNotifier {
  //! getTrendingList
  ConnectionStatus _statusGetTrending = ConnectionStatus.none;
  ConnectionStatus get statusGetTrending => _statusGetTrending;
  Trending _responseGetTrending = Trending();
  Trending get responseGetTrending => _responseGetTrending;

  Future<void> getTrendingList() async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetTrending = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getTrendingMovies(apiKey: ApiKeyConfiguration.apiKey)
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
            .getPopularMovies(apiKey: ApiKeyConfiguration.apiKey)
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
            .getUpComingMovies(apiKey: ApiKeyConfiguration.apiKey)
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

  //! getDetailMovie
  ConnectionStatus _statusGetMovieDetail = ConnectionStatus.none;
  ConnectionStatus get statusGetMovieDetail => _statusGetMovieDetail;
  MovieDetail _responseGetMovieDetail = MovieDetail();
  MovieDetail get responseGetMovieDetail => _responseGetMovieDetail;

  Future<void> getMovieDetail(String movieId) async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetMovieDetail = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getMovieDetail(
              movieId: movieId,
              apiKey: ApiKeyConfiguration.apiKey,
            )
            .then((value) {
              _responseGetMovieDetail = value;
              _statusGetMovieDetail = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetMovieDetail = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetMovieDetail = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
  //! End getDetailMovie

  //! getVideos
  ConnectionStatus _statusGetVideos = ConnectionStatus.none;
  ConnectionStatus get statusGetVideos => _statusGetVideos;
  Videos _responseGetVideos = Videos();
  Videos get responseGetvideos => _responseGetVideos;

  Future<void> getVideos(String movieId) async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetVideos = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getVideos(movieId: movieId, apiKey: ApiKeyConfiguration.apiKey)
            .then((value) {
              _responseGetVideos = value;
              _statusGetVideos = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetVideos = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetVideos = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
  //! End getVideos

  //! getCredits
  ConnectionStatus _statusGetCredits = ConnectionStatus.none;
  ConnectionStatus get statusGetCredits => _statusGetCredits;
  Credits _responseGetCredits = Credits();
  Credits get responseGetCredits => _responseGetCredits;

  Future<void> getCredits(String movieId) async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetCredits = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getCredits(movieId: movieId, apiKey: ApiKeyConfiguration.apiKey)
            .then((value) {
              _responseGetCredits = value;
              _statusGetCredits = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetCredits = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetCredits = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
  //! End getCredits

  //! getReviews
  ConnectionStatus _statusGetReviws = ConnectionStatus.none;
  ConnectionStatus get statusGetReviws => _statusGetReviws;
  Reviews _responseGetReviews = Reviews();
  Reviews get responseGetReviews => _responseGetReviews;

  Future<void> getReviews(String movieId) async {
    Utils.checkInternetConnection().then((value) {
      if (value) {
        _statusGetReviws = ConnectionStatus.loading;
        notifyListeners();
        RestClient(DioConfiguration.getDioInstance())
            .getReviews(movieId: movieId, apiKey: ApiKeyConfiguration.apiKey)
            .then((value) {
              _responseGetReviews = value;
              _statusGetReviws = ConnectionStatus.success;
              notifyListeners();
            })
            .onError((error, stackTrace) {
              _statusGetReviws = ConnectionStatus.failed;
              notifyListeners();
            });
      } else {
        _statusGetReviws = ConnectionStatus.noInternet;
        notifyListeners();
      }
    });
  }
}
