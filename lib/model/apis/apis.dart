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
}
