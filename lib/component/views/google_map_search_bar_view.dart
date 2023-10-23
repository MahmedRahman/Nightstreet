import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/location_search_dialog_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class GoogleMapSearchBarView extends GetView implements PreferredSizeWidget {
  const GoogleMapSearchBarView({
    Key? key,
    required this.textEditingController,
    required this.onSearchIconTapped,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function() onSearchIconTapped;
  final Function(String)? onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
      leading: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: InkWell(
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.center,
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: SvgPicture.asset(AppSvgAssets.backIcon),
              ),
            ),
          ),
        ],
      ),
      title: LocationSearchDialogView(),

      // Container(
      //   height: 40,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     color: AppColors.greyColor4,
      //     border: Border.all(
      //       width: 1.0,
      //       color: AppColors.borderColor2,
      //     ),
      //   ),
      //   child: Container(
      //     height: 40.0,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10.0),
      //       color: Colors.white,
      //       border: Border.all(
      //         width: 1.0,
      //         color: AppColors.borderColor2,
      //       ),
      //     ),
      //     child: Row(
      //       children: <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.only(
      //             top: 11,
      //             right: 11,
      //             bottom: 11,
      //             left: 3,
      //           ),
                // child: SvgPicture.asset(
                //   AppSvgAssets.searchIcon,
                // ),
      //         ),
      //         Expanded(
      //           child: TextField(
      //             controller: textEditingController,
      //             maxLines: 1,
      //             onChanged: onChanged,
      //             onSubmitted: (_) {
      //               onSearchIconTapped();
      //             },
      //             decoration: InputDecoration(
      //               border: InputBorder.none,
      //               hintText: "ابحث أو حرك الخريطة",
      //               hintStyle: TextStyle(
      //                 fontSize: 16.0,
      //                 color: AppColors.greyColor,
      //                 height: 1.4,
      //               ),
      //             ),
      //             cursorColor: AppColors.mainColor,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),

      // ),
    );
  }
}
