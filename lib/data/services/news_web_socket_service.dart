import 'dart:async';
import 'dart:convert';

import 'package:finance_news/data/models/news.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NewsWebSocketService {
  final String url;
  late WebSocketChannel _channel;

  NewsWebSocketService(this.url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  // NewsWebSocketService(String url)
  //     : _channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<List<News>> get newsStream {
    return _channel.stream.map((event) {
      final data = jsonDecode(event);
      // Assume the API sends a list of news. Adjust as needed.
      return News.fromListJson(data['news']);
    });
  }

  /// Sends a message to request a specific page
  void requestPage(int page) {
    final message = jsonEncode({'type': 'get_news', 'page': page});
    _channel.sink.add(message);
  }

  /// Receives the paginated news list
  /* Stream<List<News>> get newsStream {
    return _channel.stream.map((event) {
      final data = jsonDecode(event);
      return News.fromListJson(data['news']);
    });
  }*/

  void close() {
    _channel.sink.close();
  }
}
