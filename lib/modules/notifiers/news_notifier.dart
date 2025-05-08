import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/models/response.dart';
import 'package:finance_news/data/repos/news_repo.dart';
import 'package:finance_news/modules/models/news_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier(this.newsRepo) : super(NewsState()) {
    fetchNews();
  }

  NewsRepo newsRepo;

  Future<void> fetchNews() async {
    state = state.setLoading('Loading News');

    try {
      final newsList = await newsRepo.getNews();

      // Update the state with new appointments
      state = state.copyWith(
        response: Response.success('News Loaded Successfully'),
        news: newsList,
      );
    } catch (e) {
      state = state.copyWith(response: Response.error(e.toString()));
    }
  }
}
