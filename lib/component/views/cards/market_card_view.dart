import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:html/parser.dart';

class MarketCardView extends GetView {
  final String imageUrl;
  final String name;
  final String desc;
  final double maxWidth;
  final bool? displayFullDesc;
  final Function()? onFavoriteTapped;
  final Function()? onTapped;

  final bool showFavoriteIcon;
  final bool isFavorite;

  MarketCardView({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.desc,
    this.displayFullDesc = false,
    required this.onFavoriteTapped,
    required this.onTapped,
    this.maxWidth = double.infinity,
    this.showFavoriteIcon = true,
    this.isFavorite = false,
  }) : super(key: key);

  MarketCardView.dummy({
    Key? key,
    this.showFavoriteIcon = true,
    this.displayFullDesc = false,
    this.isFavorite = false,
  })  : this.imageUrl = 'assets/image/dummy/dummy_service.png',
        this.name =
            'لسوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وقة خالية من التمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من الرؤس السوداء وتمتعي ببشرة مشرقة خالية من  السوداء و',
        desc = '',
        onFavoriteTapped = null,
        this.onTapped = ondummyTapped,
        this.maxWidth = double.infinity;
  static void ondummyTapped() {
    //Get.toNamed(Routes.SERVICE_DETAIL, arguments: 1);
    //Get.to(StorePage());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onTapped,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
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
                    if (desc != 'null')
                      Container(
                        color: Colors.transparent,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * .6,
                        ),
                        child: displayFullDesc!
                            ? Html(data: desc)
                            : Text(
                                _parseHtmlString(desc),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                  ],
                ),
              ],
            ),
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
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
