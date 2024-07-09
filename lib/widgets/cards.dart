import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app/widgets/my_font.dart';

import '../data/card.dart';
import '../providers/index_providers.dart';

class MyCards extends StatelessWidget {
  final int index;
  const MyCards({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: index == 0
                  ? Colors.cyan
                  : index == 1
                      ? Colors.indigoAccent
                      : Colors.green,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(15, 5),
                  color: Colors.grey.shade300,
                  spreadRadius: 0,
                  blurRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                const MyFont(
                  title: "#NEW-RELEASE",
                  color: Colors.lime,
                  fontWeight: FontWeight.bold,
                  size: 12,
                ),
                const SizedBox(height: 10),

                //title
                MyFont(
                  title: cardBanners[index].name,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    fixedSize: const Size(100, 30),
                  ),
                  child: const MyFont(
                    title: "SHOP NOW",
                    size: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        //image
        Positioned(
          top: index != 1 ? 15 : 0,
          right: index == 0
              ? -25
              : index == 1
                  ? -55
                  : -45,
          bottom: 0,
          child: AspectRatio(
            aspectRatio: index != 0 ? 1.3 : 1.2,
            child: Image.asset(
              cardBanners[index].image,
              fit: BoxFit.cover,
            ),
          ),
        ),

        //Dots
        Positioned(
          bottom: -5,
          child: SizedBox(
            width: 130,
            height: 20,
            child: ListView.builder(
                itemCount: cardBanners.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Consumer(builder: (context, ref, child) {
                    //currentIndex
                    final currentIndex = ref.watch(cardIndexProvider);

                    return Container(
                      margin: const EdgeInsets.all(5),
                      width: index == currentIndex ? 45 : 10,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: index == currentIndex
                            ? BorderRadius.circular(20)
                            : null,
                        shape: index == currentIndex
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                      ),
                    );
                  });
                }),
          ),
        ),
      ],
    );
  }
}
