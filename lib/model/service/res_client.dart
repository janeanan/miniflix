import 'package:dio/dio.dart';
import 'package:miniflix/model/apis/apis.dart';
import 'package:miniflix/model/movie.dart';
import 'package:retrofit/retrofit.dart';

part 'res_client.g.dart';

@RestApi(baseUrl: Apis.baseServiceUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Apis.trending + Apis.movie + Apis.day)
  Future<Movie> getTrendingMovies({@Query('api_key') required String apiKey});

  @GET(Apis.movie + Apis.popular)
  Future<Movie> getPopularMovies({@Query('api_key') required String apiKey});

  @GET(Apis.movie + Apis.upComing)
  Future<Movie> getUpComingMovies({@Query('api_key') required String apiKey});
}
