import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shoes_app/controllers/cart_controller.dart';
import 'package:shoes_app/controllers/product_controller.dart';
import 'package:shoes_app/model/product_model.dart';
import 'package:shoes_app/widgets/circle_button.dart';
import 'package:shoes_app/widgets/icon_container.dart';
import 'package:shoes_app/widgets/my_font.dart';
import 'package:shoes_app/widgets/text_button.dart';

import '../controllers/favorites_controller.dart';
import '../providers/index_providers.dart';

final List<int> shoeSizes = [38, 40, 42, 43, 44, 46];
List<String> shoeStandards = ["US", "UK", "EU"];

class DetailsScreen extends ConsumerWidget {
  final Product currentShoe;
  const DetailsScreen({super.key, required this.currentShoe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if currentShoe is null before accessing its properties

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      body: CustomScrollView(
        slivers: [
          //CustomAppBar
          SliverPadding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            sliver: SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              leading: IconContainer(
                icon: Icons.keyboard_backspace_rounded,
                bgColor: Colors.white,
                iconColor: Colors.black,
                isPadding: true,
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Consumer(builder: (context, ref, child) {
                  final product = ref
                      .watch(productsProvider)
                      .firstWhere((shoe) => shoe.id == currentShoe.id);

                  return IconContainer(
                    icon: Icons.favorite_outline_sharp,
                    bgColor: product.isFavorite ? Colors.orange : Colors.white,
                    iconColor:
                        product.isFavorite ? Colors.white : Colors.deepOrange,
                    isPadding: true,
                    onPressed: () {
                      // Toggle isFavorite
                      ref
                          .read(productsProvider.notifier)
                          .toggleIsFavorite(currentShoe.id);

                      //then, add/remove item from the cart
                      final favoritesNotifier =
                          ref.read(favoritesProvider.notifier);

                      if (!product.isFavorite) {
                        favoritesNotifier.addProduct(product);
                      } else {
                        favoritesNotifier.removeProduct(product);
                      }
                    },
                  );
                })
              ],
            ),
          ),

          //Image
          SliverToBoxAdapter(
            child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Consumer(builder: (context, ref, child) {
                  final shoeImageIndex = ref.watch(shoeImageIndexProvider);
                  return Image.asset(
                    currentShoe.productImages[shoeImageIndex],
                    fit: BoxFit.cover,
                  );
                })),
          ),

          // Use Expanded for the last container
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //shoe-type
                  MyFont(
                    title: currentShoe.type,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),

                  //shoe-name
                  MyFont(
                    title: currentShoe.productName,
                    color: Colors.black,
                    size: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),

                  //Ratings
                  Row(
                    children: [
                      //star
                      const Icon(Iconsax.star1, color: Colors.orange),
                      const SizedBox(width: 10),

                      //no-of-stars
                      MyFont(
                        title: "${currentShoe.noOfStars}",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        size: 16,
                      ),
                      const SizedBox(width: 10),

                      //no-of-ratings
                      MyFont(
                        title: "(${currentShoe.noOfRatings} Ratings)",
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        size: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  //Description
                  ReadMoreText(
                    currentShoe.description,
                    style: TextStyle(color: Colors.grey.shade700),
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    textAlign: TextAlign.justify,
                    trimCollapsedText: "Read more",
                    trimExpandedText: "  Read less",
                    moreStyle: const TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(color: Colors.deepOrange),
                  ),
                  const SizedBox(height: 20),

                  //Select shoeColor
                  const MyFont(
                    title: "Colors",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ref.read(shoeImageIndexProvider.notifier).state =
                                  index;
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(15, 15),
                                      color: Colors.white,
                                      spreadRadius: 0.1,
                                      blurRadius: 20,
                                    )
                                  ]),
                              child: Image.asset(
                                currentShoe.productImages[index],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 20),

                  //Select shoeSize
                  Consumer(builder: (context, ref, child) {
                    // lets watch selected standard
                    final currStandardIndex = ref.watch(selectedSizeStandard);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        const MyFont(
                          title: "shoe standard",
                          color: Colors.grey,
                          size: 14,
                        ),

                        //
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: ListView.builder(
                            itemCount: shoeStandards.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MyTextButton(
                                text: shoeStandards[index],
                                color: currStandardIndex == index
                                    ? Colors.deepOrangeAccent
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                onPressed: () {
                                  // first update the ui state
                                  ref
                                      .read(selectedSizeStandard.notifier)
                                      .state = index;

                                  //then, lets update its sizeStandard in controller
                                  ref
                                      .read(productsProvider.notifier)
                                      .updateShoeSizeStandard(
                                        currentShoe.id,
                                        shoeStandards[index],
                                      );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 10),

                  //actual sizes
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      itemCount: shoeSizes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Consumer(builder: (context, ref, child) {
                          final selectedShoeIndex =
                              ref.watch(selectedSizeIndexProvider);

                          return GestureDetector(
                            onTap: () {
                              // first update selectedSizeIndex state
                              ref
                                  .read(selectedSizeIndexProvider.notifier)
                                  .state = index;

                              // then lets update selectedSize in the product model
                              ref
                                  .read(productsProvider.notifier)
                                  .updateSelectedSize(
                                    currentShoe.id,
                                    shoeSizes[index],
                                  );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(10),
                                border: selectedShoeIndex == index
                                    ? Border.all(
                                        color: Colors.deepPurple,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: MyFont(
                                title: "${shoeSizes[index]}",
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Price & addToCart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyFont(
                            title: "Price",
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(height: 10),
                          MyFont(
                            title: "\$${currentShoe.price}",
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),

                      //addToCart
                      ElevatedButton.icon(
                        onPressed: () {
                          //Add to cart or "inCart message" & update the isSelection state
                          final cartNotifier = ref.read(cartProvider.notifier);
                          String cartMessage = "";
                          bool isInCart;

                          if (cartNotifier.isInCart(currentShoe.id) != true) {
                            cartNotifier.addItem(currentShoe);
                            //update the cart message
                            isInCart = false;
                            cartMessage = "Added to cart successfully!";

                            //
                            ref
                                .read(productsProvider.notifier)
                                .toggleSelection(currentShoe.id);
                          } else {
                            isInCart = true;
                            cartMessage = "Product is already in cart 🤷‍♂️";
                          }

                          // Show a snackbar to indicate that the product
                          // has been added to cart successfully

                          final snackBar = SnackBar(
                            duration: const Duration(milliseconds: 700),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //
                                if (!isInCart)
                                  const MyIconButton(
                                    icon: Icons.done,
                                    size: 45,
                                    color: Colors.green,
                                  ),

                                //cart message

                                MyFont(title: cartMessage),
                              ],
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(200, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        label: const MyFont(title: "  Add to Cart", size: 14),
                        icon: const Icon(
                          Iconsax.shopping_bag,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
