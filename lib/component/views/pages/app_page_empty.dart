import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class AppPageEmpty extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const AppPageEmpty({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  AppPageEmpty.notifications({
    super.key,
  })  : title = 'لا يوجد إشعارات',
        description = 'لم تستلم أي إشعارات حتى الآن',
        imagePath = AppSvgAssets.emptyNotificationIcon;

  AppPageEmpty.productSearch({
    super.key,
  })  : title = "سلة التسوق الخاصة بك فارغة",
        description = 'قم بإضافة بعض المنتجات',
        imagePath = AppSvgAssets.emptySearchIcon;

  AppPageEmpty.productSearchP({
    super.key,
  })  : title = "لم يتم العثور على نتائج",
        description = "جرب كلمة رئيسية اخرى ، وحاول مرة اخرى",
        imagePath = AppSvgAssets.emptySearchIcon;

  AppPageEmpty.serviceSearch({
    super.key,
  })  : title = "لم يتم العثور على نتائج",
        description = "جرب كلمة رئيسية أخرى , وحاول مرة اخرى.",
        imagePath = AppSvgAssets.emptySearchIcon;

  AppPageEmpty.shoppingCart({
    super.key,
  })  : title = "لم يتم العثور على نتائج",
        description = "جرب كلمة رئيسية أخرى , وحاول مرة اخرى.",
        imagePath = AppSvgAssets.emptyCartIcon;

  AppPageEmpty.branches({
    super.key,
  })  : title = "لم يتم العثور على نتائج",
        description = "جرب قسم أخر , وحاول مرة اخرى.",
        imagePath = AppSvgAssets.emptySearchIcon;

  AppPageEmpty.ordersList({
    super.key,
  })  : title = "لم يتم العثور على طلبات !",
        description =
            "حاليا ليس لديك أي طلبات. عندما تطلب شيئًا \n \n \n ما. وسوف تظهر هنا ",
        imagePath = AppSvgAssets.emptyOrdersIcon;

  AppPageEmpty.Favorite({
    super.key,
    required this.description,
  })  : title = 'قائمة المفضلة الخاصة بك فارغة',
        imagePath = AppSvgAssets.emptyFavoriteIcon;

  AppPageEmpty.addressesList({
    super.key,
  })  : title = "سجل العناويين الخاص بك فارغ",
        description = "سجل العناويين الخاص بك فارغ",
        imagePath = AppSvgAssets.emptyOrdersIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath),
          AppSpacers.height25,
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              color: AppColors.blackColor,
              height: 0.67,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacers.height25,
          Text(
            description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              letterSpacing: 0.48,
              height: 0.75,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
