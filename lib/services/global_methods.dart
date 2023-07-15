import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/widgets/horizontal_spacing_widget.dart';

class GlobalMethods {
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
