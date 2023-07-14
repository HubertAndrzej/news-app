import 'package:flutter/material.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_shimmer_effect_widget.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;

    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (ctx, index) => ArticleShimmerEffectWidget(
            getBaseShimmerColor: getBaseShimmerColor,
            getHighlightShimmerColor: getHighlightShimmerColor,
            getWidgetShimmerColor: getWidgetShimmerColor,
            size: size,
            borderRadius: borderRadius),
      ),
    );
  }
}
