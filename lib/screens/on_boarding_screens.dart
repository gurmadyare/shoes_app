import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app/screens/home_screen.dart';
import 'package:shoes_app/widgets/my_font.dart';

import '../data/on_boarding.dart';
import '../providers/index_providers.dart';

final onBoardingPageViewController = PageController();

class OnBoardingScreens extends ConsumerWidget {
  const OnBoardingScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: content.length,
                controller: onBoardingPageViewController,
                onPageChanged: (index) =>
                    ref.read(pageViewIndexProvider.notifier).state = index,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (contex) {
                                return const HomeScreen();
                              }));
                            },
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                            ),
                            child: const MyFont(
                              title: "Skip",
                              size: 15,
                              color: Colors.tealAccent,
                            ),
                          ),
                        ),
                        //logo
                        Row(
                          children: [
                            //margin-left
                            const SizedBox(width: 30),

                            Image.asset(
                              content[index].logo,
                              width: 80,
                            ),
                            const SizedBox(width: 15),
                            MyFont(
                              title: index == 0
                                  ? "Highclass \nJordanese shoes"
                                  : index == 1
                                      ? "Futuristic \nNike sneakers"
                                      : "Stunning \nAddidas shoes",
                            ),
                          ],
                        ),

                        index != 0
                            ? const SizedBox(height: 28)
                            : const SizedBox(),
                        //img
                        SizedBox(
                          height: screenSize.height * .53,
                          child: Image.asset(
                            content[index].image,
                            width: index == 0
                                ? screenSize.width * 1
                                : screenSize.width * .8,
                          ),
                        ),

                        //title
                        MyFont(
                          title: content[index].title,
                          size: index == 0 ? 32 : 28,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 25),

                        //subtitle
                        MyFont(
                          title: content[index].description,
                          size: 14,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  );
                }),
          ),

          //DOTS & NEXT BUTTON
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 80),

                SizedBox(
                  width: 130,
                  height: 25,
                  child: ListView.builder(
                      itemCount: content.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Consumer(builder: (context, ref, child) {
                          //currentIndex
                          final currentIndex = ref.watch(pageViewIndexProvider);

                          return Container(
                            margin: const EdgeInsets.all(5),
                            width: index == currentIndex ? 45 : 15,
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

                //Next
                ElevatedButton(
                    onPressed: () {
                      onBoardingPageViewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.navigate_next_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
