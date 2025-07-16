import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfiguration {
  static Dio getDioInstance() {
    Dio dio = Dio();
    // customization
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        logPrint: (obj) {
          debugPrint('\x1B[32m$obj\x1B[0m'); // Green color for logs
        },
      ),
    );

    return dio;
  }
}
