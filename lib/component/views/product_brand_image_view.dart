import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';

class ProductBrandImageView extends GetView {
  const ProductBrandImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      //height: 40,
      width: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: CashedNetworkImageView(
          imageUrl: imageUrl,
          width: double.infinity,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
