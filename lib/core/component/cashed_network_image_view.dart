import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CashedNetworkImageView extends GetView {
  const CashedNetworkImageView({
    Key? key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.width = double.infinity,
    this.height = 55,
    this.borderRadius,
  }) : super(key: key);

  final String imageUrl;
  // final String errorAssetimage = "assets/images/place_holder_image.jpeg";
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: boxFit,
        placeholder: (context, url) => Image.asset(
          'images/png/place_holder_image.jpeg',
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'images/png/place_holder_image.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
