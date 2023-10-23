import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeBannerView extends GetView {
  final String imageUrl;
  const HomeBannerView({
    super.key,
    required this.imageUrl,
  });

  HomeBannerView.dummy({
    Key? key,
  }) : imageUrl = 'assets/image/dummy/offers.png';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: context.width,
        height: 150,
      ),
    );
  }
}
