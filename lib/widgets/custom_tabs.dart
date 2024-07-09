import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app/widgets/my_font.dart';

import '../providers/index_providers.dart';


//TABS
final List _tabs = [
  "Nike",
  "Jordan",
  "Puma",
  "Adidas",
  "Skechers",
];

class CustomTabBar extends ConsumerWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: _tabs.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ref.read(tabsIndexProvider.notifier).state = index;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 38,
            width: 80,
            margin: const EdgeInsets.only(right: 10, top: 10),
            decoration: BoxDecoration(
              color: ref.watch(tabsIndexProvider) == index
                  ? Colors.lightBlue.shade100
                  : Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: ref.watch(tabsIndexProvider) == index
                  ? Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 1.5,
                    )
                  : null,
            ),
            child: Center(
              child: MyFont(
                title: _tabs[index],
                size: 14,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
