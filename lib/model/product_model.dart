class Product {
  final int id;
  final String category;
  final String productName;
  final String type;
  final double price;
  final int qty;
  bool isSelected;
  bool isFavorite;
  final List productImages;
  final int selectedSize;
  final String sizeStandard;
  final int discount;
  final String noOfRatings;
  final double noOfStars;
  final String description;

  Product({
    required this.id,
    required this.productName,
    required this.category,
    required this.type,
    required this.price,
    this.qty = 1,
    this.isSelected = false,
    this.isFavorite = false,
    required this.productImages,
    this.selectedSize = 42,
    this.sizeStandard = "US",
    required this.discount,
    required this.noOfRatings,
    required this.noOfStars,
    required this.description,
  });

  Product copyWith({
    int? id,
    String? category,
    String? productName,
    String? type,
    double? price,
    int? qty,
    bool? isSelected,
    bool? isFavorite,
    List? productImages,
    int? selectedSize,
    String? sizeStandard,
    int? discount,
    String? noOfRatings,
    double? noOfStars,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      productName: productName ?? this.productName,
      type: type ?? this.type,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      isSelected: isSelected ?? this.isSelected,
      isFavorite: isFavorite ?? this.isSelected,
      productImages: productImages ?? this.productImages,
      selectedSize: selectedSize ?? this.selectedSize,
      sizeStandard: sizeStandard ?? this.sizeStandard,
      discount: discount ?? this.discount,
      noOfRatings: noOfRatings ?? this.noOfRatings,
      noOfStars: noOfStars ?? this.noOfStars,
      description: description ?? this.description,
    );
  }
}
