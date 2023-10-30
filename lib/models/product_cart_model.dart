// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductCartModel {
  final int productId;
  final int cartItemId;
  final int? variantId;
  final String productImage;
  final String productName;
  final num price;
  final num oldPrice;
  final int quantity;
  ProductCartModel({
    required this.productId,
    required this.cartItemId,
    required this.productImage,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.quantity,
    this.variantId,
  });

  factory ProductCartModel.fromMap(Map<String, dynamic> map) {
    return ProductCartModel(
      productId: map['product']['id'] as int,
      cartItemId: map['cart_item_id'] as int,
      variantId: map['variant'] != null ? map['variant']['id'] as int : null,
      productImage: map['product']['image'] as String,
      productName: map['product']['name'] as String,
      price: map['product_price'] as num,
      oldPrice: map['product']['old_price'] as num,
      quantity: map['quantity'] as int,
    );
  }
}
