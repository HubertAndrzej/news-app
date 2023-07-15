import 'package:flutter/widgets.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews() async {
    newsList = await NewsApiServices.getAllNews();
    return newsList;
  }
}
