class ProductModel{
  int productId;
  String productName;
  String productPrice;
  String productDescr;
  String productImage;
  String productCategory;
  String? originalCategory;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescr,
    required this.productImage,
    required this.productCategory,
    this.originalCategory,
});
}