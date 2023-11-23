import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/show_more_button_view.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

class RecommendedServicesListView extends GetView {
  final List<ServiceModel> recommendedServicesList;
  final VoidCallback onShowMoreTapped;
  final Function(int id) onFavoriteTapped;
  final Function(int id) onTap;
  const RecommendedServicesListView({
    Key? key,
    required this.recommendedServicesList,
    required this.onShowMoreTapped,
    required this.onFavoriteTapped,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowMoreButtonView(
          onShowMoreTapped: onShowMoreTapped,
          title: 'خدمات قد تعجبك',
        ),
        AppSpacers.height16,
        SizedBox(
          height: 101,
          child: ListView.builder(
            itemCount: recommendedServicesList.length,
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final service = recommendedServicesList.elementAt(index);
              return GetBuilder<OfferFavoriteController>(
                init: OfferFavoriteController(),
                initState: (_) {},
                builder: (favoriteController) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ServiceCardView(
                      imageUrl: service.image,
                      name: service.name,
                      subTitle: service.clinic.name,
                      maxWidth: context.width * .75,
                      hasDiscount: service.oldPrice.toString() != '0.0',
                      price: service.price.toString(),
                      oldPrice: service.oldPrice.toString(),
                      onFavoriteTapped: () {
                        if (Get.find<AuthenticationController>().isLoggedIn == false) {
                          return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                        }
                        return onFavoriteTapped(service.id);
                      },
                      rate: service.totalRateAvg.toString(),
                      totalRate: service.totalRateCount.toString(),
                      isFavorite: favoriteController.offerIsFavorite(service.id),
                      onTapped: () {
                        onTap(service.id);
                      },
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
