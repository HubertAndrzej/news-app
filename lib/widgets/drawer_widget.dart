import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/dark_theme_provider.dart';
import 'package:news_app/screens/bookmarks_screen.dart';
import 'package:news_app/widgets/list_tile_widget.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/images/newspaper.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const VerticalSpacingWidget(height: 20),
                  Flexible(
                    child: Text(
                      'News App',
                      style: GoogleFonts.lobster(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpacingWidget(height: 20),
            ListTileWidget(
              function: () {},
              icon: IconlyBold.home,
              label: "Home",
            ),
            ListTileWidget(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const BookmarksScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: IconlyBold.bookmark,
              label: "Bookmark",
            ),
            const Divider(thickness: 2),
            SwitchListTile(
              onChanged: (bool value) {
                setState(() => themeProvider.setDarkTheme = value);
              },
              title: Text(
                themeProvider.getDarkTheme ? 'Dark' : 'Light',
                style: const TextStyle(fontSize: 20),
              ),
              secondary: Icon(
                themeProvider.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getDarkTheme,
            ),
          ],
        ),
      ),
    );
  }
}
