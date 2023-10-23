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
  }) : super(key: key);

  final Function() onFavoriteTapped;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onFavoriteTapped,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: DecoratedContainer(
        width: 40,
        height: 40,
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
