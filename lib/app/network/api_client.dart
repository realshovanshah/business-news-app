// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:business_news/app/exceptions/app_exceptions.dart';

class ApiClient {
  factory ApiClient() => _instance;

  ApiClient._private() {
    _dio = Dio();
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  late Dio _dio;
  static final ApiClient _instance = ApiClient._private();

  Future<Map<String, dynamic>> get(String url) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await _dio.get<dynamic>(url);
      responseJson = _returnMapResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError {
      throw RateLimitException();
    }
    return responseJson;
  }
}

Map<String, dynamic> _returnMapResponse(Response res) {
  switch (res.statusCode) {
    case 200:
    case 201:
    case 204:
      final dynamic responseJson = res.data;
      return responseJson as Map<String, dynamic>;
    case 400:
      throw BadRequestException(res.data.toString());
    case 401:
    case 403:
      throw UnauthorisedException(res.data.toString());
    case 426:
    case 429:
      throw RateLimitException(res.data.toString());
    case 500:
    default:
      throw FetchDataException(
        'Error occured while Communication with Server with StatusCode : ${res.statusCode}',
      );
  }
}
