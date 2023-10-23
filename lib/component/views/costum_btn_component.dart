import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomBtnCompenent extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color backgroundColor;
  final Color titleColor;
  final double? width;
  final double? height;
  final String? iconPath;

  const CustomBtnCompenent({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.titleColor,
    this.width,
    this.height = 52,
    this.iconPath,
  });

  const CustomBtnCompenent.main({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.iconPath,
    this.height = 52,
  })  : backgroundColor = const Color(0xff7D3A5B),
        titleColor = Colors.white;

  const CustomBtnCompenent.secondary({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.iconPath,
    this.height = 52,
  })  : backgroundColor = const Color(0xffF5F6FA),
        titleColor = AppColors.blackColor;

  const CustomBtnCompenent.red({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.iconPath,
    this.height = 52,
  })  : backgroundColor = AppColors.errorColor,
        titleColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: height,
      width: width ?? size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: btnShape,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != '')
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  iconPath ?? '',
                  color: Colors.white,
                ),
              ),
            Text(
              text,
              style: TextStyle(
                color: titleColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialStateProperty<OutlinedBorder> get btnShape =>
      MaterialStateProperty.resolveWith<OutlinedBorder>(
        (_) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
