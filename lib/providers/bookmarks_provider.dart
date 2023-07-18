import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/bookmarks_model.dart';
import 'package:news_app/models/news_model.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarksList = [];

  List<BookmarksModel> get getBookmarksList {
    return bookmarksList;
  }

  Future<void> addToBookmarks({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(
        baseUrlFirebase,
        'bookmarks.json',
      );
      await http.post(
        uri,
        body: json.encode(
          newsModel.toJson(),
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
