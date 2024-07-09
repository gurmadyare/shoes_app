import 'package:flutter/material.dart';
import 'package:shoes_app/widgets/my_font.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final void Function()? onPressed;

  const MyTextButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: MyFont(
        title: text,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
