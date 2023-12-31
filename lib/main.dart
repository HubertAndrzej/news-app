import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/constants/theme_data.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/providers/dark_theme_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/blog_details_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  Future<void> getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const HomeScreen(),
            routes: {
              BlogDetailsScreen.routeName: (ctx) => const BlogDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
