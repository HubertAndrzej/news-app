import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/empty_news_widget.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
            textStyle: TextStyle(
              color: color,
              fontSize: 20,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (ctx, index) => const EmptyNewsWidget(
          text: 'You didn\'t add anything yet to your bookmarks',
          imagePath: "assets/images/bookmark.png",
        ),
      ),
    );
  }
}
