import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';

List<Product> cartShoes = [];

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super(cartShoes);

  void incrementQty(item) {
    final index = state.indexOf(item);
    final updatedItem = item.copyWith(qty: item.qty + 1);

    state = List.from(state)..[index] = updatedItem;
  }

  void decreaseQty(item) {
    final index = state.indexOf(item);
    final updatedItem = item.copyWith(
      //Item quantity cannot be less than 1
      qty: item.qty > 1 ? item.qty - 1 : item.qty,
    );

    state = List.from(state)..[index] = updatedItem;
  }

  void addItem(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeItem(Product product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  bool isInCart(int productID) {
    final cartItems = state;

    for (var item in cartItems) {
      if (item.id == productID) {
        return true;
      }
    }

    return false;
  }

  bool isCartEmpty() {
    return state.isEmpty;
  }

  void removeAll() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>(
  (ref) => CartNotifier(),
);
