import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfiguration {
  static Dio getInstance() {
    final dio = Dio()
      ..interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        logPrint: (object) {
          debugPrint('\x1B[32m$object\x1B[0m');
        },
      ));
    return dio;
  }
}
