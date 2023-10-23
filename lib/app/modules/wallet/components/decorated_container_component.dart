import 'package:flutter/material.dart';
import 'package:krzv2/utils/app_colors.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.greyColor4,
        border: Border.all(
          width: 1.0,
          color: AppColors.borderColor2,
        ),
      ),
      child: child,
    );
  }
}
