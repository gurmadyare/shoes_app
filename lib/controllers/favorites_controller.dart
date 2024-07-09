import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';

List<Product> favoriteProducts = [];

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super(favoriteProducts);

  void addProduct(Product favoritePr) {
    if (!state.contains(favoritePr)) {
      state = [...state, favoritePr];
    }
  }

  void removeProduct(Product product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  void removeAll() {
    state = [];
  }

  bool isInFavorites(int productID) {
    for (final product in state) {
      if (product.id == productID) return true;
    }

    return false;
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>(
  (ref) => FavoritesNotifier(),
);
