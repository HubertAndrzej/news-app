import 'package:flutter/material.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier {
  final String newsId;
  final String sourceName;
  final String authorName;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String dateToShow;
  final String content;
  final String readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.dateToShow,
    required this.content,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(dynamic json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    String content = json['content'] ?? '';
    String dateToShow = '';
    if (json['publishedAt'] != null) {
      dateToShow = GlobalMethods.formattedDateText(json['publishedAt']);
    }

    return NewsModel(
      newsId: json['source']['id'] ?? '',
      sourceName: json['source']['name'] ?? '',
      authorName: json['author'] ?? '',
      title: title,
      description: description,
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://picsum.photos/200',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: dateToShow,
      content: content,
      readingTimeText: readingTime(title + description + content).msg,
    );
  }

  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((json) => NewsModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['newsId'] = newsId;
    data['sourceName'] = sourceName;
    data['authorName'] = authorName;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['dateToShow'] = dateToShow;
    data['content'] = content;
    data['readingTimeText'] = readingTimeText;
    return data;
  }
}
