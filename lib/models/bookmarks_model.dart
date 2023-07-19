import 'package:flutter/material.dart';

class BookmarksModel with ChangeNotifier {
  BookmarksModel({
    required this.bookmarkKey,
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

  final String bookmarkKey;
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

  factory BookmarksModel.fromJson({
    required dynamic json,
    required String bookmarkKey,
  }) {
    return BookmarksModel(
      bookmarkKey: bookmarkKey,
      newsId: json['newsId'] ?? '',
      sourceName: json['sourceName'] ?? '',
      authorName: json['authorName'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ??
          'https://cdn-icons-png.flaticon.com/512/833/833268.png',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: json['dateToShow'] ?? '',
      content: json['content'] ?? '',
      readingTimeText: json['readingTimeText'] ?? '',
    );
  }

  static List<BookmarksModel> bookmarksFromSnapshot({
    required dynamic data,
    required List allKeys,
  }) {
    return allKeys.map((key) {
      return BookmarksModel.fromJson(
        json: data[key],
        bookmarkKey: key,
      );
    }).toList();
  }

  @override
  String toString() {
    return 'news {newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content,}';
  }
}
