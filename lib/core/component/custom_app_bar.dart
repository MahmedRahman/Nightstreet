import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final Function()? onBackTapped;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.actions,
    this.onBackTapped,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0,
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
    );
  }
}
