import 'package:dio/dio.dart';
import 'package:miniflix/model/apis/apis.dart';
import 'package:miniflix/model/credits.dart';
import 'package:miniflix/model/movie.dart';
import 'package:miniflix/model/movie_detail.dart';
import 'package:miniflix/model/review.dart';
import 'package:miniflix/model/trending.dart';
import 'package:miniflix/model/video.dart';
import 'package:retrofit/retrofit.dart';

part 'res_client.g.dart';

@RestApi(baseUrl: Apis.baseServiceUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //! get movies Trending
  @GET(Apis.trending + Apis.movie + Apis.day)
  Future<Trending> getTrendingMovies({
    @Query('api_key') required String apiKey,
  });
  //! get movies popular
  @GET(Apis.movie + Apis.popular)
  Future<Movie> getPopularMovies({@Query('api_key') required String apiKey});

  //! get movies upcoming
  @GET(Apis.movie + Apis.upComing)
  Future<Movie> getUpComingMovies({@Query('api_key') required String apiKey});

  //! get moviesDetail
  @GET('${Apis.movie}/{movieId}')
  Future<MovieDetail> getMovieDetail({
    @Path('movieId') required String movieId,
    @Query('api_key') required String apiKey,
  });

  //! get videos
  @GET('${Apis.movie}/{movieId}${Apis.videos}')
  Future<Videos> getVideos({
    @Path('movieId') required String movieId,
    @Query('api_key') required String apiKey,
  });

  //! get credits
  @GET('${Apis.movie}/{movieId}${Apis.credits}')
  Future<Credits> getCredits({
    @Path('movieId') required String movieId,
    @Query('api_key') required String apiKey,
  });

  //! get reviews
  @GET('${Apis.movie}/{movieId}${Apis.reviews}')
  Future<Reviews> getReviews({
    @Path('movieId') required String movieId,
    @Query('api_key') required String apiKey,
  });
}
