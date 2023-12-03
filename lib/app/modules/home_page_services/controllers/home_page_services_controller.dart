import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

  final pagingController =
      PagingController<int, BranchModel>(firstPageKey: 1).obs;

  BranchQueryParameters queryParams = BranchQueryParameters();

  @override
  void onInit() async {
    change([], status: RxStatus.loading());

    pageListener();

    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener((pageKey) {
      final mapController = Get.find<GoogleMapViewController>();
      final latlng = mapController.currentLocation.value;

      if (latlng.latitude != 0 && latlng.longitude != 0) {
        queryParams.lat = latlng.latitude;
        queryParams.lng = latlng.longitude;
      }
      currentPage = pageKey;
      fetchBranches();
    });
  }

  Future<void> fetchBranches() async {
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
          pagingController.value.appendLastPage(newItems.toSet().toList());
        } else {
          final nextPageKey = currentPage + 1;
          pagingController.value
              .appendPage(newItems.toSet().toList(), nextPageKey);
        }
      } catch (e, st) {
        print('errrrrr $e');
        print('errrrrr st $st');
      }
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

    fetchBranches();
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
