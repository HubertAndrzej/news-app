import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/news_model.dart';

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews() async {
    try {
      var uri = Uri.https(
        baseUrl,
        'v2/everything',
        {
          'q': 'youtube',
          'pageSize': '5',
          'domains': 'techcrunch.com',
        },
      );
      var response = await http.get(
        uri,
        headers: {
          'X-Api-Key': apiKey,
        },
      );
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var value in data['articles']) {
        newsTempList.add(value);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
