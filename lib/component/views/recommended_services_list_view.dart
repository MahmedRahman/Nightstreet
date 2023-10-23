import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/show_more_button_view.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_spacers.dart';

class RecommendedServicesListView extends GetView {
  final List<ServiceModel> recommendedServicesList;
  final VoidCallback onShowMoreTapped;
  final Function(int id) onFavoriteTapped;
  const RecommendedServicesListView({
    Key? key,
    required this.recommendedServicesList,
    required this.onShowMoreTapped,
    required this.onFavoriteTapped,
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
              return ServiceCardView(
                imageUrl: service.image,
                name: service.name,
                hasDiscount: service.oldPrice.toString() != '0.0',
                price: service.price.toString(),
                oldPrice: service.oldPrice.toString(),
                onFavoriteTapped: () => onFavoriteTapped(service.id),
                rate: service.totalRateAvg.toString(),
                totalRate: service.totalRateCount.toString(),
                isFavorite: service.isFavorite,
                onTapped: () {
                  Get.toNamed(
                    Routes.SERVICE_DETAIL,
                    arguments: service.id,
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
