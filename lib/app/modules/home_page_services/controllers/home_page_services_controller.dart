import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krzv2/app/modules/google_map/controllers/google_map_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/permissions_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageServicesController extends GetxController
    with StateMixin<List<BranchModel>>, ScrollMixin {
  final List<BranchModel> _branches = [];
  int currentPage = 1;
  // int? totalRemotePage;
  bool? isPagination;

  BranchQueryParameters queryParams = BranchQueryParameters();

  @override
  void onInit() async {
    change([], status: RxStatus.loading());
    final mapController = Get.find<GoogleMapViewController>();
    final latlng = mapController.currentLocation.value;
    if (latlng.latitude != 0 && latlng.longitude != 0) {
      queryParams.lat = latlng.latitude;
      queryParams.lng = latlng.longitude;
      update();
    }

    await fetchBranches();
    super.onInit();
  }

  fetchBranches() async {
    final ResponseModel responseModel = await WebServices().getBranches(
      page: currentPage,
      queryParameters: queryParams,
    );

    if (responseModel.data['success'] == true) {
      try {
        final fetchedBranches = List<BranchModel>.from(
          responseModel.data['data']['data']
              .map((item) => BranchModel.fromJson(item)),
        );

        _branches.addAll(fetchedBranches);

        if (_branches.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }

        await Future.delayed(const Duration(milliseconds: 500));
        change(_branches, status: RxStatus.success());
        // totalRemotePage =
        //     responseModel.data['data']['pagination']['total_pages'];
        isPagination =
            responseModel.data['data']['pagination']['is_pagination'] as bool;
      } catch (e) {}
    }
  }

  fiterBrancher() {
    change([], status: RxStatus.loading());
    _branches.clear();
    currentPage = 1;
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
