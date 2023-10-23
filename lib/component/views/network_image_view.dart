import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class NetworkImageView extends GetView {
  final String imageUrl;
  final BoxFit? fit;
  const NetworkImageView({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: double.infinity,
      loadingBuilder: (
        _,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: SpinKitCircle(
            color: AppColors.mainColor,
            size: 70,
          ),
        );
      },
    );
  }
}
