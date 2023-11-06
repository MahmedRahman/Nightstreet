import 'package:flutter/material.dart';
import 'package:krzv2/utils/app_colors.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.backgroundColor = AppColors.greyColor4,
  });

  final double? height;
  final double? width;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        border: Border.all(
          width: 1.0,
          color: backgroundColor ?? AppColors.borderColor2,
        ),
      ),
      child: child,
    );
  }
}
