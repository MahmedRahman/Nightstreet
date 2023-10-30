import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_back_button_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ProductSearchAppBarView extends GetView implements PreferredSizeWidget {
  const ProductSearchAppBarView({
    Key? key,
    required this.textEditingController,
    required this.onSearchIconTapped,
    this.onBackTapped,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function() onSearchIconTapped;
  final Function(String)? onChanged;
  final Function()? onBackTapped;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,

        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: CustomBackButton(
          onBackTapped: onBackTapped,
        ),
      ),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: Row(
          children: [
            AppSpacers.width5,
            Expanded(
              child: TextField(
                controller: textEditingController,
                maxLines: 1,
                autofocus: true,
                onChanged: onChanged,
                onSubmitted: (_) {
                  onSearchIconTapped();
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      top: 3,
                      bottom: 3,
                    ),
                    child: InkWell(
                      onTap: onSearchIconTapped,
                      child: SvgPicture.asset(
                        AppSvgAssets.searchIconIcon,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'ما الذي تريد البحث عنه ؟',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.greyColor,
                  ),
                ),
                cursorColor: AppColors.mainColor,
              ),
            ),
            AppSpacers.width5,
          ],
        ),
      ),
    );
  }
}
