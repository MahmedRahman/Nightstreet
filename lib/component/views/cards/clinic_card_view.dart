import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ClinicCardView extends GetView {
  final String imageUrl;
  final String name;

  final String oldPrice;
  final String rate;
  final String totalRate;
  final String distance;
  final bool isFavorite;
  final Function()? onFavoriteTapped;
  void Function()? onTap;
  ClinicCardView({
    required this.imageUrl,
    required this.name,
    required this.onFavoriteTapped,
    required this.rate,
    required this.totalRate,
    required this.isFavorite,
    required this.distance,
    required this.onTap,
    this.oldPrice = '',
  });

  ClinicCardView.dummy()
      : this.imageUrl = 'assets/image/dummy/dummy_service.png',
        this.name =
            'لسوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وقة خالية من التمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من  السوداء و',
        onFavoriteTapped = null,
        this.rate = '4',
        this.totalRate = '4',
        this.distance = '4',
        this.isFavorite = false,
        this.oldPrice = '120';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageAndFavoriteIcon(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacers.height10,
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
                    RatingBarView(
                      initRating: double.tryParse(rate.toString())!,
                      totalRate: double.tryParse(totalRate.toString())!,
                      ignoreGestures: true,
                    ),
                    AppSpacers.height5,
                    (int.tryParse(distance) == 0)
                        ? SizedBox.shrink()
                        : Row(
                            children: [
                              SvgPicture.asset("assets/svg/maps.svg"),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '$distance كم',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 12.0,
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w500,
                                  height: 1.58,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
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

  Padding imageAndFavoriteIcon() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 4,
        top: 6,
        bottom: 6,
        left: 8,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 94,
            height: 94,
            child: CashedNetworkImageView(
              imageUrl: imageUrl,
            ),
          ),
        ],
      ),
    );
  }
}
