
import 'package:crud_operations/app/core/app_extension.dart';
import 'package:crud_operations/app/network/dio_exception.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

abstract mixin class ApiHelper<T> {
  // late final T data;

  Future<bool> _requestMethodTemplate(
      Future<Response<dynamic>> apiCallback) async {
    final Response response = await apiCallback;
    if (response.statusCode.success) {
      return true;
    } else {
      throw DioExceptions;
    }
  }

  //Generic method template for create item on server
  Future<bool> postRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for update item on server
  Future<bool> putRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for delete item from server
  Future<bool> deleteRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for getting data from Api
  Future<List<T>> makeGetRequest(Future<Response<dynamic>> apiCallback,
      T Function(Map<String, dynamic> json) getJsonCallback) async {
    final Response response = await apiCallback;

    final List<T> items = List<T>.from(
      json
          .decode(json.encode(response.data))
          .map((item) => getJsonCallback(item)),
    );
    if (response.statusCode.success) {
      return items;
    } else {
      throw DioExceptions;
    }
  }
    //Generic method template for getting data from Api
  Future<T> makeGetSingletItemRequest(Future<Response<dynamic>> apiCallback,
      T Function(Map<String, dynamic> json) getJsonCallback) async {
    final Response response = await apiCallback;

    final item = getJsonCallback(response.data);

    if (response.statusCode.success) {
      return item;
    } else {
      throw DioExceptions;
    }
  }
}
