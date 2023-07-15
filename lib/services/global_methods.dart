import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';

class GlobalMethods {
  static String formattedDateText(String publishedAt) {
    final parsedDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(parsedDate);
    DateTime publishedDate =
        DateFormat('yyyy-MM-dd hh:mm:ss').parse(formattedDate);
    String minutesInString = publishedDate.minute.toString();
    if (minutesInString.length == 1) {
      minutesInString = '0${publishedDate.minute}';
    }
    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year} ON ${publishedDate.hour}:$minutesInString';
  }

  static Future<void> errorDialog({
    required String errorMessage,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(errorMessage),
        title: const Row(
          children: [
            Icon(
              IconlyBold.danger,
              color: Colors.red,
            ),
            HorizontalSpacingWidget(width: 8),
            Text('An error occured'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
