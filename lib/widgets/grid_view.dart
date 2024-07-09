import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app/controllers/cart_controller.dart';
import 'package:shoes_app/controllers/favorites_controller.dart';
import 'package:shoes_app/controllers/product_controller.dart';
import '../providers/index_providers.dart';
import '../screens/details_screen.dart';
import 'icon_container.dart';
import 'my_font.dart';

class ProductsGridView extends ConsumerWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoes = ref.watch(productsProvider);

    //tabIndex & category type
    final tabIndex = ref.watch(tabsIndexProvider);

    final category = tabIndex == 0
        ? 'Nike'
        : tabIndex == 1
            ? 'Jordan'
            : tabIndex == 3
                ? 'Adidas'
                : '';

    // current tab products
    final categoryShoes =
        shoes.where((shoe) => shoe.category == category).toList();

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 5.0,
        mainAxisExtent: 245,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailsScreen(currentShoe: categoryShoes[index]);
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(15, 5),
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      SizedBox(
                        height: 85,
                        width: 200,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                            categoryShoes[index].productImages[0],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Name
                      SizedBox(
                        width: 130,
                        child: MyFont(
                          title: categoryShoes[index].productName,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Type
                      MyFont(
                        title: categoryShoes[index].type,
                        color: Colors.grey,
                        size: 13,
                      ),
                      // Price
                      const SizedBox(height: 8),
                      MyFont(
                        title: "\$${categoryShoes[index].price}",
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              // Discount
              Positioned(
                top: 15,
                left: 10,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyFont(
                        title: "${categoryShoes[index].discount}%",
                        size: 12,
                      ),
                      const MyFont(
                        title: "Off",
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ),
              // Add to favorites
              Positioned(
                top: 120,
                right: 5,
                child: IconContainer(
                    icon: categoryShoes[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline_sharp,
                    onPressed: () {
                      // First, lets toggleIsFavorite
                      ref
                          .read(productsProvider.notifier)
                          .toggleIsFavorite(categoryShoes[index].id);

                      //Then, lets add/remove it to/from favorites
                      final favoritesNotifier =
                          ref.read(favoritesProvider.notifier);

                      if (!categoryShoes[index].isFavorite) {
                        favoritesNotifier.addProduct(categoryShoes[index]);
                      } else {
                        favoritesNotifier.removeProduct(categoryShoes[index]);
                      }
                    }),
              ),

              // Add to cart
              Positioned(
                right: 0,
                bottom: 5,
                child: ElevatedButton(
                  onPressed: () {
                    //first change isSelected state
                    ref
                        .read(productsProvider.notifier)
                        .toggleSelection(categoryShoes[index].id);

                    //then, add/remove item from the cart
                    final cartNotifier = ref.read(cartProvider.notifier);

                    if (!categoryShoes[index].isSelected) {
                      cartNotifier.addItem(categoryShoes[index]);
                    } else {
                      cartNotifier.removeItem(categoryShoes[index]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(30, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(13),
                      ),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Center(
                    child: Icon(
                      categoryShoes[index].isSelected
                          ? Icons.done_outline_sharp
                          : Icons.add_shopping_cart_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        // Adjust childCount based on available data
        childCount: categoryShoes.length,
      ),
    );
  }
}
