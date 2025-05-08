import 'package:finance_news/core/helper/database_helper.dart';
import 'package:finance_news/core/utils/constants.dart';
import 'package:finance_news/data/constants/api_constants.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/models/response.dart';
import 'package:finance_news/data/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsRepoProvider = Provider<NewsRepo>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NewsRepo(apiClient: apiClient);
});

class NewsRepo {
  NewsRepo({required this.apiClient});

  ApiClient apiClient;
  final dbHelper = DatabaseHelper();

  Future<List<News>> getAppointments() async {
    final data = await apiClient.getData(ApiConstants.newsUrI);
    // Assume the API sends a list of news. Adjust as needed.
    return News.fromListJson(data);
  }
}
