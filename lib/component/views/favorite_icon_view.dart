import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class FavoriteIconView extends GetView {
  const FavoriteIconView({
    Key? key,
    required this.isFavorite,
    required this.onFavoriteTapped,
    this.width = 40,
    this.height = 40,
    this.backgroundColor,
  }) : super(key: key);

  final Function()? onFavoriteTapped;
  final Color? backgroundColor;

  final bool isFavorite;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onFavoriteTapped,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: DecoratedContainer(
        backgroundColor: backgroundColor,
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            isFavorite ? AppSvgAssets.solidHeartIcon : AppSvgAssets.heartIcon,
          ),
        ),
      ),
    );
  }
}
