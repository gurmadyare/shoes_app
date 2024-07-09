import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoes_app/controllers/cart_controller.dart';
import 'package:shoes_app/controllers/favorites_controller.dart';
import 'package:shoes_app/providers/index_providers.dart';
import 'package:shoes_app/screens/cart_screen.dart';
import 'package:shoes_app/screens/favorites_screen.dart';
import 'package:shoes_app/widgets/my_font.dart';

class MyBottomAppBar extends ConsumerWidget {
  const MyBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      height: 55,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              //update the currentBottomIndex
              ref.read(currentBottomIndexProvider.notifier).state = 0;
            },
            icon: const Icon(Iconsax.home, size: 35),
          ),
          Consumer(builder: (context, ref, child) {
            //lets watch the favorites screen products
            final favoriteProducts = ref.watch(favoritesProvider);

            return Badge(
              label: MyFont(title: "${favoriteProducts.length}", size: 14),
              largeSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              backgroundColor: Colors.red,
              child: IconButton(
                color: Colors.grey,
                onPressed: () {
                  //update the currentBottomIndex
                  ref.read(currentBottomIndexProvider.notifier).state = 1;

                  //navigate to the favorites screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FavoritesScreen();
                  }));
                },
                icon: const Icon(Icons.favorite_border, size: 35),
              ),
            );
          }),
          const SizedBox(width: 30),

          //Bag-Items
          Consumer(builder: (context, ref, child) {
            final itemBag = ref.watch(cartProvider);

            return Badge(
              largeSize: 22,
              backgroundColor: Colors.red,
              label: MyFont(
                title: "${itemBag.length}",
                size: 14,
              ),
              child: IconButton(
                color: Colors.grey,
                onPressed: () {
                  //update the currentBottomIndex
                  ref.read(currentBottomIndexProvider.notifier).state = 2;

                  //navigate to the cart screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CartScreen();
                  }));
                },
                icon: const Icon(Iconsax.shopping_bag, size: 35),
              ),
            );
          }),

          IconButton(
            color: Colors.grey,
            onPressed: () {
              //update the currentBottomIndex
              ref.read(currentBottomIndexProvider.notifier).state = 3;
            },
            icon: const Icon(Iconsax.setting, size: 35),
          ),
        ],
      ),
    );
  }
}
