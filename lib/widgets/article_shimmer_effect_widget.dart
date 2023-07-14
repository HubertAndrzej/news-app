import 'package:flutter/material.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerEffectWidget extends StatelessWidget {
  const ArticleShimmerEffectWidget({
    super.key,
    required this.getBaseShimmerColor,
    required this.getHighlightShimmerColor,
    required this.getWidgetShimmerColor,
    required this.size,
    required this.borderRadius,
  });

  final Color getBaseShimmerColor;
  final Color getHighlightShimmerColor;
  final Color getWidgetShimmerColor;
  final Size size;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Shimmer.fromColors(
                baseColor: getBaseShimmerColor,
                highlightColor: getHighlightShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: getWidgetShimmerColor,
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                      ),
                    ),
                    const HorizontalSpacingWidget(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: getWidgetShimmerColor,
                            ),
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: size.height * 0.025,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: getWidgetShimmerColor,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color: getWidgetShimmerColor,
                                  ),
                                ),
                                const HorizontalSpacingWidget(width: 5),
                                Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    color: getWidgetShimmerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
