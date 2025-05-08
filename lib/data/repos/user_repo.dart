import 'package:finance_news/data/models/response.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepoProvider = Provider<UserRepo>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepo(apiClient: apiClient);
});

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
