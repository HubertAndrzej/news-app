import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  late WebViewController _webViewController;
  double _progress = 0;
  final _url =
      'https://techcrunch.com/2022/06/17/marc-lores-food-delivery-startup-wonder-raises-350m-3-5b-valuation/';

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).getColor;

    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(IconlyLight.arrowLeft2),
          ),
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'URL',
            style: TextStyle(color: color),
          ),
          actions: [
            IconButton(
              onPressed: () async => await _showModalBottomSheetFunction(),
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: _url,
                zoomEnabled: true,
                onProgress: (progress) {
                  setState(
                    () => _progress = progress / 100,
                  );
                },
                onWebViewCreated: (controller) =>
                    _webViewController = controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalBottomSheetFunction() async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VerticalSpacingWidget(height: 20),
            Center(
              child: Container(
                height: 5,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const VerticalSpacingWidget(height: 20),
            const Text(
              'More options',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const VerticalSpacingWidget(height: 20),
            const Divider(thickness: 2),
            const VerticalSpacingWidget(height: 20),
            ListTile(
              onTap: () async {
                try {
                  await Share.share(
                    _url,
                    subject: 'Look what I made!',
                  );
                } catch (error) {
                  GlobalMethods.errorDialog(
                    errorMessage: error.toString(),
                    context: context,
                  );
                }
              },
              leading: const Icon(Icons.share),
              title: const Text('Share'),
            ),
            ListTile(
              onTap: () async {
                if (!await launchUrl(Uri.parse(_url))) {
                  throw Exception('Could not launch $_url');
                }
              },
              leading: const Icon(Icons.open_in_browser),
              title: const Text('Open in browser'),
            ),
            ListTile(
              onTap: () async {
                try {
                  await _webViewController.reload();
                } catch (error) {
                  GlobalMethods.errorDialog(
                    errorMessage: error.toString(),
                    context: context,
                  );
                } finally {
                  Navigator.pop(context);
                }
              },
              leading: const Icon(Icons.refresh),
              title: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
