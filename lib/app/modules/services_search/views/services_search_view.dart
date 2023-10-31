import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/product_search_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/services_search_controller.dart';

class ServicesSearchView extends GetView<ServicesSearchController> {
  ServicesSearchView({Key? key}) : super(key: key);

  final selectedTapIndex = 0.obs;
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: ProductSearchAppBarView(
        onBackTapped: () => Get.back(result: true),
        textEditingController: searchController,
        onSearchIconTapped: onSearchTapped,
        onChanged: (String query) {
          if (query.isEmpty) controller.resetSearchValues();
        },
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            AppSpacers.height12,
            BaseSwitchTap(
              title1: "الخدمات",
              title2: "العيادات",
              Widget1: ServiceSearchView(),
              Widget2: ClinicsSearchView(),
              onTap: (int index) {
                selectedTapIndex.value = index;
              },
            )
          ],
        ),
      ),
    );
  }

  onSearchTapped() {
    if (searchController.text.isEmpty) return;

    if (searchController.text == controller.searchQuery.value) return;

    controller.resetSearchValues();

    controller.searchQuery.value = searchController.text;

    FocusScope.of(Get.context!).unfocus();

    controller.getServices();
  }
}

class ServiceSearchView extends GetView<ServicesSearchController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (List<ServiceModel>? servicesList) => ListView.builder(
        itemCount: servicesList?.length,
        controller: controller.scroll,
        itemBuilder: (context, index) {
          final service = servicesList?.elementAt(index);

          return ServiceCardView(
            imageUrl: service!.image,
            name: service.name,
            hasDiscount: service.oldPrice != 0,
            price: service.price.toString(),
            onFavoriteTapped: () {
              if (Get.put(AuthenticationController().isLoggedIn) == false) {
                return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
              }

              final favCon = Get.put<OfferFavoriteController>(
                OfferFavoriteController(),
              );
              controller.toggleFavorite(service.id);

              favCon.addRemoveOfferFromFavorite(
                offerId: service.id,
                onError: () {
                  controller.toggleFavorite(service.id);
                },
              );
            },
            rate: service.totalRateAvg.toString(),
            totalRate: service.totalRateCount.toString(),
            isFavorite: service.isFavorite,
            onTapped: () async {
              final awaitId = await Get.toNamed(
                Routes.SERVICE_DETAIL,
                arguments: service.id.toString(),
              );

              if (awaitId != null && awaitId != '') {
                controller.toggleFavorite(service.id);
              }
            },
          ).paddingOnly(bottom: 10);
        },
      ),
      onLoading: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ServiceCardView.dummy().paddingOnly(bottom: 10).shimmer();
        },
      ),
      onEmpty: AppPageEmpty.serviceSearch(),
    );
  }
}

class ClinicsSearchView extends GetView<BranchSearchController> {
  final controllerBranchSearch = Get.put(BranchSearchController());

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (snapshot) {
        return ListView.builder(
          itemCount: snapshot!.length,
          itemBuilder: (context, index) {
            return ClinicCardView(
              name: snapshot.elementAt(index)["name"].toString(),
              imageUrl: snapshot.elementAt(index)["clinic"]["image"].toString(),
              totalRate: snapshot.elementAt(index)["total_rate_count"].toString(),
              oldPrice: snapshot.elementAt(index)["total_rate_count"].toString(),
              isFavorite: false,
              onTap: () {},
              onFavoriteTapped: () {},
              rate: snapshot.elementAt(index)["total_rate_count"].toString(),
              distance: snapshot.elementAt(index)["distance"].toString(),
            );
          },
        );
      },
    );
  }
}
