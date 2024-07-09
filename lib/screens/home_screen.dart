import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoes_app/widgets/bottom_app_bar.dart';
import 'package:shoes_app/widgets/cards.dart';
import 'package:shoes_app/widgets/my_font.dart';
import '../data/card.dart';
import '../providers/index_providers.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_tabs.dart';
import '../widgets/grid_view.dart';
import '../widgets/search-bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: CustomScrollView(
          slivers: [
            //App-Bar
            customAppBar(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),

            //Search & Filtering Bar
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //search-bar
                  SizedBox(
                    height: 45,
                    width: screenSize.width * 0.75,
                    child: myTextField(),
                  ),

                  //filtering-bar
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    icon: Image.asset("assets/images/others/filter-icon.png"),
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),

            //Card-Banners
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenSize.height * 0.32,
                child: CarouselSlider.builder(
                  itemCount: cardBanners.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    onPageChanged: (index, reason) {
                      ref.read(cardIndexProvider.notifier).state = index;
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return MyCards(index: index);
                  },
                ),
              ),
            ),

            //
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyFont(
                    title: "Categories",
                    size: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),

                  //seeAll btn
                  TextButton(
                    onPressed: () {},
                    child: const MyFont(
                      title: "See all",
                      size: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

            //TabBar
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: CustomTabBar(),
              ),
            ),

            //padding-top
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),

            //Product-GridView
            const ProductsGridView(),

            //padding-bottom
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: floatingButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }

  //Extracted Widgets

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      backgroundColor: Colors.deepOrange,
      child: const Icon(
        Iconsax.search_favorite,
        color: Colors.white,
      ),
    );
  }
}
