import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final Function()? onBackTapped;
  final Color backgroundColor;
  final double elevation;
  final bool withBackButton;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.actions,
    this.onBackTapped,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
    this.withBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: elevation,
      leading: withBackButton
          ? Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CustomBackButton(onBackTapped: onBackTapped),
            )
          : null,
      centerTitle: false,
      title: Text(
        titleText,
        style: TextStyles.font14mediumBlack,
      ),
      actions: actions,
    );
  }
}
