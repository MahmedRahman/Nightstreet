import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/clinic_info/views/clinic_info_view.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/google_map/controllers/google_map_controller.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/hom_page_service_slider_controller.dart';
import 'package:krzv2/component/views/app_bar_search_view.dart';
import 'package:krzv2/component/views/branches_sort_box_view.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/services_categories_view.dart';
import 'package:krzv2/component/views/services_sort_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:location/location.dart';

import '../controllers/home_page_services_controller.dart';

class HomePageServicesView extends GetView<HomePageServicesController> {
  final sliderController = Get.find<HomePageServiceSliderController>();
  final mapController = Get.find<GoogleMapViewController>();

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onForegroundGained: () async {
        if (controller.shouldWatchFocus) {
          controller.navigateToSettings();
        }
        if (mapController.shouldWatchFocus) {
          final latlng = mapController.currentLocation.value;

          if (latlng.latitude == 0 && latlng.longitude == 0) {
            final LocationData? latlng =
                await mapController.getCurrentLocation();
            controller.queryParams.lat = latlng!.latitude;
            controller.queryParams.lng = latlng.longitude;
            controller.fiterBrancher();
            Future.delayed(const Duration(milliseconds: 200));
            Get.back();
            return;
          }

          if (latlng.latitude != 0 && latlng.longitude != 0) {
            controller.queryParams.lat = latlng.latitude;
            controller.queryParams.lng = latlng.longitude;
            controller.fiterBrancher();
            Future.delayed(const Duration(milliseconds: 200));
            Get.back();
          }
        }
      },
      child: BaseScaffold(
        onRefresh: () async {
          KselectedCategoryId.value = 0;
          // controller.fiterBrancher();
          controller.queryParams.categoryId = '0';
          controller.queryParams.filter = '';
          controller.pagingController.refresh();
        },
        appBar: AppBarSerechView(
          placeHolder: "ابحث عن خدمة او عيادة",
          actions: [
            CustomIconButton(
              onTap: controller.navigateToSettings,
              iconPath: AppSvgAssets.locationIcon,
              count: 0,
            ),
            AppSpacers.width20,
          ],
          onTap: () => Get.toNamed(Routes.SERVICES_SEARCH),
        ),
        body: Padding(
          padding: AppDimension.appPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacers.height10,
              sliderController.obx(
                (slidersList) {
                  return SliderView(
                    images: slidersList!.map((slider) => slider.image).toList(),
                  );
                },
                onLoading: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                ).shimmer(),
              ),
              SizedBox(
                height: 12,
              ),
              ServicesSortView(
                onTap: () {
                  showBranchSortBottomSheet(controller);
                },
              ),
              SizedBox(
                height: 12,
              ),
              ServicesCategoriesView(
                onTap: (int selectedCategoryId) {
                  // controller.pagingController.value.dispose();

                  controller.pagingController.value =
                      PagingController(firstPageKey: 1);

                  controller.pageListener();

                  controller.queryParams.categoryId =
                      selectedCategoryId.toString();

                  // controller.fiterBrancher();
                },
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Obx(
                  () => PagedListView<int, BranchModel>(
                    key: UniqueKey(),
                    pagingController: controller.pagingController.value,
                    builderDelegate: builder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PagedChildBuilderDelegate<BranchModel> builder() {
    return PagedChildBuilderDelegate<BranchModel>(
      firstPageProgressIndicatorBuilder: (_) => Column(
        children: [
          ClinicCardView.dummy().paddingOnly(bottom: 10).shimmer(),
          ClinicCardView.dummy().paddingOnly(bottom: 10).shimmer(),
        ],
      ),
      newPageProgressIndicatorBuilder: (_) => CupertinoActivityIndicator(),
      itemBuilder: (context, branch, index) =>
          GetBuilder<CliniFavoriteController>(
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
      ),
    );
  }

  void showBranchSortBottomSheet(HomePageServicesController controller) {
    final initialSelectedSort =
        getInitialSelectedSort(controller.queryParams.filter);

    Get.bottomSheet(
      BranchesSortBoxView(
        initialSelectedSort: initialSelectedSort,
        onSortSelected: (BranchSortEnum value) async {
          final selectedSort = mapBranchSortToQueryParam(value);

          if (selectedSort != null) {
            controller.queryParams.filter = selectedSort;

            if (selectedSort == '2') {
              mapController.askPermissionAndGetCurrentLocation(
                forceNavigateToSettingIfDenied: true,
              );

              final latlng = mapController.currentLocation.value;
              if (latlng.latitude != 0 && latlng.longitude != 0) {
                controller.queryParams.lat = latlng.latitude;
                controller.queryParams.lng = latlng.longitude;
                controller.fiterBrancher();
              }

              await Future.delayed(const Duration(milliseconds: 200));
              Get.back();
              return;
            }

            controller.fiterBrancher();
            await Future.delayed(const Duration(milliseconds: 200));
            Get.back();
          }
        },
      ),
    );
  }

  BranchSortEnum? getInitialSelectedSort(String? filter) {
    final Map<String, BranchSortEnum> filterToSortMap = {
      '2': BranchSortEnum.nearest,
      '1': BranchSortEnum.topRated,
    };

    return filterToSortMap[filter] ?? null;
  }

  String? mapBranchSortToQueryParam(BranchSortEnum value) {
    final Map<BranchSortEnum, String> sortToQueryParamMap = {
      BranchSortEnum.nearest: '2',
      BranchSortEnum.topRated: '1',
    };

    return sortToQueryParamMap[value];
  }
}

class PermissionDialog {
  static showPermissionDialog() {
    Get.defaultDialog(
      title: "Permission Required",
      middleText: "This service requires map permission.",
      textConfirm: "Accept",
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          // Trigger the permission request when the user accepts
          // You can call the requestPermission method from the MapController here
        },
        child: Text("Accept"),
      ),
    );
  }
}
