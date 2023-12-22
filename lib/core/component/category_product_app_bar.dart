import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:flutter/material.dart';

class CategoryProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final Function()? onBackTapped;
  final Color backgroundColor;
  final double elevation;
  final Widget? flexibleSpace;

  const CategoryProductAppBar({
    super.key,
    required this.titleText,
    this.actions,
    this.onBackTapped,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
    this.flexibleSpace,
  });

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: Color(0x1a000000),
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: CustomBackButton(onBackTapped: onBackTapped),
      ),
      centerTitle: false,
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 18.0,
          color: AppColor.KBlackColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.right,
      ),
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }
}
