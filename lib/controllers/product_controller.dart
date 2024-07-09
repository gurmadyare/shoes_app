import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/products.dart';
import '../model/product_model.dart';

class ProductController extends StateNotifier<List<Product>> {
  ProductController() : super(shoes);

  // Other product-related methods (e.g: addProduct, removeProduct, updateProduct)
  void toggleSelection(int pid) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(isSelected: !product.isSelected)
        else
          product
    ];
  }

  void toggleIsFavorite(int pid) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(isFavorite: !product.isFavorite)
        else
          product
    ];
  }

  void updateSelectedSize(int pid, int newSize) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(selectedSize: newSize)
        else
          product
    ];
  }

  void updateShoeSizeStandard(int pid, String newsizeStandard) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(sizeStandard: newsizeStandard)
        else
          product
    ];
  }

  void removeSelections() {
    state = [
      for (final product in state) product.copyWith(isSelected: false),
    ];
  }

  void removeAllFavorites() {
    state = [for (final product in state) product.copyWith(isFavorite: false)];
  }
}

final productsProvider =
    StateNotifierProvider<ProductController, List<Product>>(
  (ref) => ProductController(),
);
