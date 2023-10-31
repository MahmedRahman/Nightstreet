import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/hom_page_service_slider_controller.dart';
import 'package:krzv2/component/views/app_bar_search_view.dart';
import 'package:krzv2/component/views/branches_sort_box_view.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/services_categories_view.dart';
import 'package:krzv2/component/views/services_sort_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/home_page_services_controller.dart';

class HomePageServicesView extends GetView<HomePageServicesController> {
  HomePageServicesView({Key? key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.queryParams.categoryId = KselectedCategoryId.value.toString();
      controller.fiterBrancher();
    });
  }

  final sliderController = Get.put(HomePageServiceSliderController());
  final servicesController = Get.put(HomePageServicesController());

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onForegroundGained: () {
        if (controller.shouldWatchFocus) {
          controller.navigateToSettings();
        }
      },
      child: BaseScaffold(
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
                  controller.queryParams.categoryId =
                      selectedCategoryId.toString();
                  controller.fiterBrancher();
                },
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: controller.obx(
                  (branches) => ListView.builder(
                    controller: controller.scroll,
                    itemCount: branches!.length,
                    itemBuilder: (context, index) {
                      final branch = branches.elementAt(index);

                      return ClinicCardView(
                        distance: branch.distance,
                        isFavorite: branch.isFavorite,
                        imageUrl: branch.clinic.image,
                        name: branch.name,
                        onTap: () {
                          Get.toNamed(
                            Routes.CLINIC_INFO,
                            arguments: branch.id,
                          );
                        },
                        onFavoriteTapped: () {
                          if (Get.put(AuthenticationController().isLoggedIn) ==
                              false) {
                            return AppDialogs.showToast(
                                message: 'الرجاء تسجيل الدخول');
                          }

                          final favCon = Get.put<CliniFavoriteController>(
                            CliniFavoriteController(),
                          );
                          controller.toggleFavorite(branch.id);

                          favCon.addRemoveBranchFromFavorite(
                            branchId: branch.id,
                            onError: () {
                              servicesController.toggleFavorite(branch.id);
                            },
                          );
                        },
                        rate: branch.totalRateAvg.toString(),
                        totalRate: branch.totalRateCount.toString(),
                      ).paddingOnly(bottom: 10);
                    },
                  ),
                  onLoading: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ClinicCardView.dummy()
                          .paddingOnly(bottom: 10)
                          .shimmer();
                    },
                  ),
                  onError: (String? error) =>
                      Text(error ?? 'حدث خطا في الفروع'),
                  onEmpty: AppPageEmpty.branches(),
                ),
              )
            ],
          ),
        ),
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
      'by rate': BranchSortEnum.topRated,
      'nearest': BranchSortEnum.nearest,
    };

    return filterToSortMap[filter] ?? null;
  }

  String? mapBranchSortToQueryParam(BranchSortEnum value) {
    final Map<BranchSortEnum, String> sortToQueryParamMap = {
      BranchSortEnum.nearest: 'nearest',
      BranchSortEnum.topRated: 'by rate',
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
