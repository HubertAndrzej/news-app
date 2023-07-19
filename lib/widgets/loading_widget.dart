import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/variables.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_shimmer_effect_widget.dart';
import 'package:news_app/widgets/top_trending_shimmer_effect_widget.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    required this.newsType,
  });

  final NewsType newsType;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color getBaseShimmerColor,
      getHighlightShimmerColor,
      getWidgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context: context);
    getBaseShimmerColor = utils.getBaseShimmerColor;
    getHighlightShimmerColor = utils.getHighlightShimmerColor;
    getWidgetShimmerColor = utils.getWidgetShimmerColor;
    Provider.of<BookmarksProvider>(
      context,
      listen: false,
    ).fetchBookmarks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;
    return widget.newsType == NewsType.topTrending
        ? Swiper(
            autoplayDelay: 8000,
            autoplay: true,
            itemWidth: size.width * 0.9,
            layout: SwiperLayout.STACK,
            viewportFraction: 0.9,
            itemCount: 5,
            itemBuilder: (context, index) => TopTrendingShimmerEffectWidget(
              getBaseShimmerColor: getBaseShimmerColor,
              getHighlightShimmerColor: getHighlightShimmerColor,
              getWidgetShimmerColor: getWidgetShimmerColor,
              size: size,
              borderRadius: borderRadius,
            ),
          )
        : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (ctx, index) => ArticleShimmerEffectWidget(
                getBaseShimmerColor: getBaseShimmerColor,
                getHighlightShimmerColor: getHighlightShimmerColor,
                getWidgetShimmerColor: getWidgetShimmerColor,
                size: size,
                borderRadius: borderRadius,
              ),
            ),
          );
  }
}
