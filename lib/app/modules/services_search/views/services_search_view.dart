import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/clinic_info/views/clinic_info_view.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/component/paginated_list_view.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/product_search_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/branch_model.dart';
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
  final branchSearchController = Get.put(BranchSearchController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: ProductSearchAppBarView(
        onBackTapped: () => Get.back(result: true),
        textEditingController: searchController,
        onSearchIconTapped: () {
          onSearchTapped();
          onSearchTappedBranches();
        },
        onChanged: (String query) {
          if (query.isEmpty) {
            /// services
            controller.searchQuery.value = '';

            /// branches
            branchSearchController.searchQuery.value = '';
          }
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

    controller.searchQuery.value = searchController.text;

    controller.pagingController.value = PagingController(firstPageKey: 1);

    FocusScope.of(Get.context!).unfocus();

    controller.startSearch();
  }

  onSearchTappedBranches() {
    if (searchController.text.isEmpty) return;

    if (searchController.text == branchSearchController.searchQuery.value)
      return;

    branchSearchController.searchQuery.value = searchController.text;

    FocusScope.of(Get.context!).unfocus();

    branchSearchController.startSearch();
  }
}

class ServiceSearchView extends GetView<ServicesSearchController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.searchQuery.isEmpty) return SizedBox();
        return PaginatedListView<ServiceModel>(
          controller: controller.pagingController.value,
          firstLoadingIndicator: Column(
            children: [
              ServiceCardView.dummy().paddingOnly(bottom: 10).shimmer(),
              ServiceCardView.dummy().shimmer(),
            ],
          ),
          itemBuilder: itemBuilder,
          onEmpty: AppPageEmpty.noServiceFound(),
        );
      },
    );
  }

  Widget itemBuilder(_, ServiceModel offer, __) {
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
              if (Get.find<AuthenticationController>().isLoggedIn == false) {
                return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
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
  }
}

class ClinicsSearchView extends GetView<BranchSearchController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.searchQuery.isEmpty) return SizedBox();
        return PaginatedListView<BranchModel>(
          controller: controller.pagingController.value,
          firstLoadingIndicator: Column(
            children: [
              ClinicCardView.dummy().paddingOnly(bottom: 10).shimmer(),
              ClinicCardView.dummy().shimmer(),
            ],
          ),
          itemBuilder: itemBuilder,
          onEmpty: AppPageEmpty.mainBranches(),
        );
      },
    );
  }

  Widget itemBuilder(_, BranchModel branch, __) {
    return GetBuilder<CliniFavoriteController>(
      init: CliniFavoriteController(),
      builder: (favoriteController) {
        return ClinicCardView(
          distance: branch.distance,
          isFavorite: favoriteController.clinicIsFavorite(branch.id),
          imageUrl: branch.clinic.image,
          name: branch.clinic.name,
          onTap: () {
            KPageTitle = branch.clinic.name;
            Get.toNamed(
              Routes.CLINIC_INFO,
              arguments: branch.id,
            );
          },
          onFavoriteTapped: () {
            if (Get.find<AuthenticationController>().isLoggedIn == false) {
              return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
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
    );
  }
}
