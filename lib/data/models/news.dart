import 'package:equatable/equatable.dart';

class News extends Equatable {
  final int? datetime;
  final String? headline;
  final int? id;
  final String? image;
  final String? source;
  final String? url;

  const News({
    this.datetime,
    this.headline,
    this.id,
    this.image,
    this.source,
    this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      datetime: json['datetime'],
      headline: json['headline'],
      id: json['id'],
      image: json['image'],
      source: json['source'],
      url: json['url'],
    );
  }

  static List<News> fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return [];
    }
    return jsonList.map((json) => News.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [datetime, headline, id, image, source, url];
}
