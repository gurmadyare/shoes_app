import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoes_app/controllers/cart_controller.dart';
import 'package:shoes_app/controllers/product_controller.dart';
import 'package:shoes_app/widgets/circle_button.dart';
import 'package:shoes_app/widgets/my_font.dart';

import '../model/product_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProvider);

    double calculateTaxProducts(List<Product> totalProducts) {
      const taxPercentage = 0.02; //2%
      double taxAmount = 0;

      for (var product in totalProducts) {
        taxAmount += product.qty * product.price * taxPercentage;
      }

      return taxAmount;
    }

    double calculateDiscount(List<Product> totalProducts) {
      double totalDiscount = 0;

      for (final product in totalProducts) {
        totalDiscount +=
            (product.discount) / 100 * (product.qty * product.price);
      }

      return totalDiscount;
    }

    double calculateTotalCost(List<Product> totalProducts) {
      double totalCost = 0;

      for (var product in totalProducts) {
        totalCost += product.qty * product.price;
      }

      return totalCost;
    }

    String totalIncludingTax(List<Product> totalProducts) {
      const taxPercentage = 0.02; //2%
      double totalDiscount = 0;
      double totalCost = 0;
      double totalTax = 0;
      const deliveryFee = 3;

      for (var product in totalProducts) {
        totalCost += product.qty * product.price;
        totalTax += product.qty * product.price * taxPercentage;
        totalDiscount +=
            (product.discount) / 100 * (product.qty * product.price);
      }

      return (totalCost - totalDiscount + (deliveryFee + totalTax))
          .toStringAsFixed(2);
    }

    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
            child: Row(
              children: [
                Image.asset("assets/images/others/basket.png", width: 80),
                MyFont(
                  title: "Order summary",
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 45),

                // Remove All
                TextButton(
                  onPressed: () {
                    // Remove all products from the cart
                    ref.read(cartProvider.notifier).removeAll();

                    //Remove all selection states from Home
                    ref.read(productsProvider.notifier).removeSelections();
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

          // Cart Products
          if (cartProducts.isNotEmpty)
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final item = cartProducts[index];

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
                          const Icon(
                            Iconsax.star1,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(item.noOfStars.toString()),
                          const SizedBox(width: 30),

                          // noOfItems decreasion
                          MyIconButton(
                            icon: Iconsax.minus4,
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .decreaseQty(cartProducts[index]);
                            },
                          ),
                          const SizedBox(width: 10),

                          //noOfItems
                          MyFont(
                            title: "${cartProducts[index].qty}",
                            color: Colors.black,
                          ),

                          // noOfItems increasion

                          const SizedBox(width: 5),

                          MyIconButton(
                            icon: Icons.add,
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .incrementQty(cartProducts[index]);
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Remove the item
                          ref
                              .read(cartProvider.notifier)
                              .removeItem(cartProducts[index]);

                          //And toggle its isSelected
                          ref
                              .read(productsProvider.notifier)
                              .toggleSelection(cartProducts[index].id);
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
                  title: "Your cart is empty",
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),

          // Footer Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyFont(
                  title: "Have a coupon code?",
                  size: 14,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),

                // Coupon code
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: " F29201D",
                              hintStyle: TextStyle(fontSize: 18),
                              border: InputBorder.none),
                        ),
                      ),
                      Row(
                        children: [
                          MyFont(
                            title: "Available",
                            size: 15,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(width: 10),

                          // available?
                          Icon(Icons.check_circle)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Sub-total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyFont(
                      title: "   SUBTOTAL: ",
                      size: 12,
                      color: Colors.black,
                    ),
                    MyFont(
                      title:
                          "\$${calculateTotalCost(cartProducts).toStringAsFixed(2)} ",
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 5),

                // Delivery fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyFont(
                      title: "   DELIVERY FEE: ",
                      size: 12,
                      color: Colors.black,
                    ),
                    MyFont(
                      title: "\$${cartProducts.isEmpty ? "0.00 " : "3.00"}",
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 5),

                // Discount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyFont(
                      title: "   DISCOUNT: ",
                      size: 12,
                      color: Colors.black,
                    ),
                    MyFont(
                      title:
                          "\$${calculateDiscount(cartProducts).toStringAsFixed(2)} ",
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // Taxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyFont(
                      title: "   Taxes: ",
                      size: 12,
                      color: Colors.black,
                    ),
                    MyFont(
                      title:
                          "\$${calculateTaxProducts(cartProducts).toStringAsFixed(2)} ",
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyFont(
                      title: "   TOTAL (INCLUDING TAX): ",
                      size: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                    //
                    MyFont(
                      title: "\$${totalIncludingTax(cartProducts)} ",
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // Pay Now
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite, 30),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const MyFont(title: "PAY NOW"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
