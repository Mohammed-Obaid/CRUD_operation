import 'package:crud_operations/app/core/api_config.dart';
import 'package:crud_operations/app/network/dio_interceptor.dart';
import 'package:dio/dio.dart' show Dio, ResponseType;

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = ApiConfig.baseUrl
      ..options.headers = ApiConfig.header
      ..options.connectTimeout = ApiConfig.connectionTimeout
      ..options.receiveTimeout = ApiConfig.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }
}
