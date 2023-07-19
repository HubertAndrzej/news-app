import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/bookmarks_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarksList = [];

  List<BookmarksModel> get getBookmarksList {
    return bookmarksList;
  }

  Future<List<BookmarksModel>> fetchBookmarks() async {
    bookmarksList = await NewsApiServices.getBookmarks() ?? [];
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

  Future<void> removeFromBookmarks() async {
    try {
      var uri = Uri.https(
        baseUrlFirebase,
        'bookmarks.json',
      );
      await http.delete(
        uri,
      );
    } catch (error) {
      rethrow;
    }
  }
}
