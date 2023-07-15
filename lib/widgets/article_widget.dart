import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/styles.dart';
import 'package:news_app/screens/blog_details_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:page_transition/page_transition.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            BlogDetailsScreen.routeName,
          ),
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
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                          boxFit: BoxFit.fill,
                          errorWidget:
                              Image.asset('assets/images/empty_image.png'),
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          imageUrl: imageUrl),
                    ),
                    const HorizontalSpacingWidget(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'title ' * 20,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: smallTextStyle,
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 reading time',
                              style: smallTextStyle,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const NewsDetailsScreen(),
                                      inheritTheme: true,
                                      ctx: context,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  '14-07-2023',
                                  maxLines: 1,
                                  style: smallTextStyle,
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
            ],
          ),
        ),
      ),
    );
  }
}
