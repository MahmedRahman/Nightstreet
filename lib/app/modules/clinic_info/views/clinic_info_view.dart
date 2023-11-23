import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_banner_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/clinic_info_controller.dart';

String KPageTitle = 'مركز';

class ClinicInfoView extends GetView {
  const ClinicInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          titleText: KPageTitle,
        ),
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitchTap(
              title2: "عن المركز",
              title1: "الخدمات",
              Widget2: ClinicAboutPage(),
              Widget1: ClinicServicesPage(),
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
    return controller.obx((branch) {
      //PageTitle.value = branch!.name.toString();
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<CliniFavoriteController>(
              init: CliniFavoriteController(),
              builder: (favoriteController) {
                return ClinicCardView(
                  distance: branch!.distance,
                  isFavorite: favoriteController.clinicIsFavorite(branch.id),
                  imageUrl: branch.clinic.image,
                  name: branch.clinic.name,
                  onTap: () {},
                  onFavoriteTapped: () {
                    if (Get.find<AuthenticationController>().isLoggedIn ==
                        false) {
                      return AppDialogs.showToast(
                          message: 'الرجاء تسجيل الدخول');
                    }

                    final favCon = Get.put<CliniFavoriteController>(
                      CliniFavoriteController(),
                    );

                    favCon.addRemoveBranchFromFavorite(
                      branchId: branch.id,
                    );
                  },
                  rate: branch.totalRateAvg.toString(),
                  totalRate: branch.totalRateCount.toString(),
                  branchName: branch.name,
                ).paddingOnly(bottom: 10);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            (branch!.clinicImage.toString() == "null")
                ? SizedBox.shrink()
                : HomeBannerView(imageUrl: branch.clinicImage.toString()),
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
              data: branch.clinic.desc,
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
            if ((branch.otherBranches?.length ?? 0) > 0)
              Column(
                children: List.generate(
                  branch.otherBranches!.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: addressCard(
                        address: branch.otherBranches!.elementAt(index).name,
                        isCurrentAddress:
                            branch.otherBranches!.elementAt(index).current,
                      ),
                    );
                  },
                ),
              ),
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

class ClinicServicesPage extends GetView<ClinicServicesController> {
  ClinicServicesController controller = Get.put(ClinicServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (List<ServiceModel>? services) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: services!.length,
            itemBuilder: (context, index) {
              final offer = services.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: GetBuilder<OfferFavoriteController>(
                  init: OfferFavoriteController(),
                  builder: (favoriteController) {
                    return ServiceCardView(
                      imageUrl: offer.image,
                      name: offer.name,
                      subTitle: offer.clinic.name,
                      hasDiscount: offer.oldPrice != 0,
                      price: offer.price.toString(),
                      oldPrice: offer.oldPrice.toString(),
                      onFavoriteTapped: () {
                        if (Get.find<AuthenticationController>().isLoggedIn ==
                            false) {
                          return AppDialogs.showToast(
                              message: 'الرجاء تسجيل الدخول');
                        }
                        final favCon = Get.put<OfferFavoriteController>(
                          OfferFavoriteController(),
                        );

                        favCon.addRemoveOfferFromFavorite(
                          offerId: offer.id,
                        );
                      },
                      isFavorite: favoriteController.offerIsFavorite(offer.id),
                      onTapped: () {
                        Get.toNamed(
                          Routes.SERVICE_DETAIL,
                          arguments: offer.id.toString(),
                        );
                      },
                      rate: offer.totalRateCount.toString(),
                      totalRate: offer.totalRateAvg.toString(),
                    );
                  },
                ),
              );
            },
          );
        },
        onEmpty: AppPageEmpty.noServiceFound(),
      ),
    );
  }
}
