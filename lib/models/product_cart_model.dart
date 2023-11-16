import 'package:krzv2/models/cart_summary_model.dart';

class MarketShippingCart {
  final int marketId;
  final String marketName;
  final String marketImage;
  final int marketProductCount;
  final List<ProductCartModel> products;
  final CartSummaryModel summary;
  MarketShippingCart({
    required this.marketId,
    required this.marketName,
    required this.marketImage,
    required this.marketProductCount,
    required this.products,
    required this.summary,
  });

  factory MarketShippingCart.fromMap(Map<String, dynamic> map) {
    return MarketShippingCart(
      marketId: map['id'] as int,
      marketName: map['name'] as String,
      marketImage: map['image'] as String,
      marketProductCount: map['product_count'] as int,
      products: List<ProductCartModel>.from(
        (map['products'] as List<dynamic>).map<ProductCartModel>(
          (x) => ProductCartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      summary: CartSummaryModel.fromMap(
        map['cart'],
      ),
    );
  }
}

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
