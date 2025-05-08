import 'package:finance_news/data/repos/news_repo.dart';
import 'package:finance_news/modules/models/news_state.dart';
import 'package:finance_news/modules/notifiers/news_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  final newsRepo = ref.watch(newsRepoProvider);
  return NewsNotifier(newsRepo);
});

final newsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(newsProvider.select((value) => value.response.isLoading));
});
