import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/models/bookmarks_model.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_news_widget.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

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
      drawer: const DrawerWidget(),
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
      body: Column(
        children: [
          FutureBuilder<List<BookmarksModel>>(
            future: Provider.of<BookmarksProvider>(
              context,
              listen: false,
            ).fetchBookmarks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(newsType: NewsType.allNews);
              } else if (snapshot.hasError) {
                return Expanded(
                  child: EmptyNewsWidget(
                    text: '${snapshot.error}',
                    imagePath: 'assets/images/no_news.png',
                  ),
                );
              } else if (snapshot.data == null) {
                return const EmptyNewsWidget(
                  text: 'You didn\'t add anything yet to your bookmarks',
                  imagePath: "assets/images/bookmark.png",
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const ArticleWidget(isBookmark: true),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
