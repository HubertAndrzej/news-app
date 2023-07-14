import 'package:flutter/material.dart';

class PaginationButtonWidget extends StatelessWidget {
  const PaginationButtonWidget({
    super.key,
    required this.text,
    required this.function,
  });

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(6),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
      child: Text(text),
    );
  }
}
