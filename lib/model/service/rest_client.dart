import 'package:dio/dio.dart';

import 'package:miniflix/model/api/apis.dart';
import 'package:miniflix/model/list_popular.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Apis.baseService)
abstract class RestClient {
  factory RestClient(Dio dio,{String baseUrl}) = _RestClient;

  @GET(Apis.popular)
  Future<Popular> apiKey(
    @Query('api_key') String apiKey,
    @Query('page') String page,
  );
  

}
