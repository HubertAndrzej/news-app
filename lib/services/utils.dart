import 'package:flutter/material.dart';
import 'package:news_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  Utils({required this.context});

  BuildContext context;

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;

  Color get getColor => getTheme ? Colors.white : Colors.black;
}
