import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final IconData icon;
  final bool isPadding;
  final void Function()? onPressed;
  const IconContainer({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.bgColor = Colors.amber,
    this.isPadding = false, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(isPadding ? 14 : 0),
      onPressed: onPressed,
      style: IconButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      icon: Icon(
        icon,
        color: iconColor,
        size: 22,
      ),
    );
  }
}
