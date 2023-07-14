import 'package:flutter/material.dart';
import 'package:news_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  Utils({required this.context});

  BuildContext context;

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;

  Color get getColor => getTheme ? Colors.white : Colors.black;

  Size get getScreenSize => MediaQuery.of(context).size;

  Color get getBaseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get getHighlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get getWidgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}
