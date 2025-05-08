import 'package:equatable/equatable.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/models/response.dart';

class NewsState extends Equatable {
  final Response response;
  final List<News> news;

  bool get isSuccess => response.isSuccess;

  NewsState setLoading(String message) {
    return copyWith(response: Response.loading(message));
  }

  NewsState({
    this.response = const Response.initial(),
    this.news = const [],
  });

  NewsState copyWith({
    Response? response,
    List<News>? news,
  }) {
    return NewsState(
      response: response ?? this.response,
      news: news ?? this.news,
    );
  }

  @override
  List<Object?> get props => [
        response,
        news,
      ];
}
