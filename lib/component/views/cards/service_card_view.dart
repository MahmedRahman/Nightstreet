import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ServiceCardView extends GetView {
  final String imageUrl;
  final String name;
  final String subTitle;

  final bool hasDiscount;
  final String price;
  final double maxWidth;
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
    required this.subTitle,
    required this.hasDiscount,
    required this.price,
    required this.onFavoriteTapped,
    required this.onTapped,
    required this.rate,
    required this.totalRate,
    this.maxWidth = double.infinity,
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
        this.subTitle = "",
        this.price = '100',
        onFavoriteTapped = null,
        this.onTapped = ondummyTapped,
        this.rate = '4',
        this.maxWidth = double.infinity,
        this.totalRate = '4',
        this.oldPrice = '120';

  static void ondummyTapped() {
    //Get.toNamed(Routes.SERVICE_DETAIL, arguments: 1);
    // Get.to(StorePage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.greyColor4,
        border: Border.all(
          width: 1.0,
          color: AppColors.borderColor2,
        ),
      ),
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        onTap: onTapped,
        child: Row(
          //alignment: Alignment.topLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120,
                    //color: Colors.amber,
                    child: CashedNetworkImageView(
                      height: 75,
                      imageUrl: imageUrl,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
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
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * .5,
                      ),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.blackColor,
                          height: 1.64,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                      ),
                    ),
                    PriceWithDiscountView(
                      price: price,
                      hasDiscount: hasDiscount,
                      oldPrice: oldPrice,
                    ),
                    AppSpacers.height5,
                    RatingBarView(
                      initRating: double.tryParse(rate.toString())!,
                      totalRate: int.tryParse(totalRate.toString()) ?? 0,
                      ignoreGestures: true,
                    )
                  ],
                ),
              ],
            ),
            Spacer(),
            FavoriteIconView(
              width: 35,
              height: 35,
              isFavorite: isFavorite,
              onFavoriteTapped: onFavoriteTapped,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
