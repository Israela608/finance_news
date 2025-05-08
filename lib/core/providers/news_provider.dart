import 'package:finance_news/data/constants/api_constants.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/services/news_web_socket_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsWebSocketServiceProvider = Provider<NewsWebSocketService>((ref) {
  final service = NewsWebSocketService(
      '${ApiConstants.baseUrl} /?token= ${ApiConstants.token}');
  ref.onDispose(() => service.close());
  return service;
});

/*final newsWebSocketServiceProvider = Provider((ref) {
  final service = NewsWebSocketService('wss://your-api-endpoint');
  ref.onDispose(service.close);
  return service;
});*/

/*
final newsStreamProvider = StreamProvider<List<News>>((ref) {
  final service = ref.watch(newsWebSocketServiceProvider);
  return service.newsStream;
});
*/
