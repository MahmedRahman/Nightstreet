import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ServiceCardView extends GetView {
  final String imageUrl;
  final String name;
  final bool hasDiscount;
  final String price;
  final String oldPrice;
  final String rate;
  final String totalRate;
  final EdgeInsetsGeometry? margin;
  final Function()? onFavoriteTapped;
  final Function()? onTapped;

  final bool showFavoriteIcon;
  final bool isFavorite;

  ServiceCardView({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.hasDiscount,
    required this.price,
    required this.onFavoriteTapped,
    required this.onTapped,
    required this.rate,
    required this.totalRate,
    this.oldPrice = '',
    this.margin,
    this.showFavoriteIcon = true,
    this.isFavorite = false,
  }) : super(key: key);

  ServiceCardView.dummy({
    Key? key,
    this.showFavoriteIcon = true,
    this.margin,
    this.isFavorite = false,
  })  : this.imageUrl = 'assets/image/dummy/dummy_service.png',
        this.name =
            'لسوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وقة خالية من التمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من  السوداء و',
        this.hasDiscount = false,
        this.price = '100',
        onFavoriteTapped = null,
        this.onTapped = ondummyTapped,
        this.rate = '4',
        this.totalRate = '4',
        this.oldPrice = '120';

  static void ondummyTapped() {
    Get.toNamed(Routes.SERVICE_DETAIL, arguments: 1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onTapped,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.only(left: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 4,
                top: 6,
                bottom: 6,
                left: 8,
              ),
              child: Stack(
                children: [
                  CashedNetworkImageView(
                    width: 94,
                    height: 94,
                    imageUrl: imageUrl,
                    boxFit: BoxFit.cover,
                  ),
                  showFavoriteIcon
                      ? InkWell(
                          onTap: onFavoriteTapped,
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          child: Container(
                            width: 22.0,
                            height: 22.0,
                            margin: EdgeInsets.only(
                              right: 10,
                              top: 6,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor4,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                isFavorite
                                    ? AppSvgAssets.solidHeartIcon
                                    : AppSvgAssets.heartIcon,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * .5,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.blackColor,
                      height: 1.64,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ),
                AppSpacers.height5,
                PriceWithDiscountView(
                  price: price,
                  hasDiscount: hasDiscount,
                  oldPrice: oldPrice,
                ),
                AppSpacers.height5,
                RatingBarView(
                  initRating: double.tryParse(rate.toString())!,
                  totalRate: int.tryParse(totalRate.toString())!,
                  ignoreGestures: true,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
