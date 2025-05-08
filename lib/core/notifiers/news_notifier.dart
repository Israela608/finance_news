/*final newsWebSocketServiceProvider = Provider((ref) {
  final service = NewsWebSocketService('wss://your-api-endpoint');
  ref.onDispose(service.close);
  return service;
});*/

import 'package:finance_news/core/providers/news_provider.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/services/news_web_socket_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaginatedNewsNotifier extends AutoDisposeNotifier<List<News>> {
  int _currentPage = 1;
  late NewsWebSocketService _service;
  late Stream<List<News>> _newsStream;

  @override
  List<News> build() {
    _service = ref.read(newsWebSocketServiceProvider);
    _newsStream = _service.newsStream;

    _service.requestPage(_currentPage);
    _newsStream.listen((newItems) {
      state = [...state, ...newItems];
    });

    return [];
  }

  void loadNextPage() {
    _currentPage++;
    _service.requestPage(_currentPage);
  }

  void reset() {
    _currentPage = 1;
    state = [];
    _service.requestPage(_currentPage);
  }
}
