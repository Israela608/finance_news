import 'package:finance_news/core/providers/news_provider.dart';
import 'package:finance_news/core/providers/paginated_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      ref.read(paginatedNewsProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsList = ref.watch(paginatedNewsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Paginated Real-Time News')),
      body: ListView.builder(
        controller: _controller,
        itemCount: newsList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(newsList[index]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/*class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsyncValue = ref.watch(newsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Real-Time News')),
      body: newsAsyncValue.when(
        data: (newsList) => ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(newsList[index]),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}*/
