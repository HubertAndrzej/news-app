import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_news_widget.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:news_app/widgets/pagination_button_widget.dart';
import 'package:news_app/widgets/tab_widget.dart';
import 'package:news_app/widgets/top_trending_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByHelper.getValue(SortBy.publishedAt);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;
    final Size size = Utils(context: context).getScreenSize;
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);

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
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SearchScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: const Icon(IconlyLight.search),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
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
              const VerticalSpacingWidget(height: 10),
              newsType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PaginationButtonWidget(
                            text: 'Prev',
                            function: () {
                              if (currentPageIndex == 0) return;
                              setState(() => currentPageIndex--);
                            },
                          ),
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                      onTap: () {
                                        setState(
                                            () => currentPageIndex = index);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text('${index + 1}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          PaginationButtonWidget(
                            text: 'Next',
                            function: () {
                              if (currentPageIndex == 4) return;
                              setState(() => currentPageIndex++);
                            },
                          ),
                        ],
                      ),
                    ),
              const VerticalSpacingWidget(height: 10),
              newsType == NewsType.topTrending
                  ? Container()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton(
                            dropdownColor: Theme.of(context).cardColor,
                            onChanged: (String? value) {
                              setState(() => sortBy = value!);
                            },
                            value: sortBy,
                            items: dropDownItems,
                          ),
                        ),
                      ),
                    ),
              FutureBuilder<List<NewsModel>>(
                future: newsProvider.fetchAllNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidget(newsType: newsType)
                        : Expanded(
                            child: LoadingWidget(newsType: newsType),
                          );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyNewsWidget(
                        text: '${snapshot.error}',
                        imagePath: 'assets/images/no_news.png',
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Expanded(
                      child: EmptyNewsWidget(
                        text: 'No news found',
                        imagePath: 'assets/images/no_news.png',
                      ),
                    );
                  }
                  return newsType == NewsType.allNews
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) =>
                                ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const ArticleWidget(),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: size.height * 0.6,
                          child: Swiper(
                            autoplay: true,
                            autoplayDelay: 8000,
                            itemWidth: size.width * 0.9,
                            layout: SwiperLayout.STACK,
                            viewportFraction: 0.9,
                            itemCount: 5,
                            itemBuilder: (ctx, index) => TopTrendingWidget(
                              url: snapshot.data![index].url,
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
