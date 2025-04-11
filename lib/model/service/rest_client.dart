import 'package:dio/dio.dart';

import 'package:miniflix/model/api/apis.dart';
import 'package:miniflix/model/list_popular.dart';
import 'package:miniflix/model/list_top_rated.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Apis.baseService)
abstract class RestClient {
  factory RestClient(Dio dio,{String baseUrl}) = _RestClient;

  @GET(Apis.popular)
  Future<Popular> apiKePopular(
    @Query('api_key') String apiKey,
    @Query('page') String page,
  );

  @GET(Apis.topRated)
  Future<TopRated> apiKeTopRated(
    @Query('api_key') String apiKey,
    @Query('page') String page,
  );
  

}

