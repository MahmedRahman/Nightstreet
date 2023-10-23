import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ProductCardView extends GetView {
  final String imageUrl;
  final String name;
  final bool hasDiscount;
  final String price;
  final String oldPrice;
  final String rate;
  final bool isLimitedQuantity;
  final bool isFavorite;

  final void Function()? onAddToCartTapped;
  final void Function()? onFavoriteTapped;
  final void Function()? onTap;

  const ProductCardView({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.hasDiscount,
    required this.price,
    required this.onAddToCartTapped,
    required this.onFavoriteTapped,
    required this.isFavorite,
    required this.onTap,
    this.oldPrice = '',
    this.rate = '',
    this.isLimitedQuantity = false,
  }) : super(key: key);

  ProductCardView.dummy({Key? key, this.onTap})
      : imageUrl = 'assets/image/dummy/dummy_product.png',
        name = 'مضاد التعرق كول راش من ديجري مين، يدوم ..لمدة 48 ساعة',
        hasDiscount = false,
        price = '1760',
        rate = '4.9',
        onAddToCartTapped = null,
        onFavoriteTapped = null,
        isFavorite = false,
        oldPrice = '',
        isLimitedQuantity = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.toNamed(Routes.PRODUCT_DETAILS),
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 8),
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage(imageUrl: imageUrl),
            AppSpacers.height10,
            Text(
              name,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.14,
                height: 1.64,
              ),
              maxLines: 3,
              textAlign: TextAlign.right,
            ),
            AppSpacers.height10, // Group: Group 21784
            PriceWithDiscountView(
              price: price,
              hasDiscount: oldPrice != '0.0',
              oldPrice: oldPrice,
            ),
            AppSpacers.height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _addToCart()),
                AppSpacers.width10,
                _favouriteButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productImage({required String imageUrl}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CashedNetworkImageView(
            height: 134,
            width: double.infinity,
            imageUrl: imageUrl,
            boxFit: BoxFit.cover,
            // 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1646077574-screen-shot-2022-02-28-at-2-39-10-pm-1646077556.png?crop=1xw:0.9974358974358974xh;center,top&resize=980:*',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLimitedQuantityBadge(
                isLimitedQuantity: isLimitedQuantity,
              ),
              buildRatingBadge(rate: rate),
            ],
          ),
        )
      ],
    );
  }

  Widget buildRatingBadge({required String rate}) {
    if (rate == '' || rate == '0') return SizedBox();
    return Container(
      alignment: Alignment.center,
      width: 38.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white.withOpacity(0.95),
      ),
      child: SizedBox(
        height: 12.16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppSvgAssets.selectedStarIcon,
              ),
            ),
            Text(
              rate,
              style: TextStyle(
                fontSize: 12.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLimitedQuantityBadge({required bool isLimitedQuantity}) {
    if (isLimitedQuantity == false) return SizedBox();
    return Container(
      width: 60.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.mainColor,
      ),
      child: Center(
        child: Text(
          'الكمية محدودة',
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  InkWell _favouriteButton() {
    return InkWell(
      onTap: onFavoriteTapped,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        alignment: Alignment.center,
        width: 28.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: SvgPicture.asset(
          isFavorite ? AppSvgAssets.solidHeartIcon : AppSvgAssets.heartIcon,
        ),
      ),
    );
  }

  InkWell _addToCart() {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onAddToCartTapped,
      child: Container(
        alignment: const Alignment(0.07, 0.0),
        width: 100.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: const Text(
          'إضافة للسلة',
          style: TextStyle(
            fontSize: 13.0,
            color: AppColors.blackColor,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
