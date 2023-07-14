import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopTrendingShimmerEffectWidget extends StatelessWidget {
  const TopTrendingShimmerEffectWidget({
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
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: size.height * 0.45,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Shimmer.fromColors(
          baseColor: getBaseShimmerColor,
          highlightColor: getHighlightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: size.height * 0.33,
                  width: double.infinity,
                  color: getWidgetShimmerColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: getWidgetShimmerColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: size.height * 0.025,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: getWidgetShimmerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
