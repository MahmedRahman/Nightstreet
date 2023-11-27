import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/google_map/controllers/google_map_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/permissions_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageServicesController extends GetxController
    with StateMixin<List<BranchModel>>, ScrollMixin {
  final List<BranchModel> _branches = [];
  int currentPage = 1;

  bool? isPagination;

  PagingController<int, BranchModel> pagingController =
      PagingController(firstPageKey: 1);

  BranchQueryParameters queryParams = BranchQueryParameters();

  @override
  void onInit() async {
    change([], status: RxStatus.loading());

    pagingController.addPageRequestListener((pageKey) {
      final mapController = Get.find<GoogleMapViewController>();
      final latlng = mapController.currentLocation.value;

      if (latlng.latitude != 0 && latlng.longitude != 0) {
        queryParams.lat = latlng.latitude;
        queryParams.lng = latlng.longitude;
        update();
      }
      currentPage = pageKey;
      fetchBranches();
    });

    super.onInit();
  }

  fetchBranches() async {
    final ResponseModel responseModel = await WebServices().getBranches(
      page: currentPage,
      queryParameters: queryParams,
    );

    if (responseModel.data['success'] == true) {
      try {
        final newItems = List<BranchModel>.from(
          responseModel.data['data']['data']
              .map((item) => BranchModel.fromJson(item)),
        );
        final isPaginate =
            responseModel.data['data']['pagination']['is_pagination'] as bool;

        if (isPaginate == false) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = currentPage + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (e) {}
    }
  }

  fiterBrancher() {
    change([], status: RxStatus.loading());
    _branches.clear();
    currentPage = 1;

    pagingController.refresh();

    fetchBranches();
  }

  resetBranches() {
    change([], status: RxStatus.loading());
    _branches.clear();
    currentPage = 1;
    queryParams = BranchQueryParameters();
    fetchBranches();
  }

  void toggleFavorite(int branchId) {
    final product = _branches.firstWhere(
      (p) => p.id == branchId,
    );
    product.isFavorite = !product.isFavorite;
    update();
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    change(_branches, status: RxStatus.loadingMore());

    await fetchBranches();
  }

  @override
  Future<void> onTopScroll() async {}

  bool shouldWatchFocus = false;
  Future<void> navigateToSettings() async {
    final status = await PermissionsHelper.requestLocationPermission();

    shouldWatchFocus = false;

    if (status == PermissionStatus.granted) {
      final latlng = await Get.toNamed(Routes.GOOGLE_MAP);

      if (latlng is LatLng) {
        queryParams.lat = latlng.latitude;
        queryParams.lng = latlng.longitude;
        fiterBrancher();
      }
    } else if (status == PermissionStatus.permanentlyDenied) {
      AppDialogs.locationPermissionDialog(
        onTap: () async {
          shouldWatchFocus = true;
          await Geolocator.openLocationSettings();
          Get.back();
        },
      );
    }
  }
}
