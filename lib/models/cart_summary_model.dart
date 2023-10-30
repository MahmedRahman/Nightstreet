// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartSummaryModel {
  String cartCount;
  String cartPrice;
  String cartTax;
  String cartTotalPrice;

  CartSummaryModel({
    required this.cartCount,
    required this.cartPrice,
    required this.cartTax,
    required this.cartTotalPrice,
  });

  factory CartSummaryModel.fromMap(Map<String, dynamic> map) {
    return CartSummaryModel(
      cartCount: map['cart_count'] as String,
      cartPrice: map['cart_price'] as String,
      cartTax: map['cart_tax'] as String,
      cartTotalPrice: map['cart_total_price'] as String,
    );
  }
}
