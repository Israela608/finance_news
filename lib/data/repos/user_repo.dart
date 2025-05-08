import 'dart:developer';

import 'package:finance_news/core/helper/database_helper.dart';
import 'package:finance_news/core/utils/constants.dart';
import 'package:finance_news/data/models/response.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepoProvider = Provider<UserRepo>((ref) {
  return UserRepo();
});

class UserRepo {
  final dbHelper = DatabaseHelper();

  Future<Response> saveUserCredentials(
      String firstName, String lastName) async {
    try {
      await Future.wait([
        dbHelper.save(AppConst.firstName, firstName),
        dbHelper.save(AppConst.lastName, lastName),
      ]);
      return Response.success('Saved Successfully!');
    } catch (e) {
      log('Failed to save user credentials: $e');
      return Response.error('Failed to save user credentials');
    }
  }

  static Future<String?> getFirstName() async {
    try {
      final dbHelper = DatabaseHelper();
      return await dbHelper.read(AppConst.firstName);
    } catch (e) {
      log('Failed to get First Name: $e');
      return null;
    }
  }
}

/*
class UserRepo {
  UserRepo({required this.apiClient});
  ApiClient apiClient;

  //Method that saves the user token from the server, so we can use it next time we log in
  Future<Response> saveUserCredentials(
      String firstName, String lastName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await Future.wait([
        prefs.setString(ApiConstants.token, token),
        prefs.setString(ApiConstants.refreshToken, refreshToken),
      ]);

      return Response.success(true);
    } catch (e) {
      debugPrint('Failed to save user credentials: $e');
      return Response.error('Failed to save user credentials');
    }
  }

  //Method that saves the user token from the server, so we can use it next time we log in
  static Future<String?> getFirstName() async {
    String? firstName;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstName = prefs.getString(ApiConstants.token);
    } catch (e) {
      debugPrint('Failed to First Name: $e');
    }
    return firstName;
  }
}
*/
