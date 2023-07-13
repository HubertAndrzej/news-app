import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/providers/dark_theme_provider.dart';
import 'package:news_app/widgets/custom_list_tile.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
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
                  const VerticalSpacing(height: 20),
                  const Flexible(
                    child: Text('News App'),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(height: 20),
            CustomListTile(
              function: () {},
              icon: IconlyBold.home,
              label: "Home",
            ),
            CustomListTile(
              function: () {},
              icon: IconlyBold.bookmark,
              label: "Bookmark",
            ),
            const Divider(),
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
