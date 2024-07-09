import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  const MyFont({
    super.key,
    required this.title,
    this.size = 18,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
      ),
    );
  }
}
