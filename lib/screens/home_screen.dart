import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';
import 'package:news_app/widgets/tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News App',
            style: GoogleFonts.lobster(
              textStyle: TextStyle(
                color: color,
                fontSize: 20,
                letterSpacing: 0.6,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.search),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TabWidget(
                    color: newsType == NewsType.allNews
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    fontSize: newsType == NewsType.allNews ? 22 : 14,
                    text: 'All News',
                    function: () {
                      if (newsType == NewsType.allNews) return;
                      setState(() => newsType = NewsType.allNews);
                    },
                  ),
                  const HorizontalSpacingWidget(width: 25),
                  TabWidget(
                    color: newsType == NewsType.topTrending
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    fontSize: newsType == NewsType.topTrending ? 22 : 14,
                    text: 'Top Trending',
                    function: () {
                      if (newsType == NewsType.topTrending) return;
                      setState(() => newsType = NewsType.topTrending);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
