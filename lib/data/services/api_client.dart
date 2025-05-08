import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finance_news/data/constants/api_constants.dart';
import 'package:finance_news/data/models/app_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  late String token;
  final String baseUrl = ApiConstants.baseUrl;
  final Duration timeoutDuration =
      Duration(seconds: 120); // Define your timeout duration here

  ApiClient() {
    token = ApiConstants.token;
  }

  Future<Map<String, String>> requestHeaders({bool useToken = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (token.isNotEmpty && (useToken)) 'Authorization': 'Bearer $token',
    };
    return headers;
  }

  Future<dynamic> getData(
    String uri, {
    bool useToken = true,
  }) async {
    debugPrint('GET URL:   $baseUrl$uri');
    var responseJson;

    try {
      final response = await http
          .get(
            Uri.parse(baseUrl + uri),
            headers: await requestHeaders(useToken: useToken),
          )
          .timeout(timeoutDuration);
      //log('GET API RESPONSE:   ${response.body}');

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    debugPrint('STATUS CODE => ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    }

    String message = 'There was an Error!';

    debugPrint('Error: $message : ${response.statusCode}');
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message);
      case 401:
        throw UnauthorisedException(message);
      case 403:
        throw ForbiddenException(message);
      case 404:
        throw NotFoundException(message);
      case 409:
        throw ConflictException(message);
      case 422:
        throw InvalidInputException(message);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server. Status code: ${response.statusCode}');
    }
  }
}
