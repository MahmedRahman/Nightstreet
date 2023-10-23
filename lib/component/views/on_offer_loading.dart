import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/image_swpier_view.dart';
import 'package:krzv2/component/views/product_brand_image_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class OnOfferLoadingView extends GetView {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimension.appPadding,
      children: [
        AppSpacers.height12,
        ImageSwpierView(
          images: [
            "https://cdn.sanity.io/images/27438tds/rexona-prod-us/968cf54d49121f455975bc443ee1a9a2cf047d69-2880x2880.jpg?w=500&h=500&q=80&auto=format",
          ],
        ).shimmer(),
        AppSpacers.height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductBrandImageView(
              imageUrl: '',
            ).shimmer(),
            Row(
              children: [
                DecoratedContainer(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ).shimmer(),
                AppSpacers.width10,
                DecoratedContainer(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ).shimmer(),
              ],
            )
          ],
        ),
      ],
    );
  }
}
