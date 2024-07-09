import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

SliverAppBar customAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () {},
      padding: const EdgeInsets.all(10),
      style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
      icon: const Icon(
        Iconsax.category,
        color: Colors.black,
      ),
    ),
    actions: const [
      CircleAvatar(
        backgroundColor: Colors.indigo,
        maxRadius: 23,
        child: CircleAvatar(
          maxRadius: 20,
          backgroundColor: Colors.pinkAccent,
          backgroundImage: AssetImage(
            "assets/images/others/profile-img.png",
          ),
        ),
      ),
    ],
  );
}
