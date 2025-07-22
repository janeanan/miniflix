class Apis {
  //! base service URL for The Movie Database API
  static const String baseServiceUrl = 'https://api.themoviedb.org/3';
  static const String movie = '/movie';

  //! service URL for movies
  //* TRENDING
  //! ## baseServiceUrl + trending + movie + day/week
  static const String week = '/week';
  static const String day = '/day';
  static const String trending = '/trending';

  //* MOVIE LISTS
  //! ## baseServiceUrl + movie + movieList
  static const String popular = '/popular';
  static const String upComing = '/upcoming';

  //* VIDEOS
  //! ## baseServiceUrl + movie + {movie_id} + videos
  static const String videos = '/videos';

  //* Cradits
  //! ##  baseServiceUrl + movie + {movie_id} + credits
  static const String credits = '/credits';

  //* Reviews
  //! ## baseServiceUrl + movie + {movie_id} + reviews
  static const String reviews = '/reviews';
}
