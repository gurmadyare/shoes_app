
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

TextField myTextField() {
  return TextField(
    decoration: InputDecoration(
      hintText: "Search your favorite shoes...",
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
      ),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.only(left: 20, bottom: 5),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon: const Icon(
        Iconsax.search_favorite,
      ),
    ),
  );
}
