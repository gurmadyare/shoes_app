import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoes_app/controllers/favorites_controller.dart';
import 'package:shoes_app/controllers/product_controller.dart';
import 'package:shoes_app/widgets/my_font.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoritesProvider);

    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
            child: Row(
              children: [
                Image.asset("assets/images/others/delivery.png", width: 80),
                const SizedBox(width: 10),
                MyFont(
                  title: "Favorite products",
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 35),

                // Remove All
                TextButton(
                  onPressed: () {
                    // Remove all products from the cart
                    ref.read(favoritesProvider.notifier).removeAll();

                    //Remove all selection states from Home
                    ref.read(productsProvider.notifier).removeAllFavorites();
                  },
                  child: MyFont(
                    title: "Remove all",
                    color: Colors.grey.shade700,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),

          // Favorite Products
          if (favoriteProducts.isNotEmpty)
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final item = favoriteProducts[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListTile(
                      leading: Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          item.productImages[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(item.productName),
                      ),
                      subtitle: Row(
                        children: [
                          // No of stars
                          const Icon(
                            Iconsax.star1,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(item.noOfStars.toString()),

                          //
                          const SizedBox(width: 20),

                          // selectedSize
                          MyFont(
                            title:
                                "size: ${item.selectedSize}   (${item.sizeStandard})",
                            color: Colors.black,
                            size: 14,
                          )
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Remove the item
                          ref
                              .read(favoritesProvider.notifier)
                              .removeProduct(favoriteProducts[index]);

                          //And toggle its isFavorite
                          ref
                              .read(productsProvider.notifier)
                              .toggleIsFavorite(favoriteProducts[index].id);
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: MyFont(
                  title: "Your favorites is empty",
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
