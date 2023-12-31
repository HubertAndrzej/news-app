import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/constants/styles.dart';
import 'package:news_app/models/bookmarks_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/text_content_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BlogDetailsScreen extends StatefulWidget {
  static const routeName = '/BlogDetailsScreen';
  const BlogDetailsScreen({super.key});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  bool _isInBookmarks = false;
  String? publishedAt;
  dynamic currentBookmark;

  @override
  void didChangeDependencies() {
    publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    final List<BookmarksModel> bookmarksList =
        Provider.of<BookmarksProvider>(context).getBookmarksList;
    if (bookmarksList.isEmpty) {
      return;
    }
    currentBookmark = bookmarksList
        .where((element) => element.publishedAt == publishedAt)
        .toList();
    if (currentBookmark.isEmpty) {
      _isInBookmarks = false;
    } else {
      _isInBookmarks = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils(context: context).getColor;
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    final BookmarksProvider bookmarksProvider =
        Provider.of<BookmarksProvider>(context);
    final NewsModel currentNews =
        newsProvider.findByDate(publishedAt: publishedAt);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          currentNews.authorName,
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                const VerticalSpacingWidget(height: 25),
                Row(
                  children: [
                    Text(
                      currentNews.dateToShow,
                      style: smallTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      currentNews.readingTimeText,
                      style: smallTextStyle,
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 20),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Hero(
                    tag: currentNews.publishedAt,
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset('assets/images/empty_image.png'),
                      imageUrl: currentNews.urlToImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await Share.share(
                              currentNews.url,
                              subject: 'Look what I made!',
                            );
                          } catch (error) {
                            GlobalMethods.errorDialog(
                              errorMessage: error.toString(),
                              context: context,
                            );
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_isInBookmarks) {
                            await bookmarksProvider.removeFromBookmarks(
                              key: currentBookmark[0].bookmarkKey,
                            );
                          } else {
                            await bookmarksProvider.addToBookmarks(
                              newsModel: currentNews,
                            );
                          }
                          await bookmarksProvider.fetchBookmarks();
                        },
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              _isInBookmarks
                                  ? IconlyBold.bookmark
                                  : IconlyLight.bookmark,
                              size: 28,
                              color: _isInBookmarks ? Colors.green : color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpacingWidget(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContentWidget(
                  label: 'Description',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacingWidget(height: 10),
                TextContentWidget(
                  label: currentNews.description,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                const VerticalSpacingWidget(
                  height: 20,
                ),
                const TextContentWidget(
                  label: 'Contents',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpacingWidget(
                  height: 10,
                ),
                TextContentWidget(
                  label: currentNews.content,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
