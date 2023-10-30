import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/show_more_button_view.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductsHotizontalListView extends GetView {
  final List<ProductModel> productsList;

  final String showMoreText;
  final VoidCallback onShowMoreTapped;
  final Function(int productId)? onAddToCartTapped;
  final Function(int productId)? onFavoriteTapped;
  final Function(int productId)? onTap;

  const ProductsHotizontalListView({
    Key? key,
    required this.productsList,
    required this.showMoreText,
    required this.onShowMoreTapped,
    required this.onAddToCartTapped,
    required this.onFavoriteTapped,
    required this.onTap,
  }) : super(key: key);

  const ProductsHotizontalListView.recommended({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    required this.onAddToCartTapped,
    required this.onFavoriteTapped,
    required this.onTap,
  })  : showMoreText = 'منتجات قد تعجبك',
        super(key: key);

  const ProductsHotizontalListView.mostWanted({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "الأكثر طلبا",
        super(key: key);

  const ProductsHotizontalListView.exclusiveOffers({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "العروض الحصرية",
        super(key: key);

  const ProductsHotizontalListView.similarproducts({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "منتجات المشابهة",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowMoreButtonView(
          onShowMoreTapped: onShowMoreTapped,
          title: showMoreText,
        ),
        AppSpacers.height16,
        SizedBox(
          height: 255,
          child: ListView.builder(
            itemCount: productsList.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              final product = productsList.elementAt(index);
              return ProductCardView(
                imageUrl: product.image,
                name: product.name,
                hasDiscount: false,
                oldPrice: product.oldPrice.toString(),
                price: product.price.toString(),
                onAddToCartTapped: () => onAddToCartTapped!(product.id),
                onFavoriteTapped: () => onFavoriteTapped!(product.id),
                isFavorite: product.isFavorite,
                isLimitedQuantity: product.quantity < 10,
                onTap: () => onTap!(product.id),
              );
            },
          ),
        )
      ],
    );
  }
}
