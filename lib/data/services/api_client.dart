import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finance_news/data/constants/api_constants.dart';
import 'package:finance_news/data/constants/strings.dart';
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

  Future<dynamic> getData(
    String uri, {
    bool useToken = true,
  }) async {
    log('GET URL:   $baseUrl$uri${useToken ? '&token=$token' : ''}');
    var responseJson;

    try {
      final response = await http
          .get(
            Uri.parse(baseUrl + uri + '${useToken ? '&token=$token' : ''}'),
          )
          .timeout(timeoutDuration);
      //log('GET API RESPONSE:   ${response.body}');

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Strings.noInternet);
    } on TimeoutException {
      throw FetchDataException(Strings.requestTimeout);
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    log('STATUS CODE => ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    }

    String message = Strings.genericError;

    log('Error: $message : ${response.statusCode}');
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
            '${Strings.communicationError}. Status code: ${response.statusCode}');
    }
  }
}
