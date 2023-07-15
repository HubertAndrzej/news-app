import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextContentWidget extends StatelessWidget {
  const TextContentWidget({
    super.key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  });

  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
