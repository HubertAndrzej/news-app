import 'package:flutter/material.dart';

enum NewsType {
  allNews,
  topTrending,
}

enum SortBy {
  popularity,
  publishedAt,
  relevancy,
}

class SortByHelper {
  static String getValue(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.popularity:
        return 'Popularity';
      case SortBy.publishedAt:
        return 'Published At';
      case SortBy.relevancy:
        return 'Relevancy';
      default:
        return '';
    }
  }
}

List<DropdownMenuItem<String>> get dropDownItems {
  List<DropdownMenuItem<String>> menuItem = [
    DropdownMenuItem(
      value: SortByHelper.getValue(SortBy.relevancy),
      child: Text(
        SortByHelper.getValue(SortBy.relevancy),
      ),
    ),
    DropdownMenuItem(
      value: SortByHelper.getValue(SortBy.publishedAt),
      child: Text(
        SortByHelper.getValue(SortBy.publishedAt),
      ),
    ),
    DropdownMenuItem(
      value: SortByHelper.getValue(SortBy.popularity),
      child: Text(
        SortByHelper.getValue(SortBy.popularity),
      ),
    ),
  ];
  return menuItem;
}
