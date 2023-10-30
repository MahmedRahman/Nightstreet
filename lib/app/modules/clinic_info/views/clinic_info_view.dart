import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/home_banner_view.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/clinic_info_controller.dart';

class ClinicInfoView extends GetView {
  const ClinicInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "مركز طيبة للتجميل"),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitchTap(
              title1: "عن المركز",
              title2: "الخدمات",
              Widget1: ClinicAboutPage(),
              Widget2: ClinicServicesPage(),
            )
          ],
        ),
      ),
    );
  }
}

class ClinicAboutPage extends GetView<ClinicAboutInfoController> {
  ClinicAboutInfoController controller = Get.put(ClinicAboutInfoController());

  @override
  Widget build(BuildContext context) {
    return controller.obx((data) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceCardView.dummy(),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            HomeBannerView.dummy(),
            Text(
              'عن المركز',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                height: 2.19,
              ),
              textAlign: TextAlign.right,
            ),
            Divider(),
            Html(
              data: data["clinic"]["desc"],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text(
              'فروع المركز',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                height: 2.19,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 10,
            ),
            data["other_branches"].length == 0
                ? SizedBox.shrink()
                : Column(
                    children: List.generate(
                      data["other_branches"].length,
                      (index) {
                        return addressCard(
                          address: data["other_branches"][index]["name"],
                          isCurrentAddress: data["other_branches"][index]["current"],
                        );
                      },
                    ),
                  ),
            AppSpacers.height5,
            // addressCard(
            //   address: 'فرع شارع الحرمين',
            //   isCurrentAddress: true,
            // ),
            AppSpacers.height40,
          ],
        ),
      );
    });
  }

  Widget addressCard({
    required String address,
    required bool isCurrentAddress,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                AppSvgAssets.mapIcon,
                width: 20,
                height: 20,
                color: AppColors.blackColor,
              ),
              AppSpacers.width10,
              Text(
                address,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.24,
                  height: 0.75,
                ),
                textAlign: TextAlign.right,
              ),
              Spacer(),
              if (isCurrentAddress)
                Text(
                  '(الفرع الحالي)',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.mainColor,
                    letterSpacing: 0.21,
                    decoration: TextDecoration.underline,
                    height: 0.86,
                  ),
                  textAlign: TextAlign.right,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ClinicOffersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(
//               bottom: 8,
//             ),
//             child: ServiceCardView.dummy(
//               showFavoriteIcon: false,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ClinicServicesPage extends GetView<ClinicServicesController> {
  ClinicServicesController controller = Get.put(ClinicServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (snapshot) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: ServiceCardView(
                  name: snapshot[index]["name"].toString(),
                  imageUrl: snapshot[index]["image"].toString(),
                  price: snapshot[index]["price"].toString(),
                  oldPrice: snapshot[index]["old_price"].toString(),
                  hasDiscount: false,
                  onFavoriteTapped: () {},
                  onTapped: () {
                    Get.toNamed(
                      Routes.SERVICE_DETAIL,
                      arguments: snapshot[index]["id"].toString(),
                    );
                  },
                  rate: snapshot[index]["total_rate_count"].toString(),
                  totalRate: snapshot[index]["total_rate_avg"].toString(),
                  isFavorite: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
