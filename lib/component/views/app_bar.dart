import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class TitleSubtitleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String titleText;
  final String subTitle;
  final List<Widget>? actions;

  const TitleSubtitleAppBar({
    super.key,
    required this.titleText,
    required this.subTitle,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColors.mainColor,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.mainColor,
              letterSpacing: 0.42,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height10,
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              letterSpacing: 0.64,
              fontWeight: FontWeight.w500,
              height: 0.75,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      actions: actions,
    );
  }
}
