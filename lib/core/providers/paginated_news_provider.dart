import 'package:finance_news/core/notifiers/news_notifier.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final paginatedNewsProvider =
AutoDisposeNotifierProvider<PaginatedNewsNotifier, List<News>>(
    PaginatedNewsNotifier.new);