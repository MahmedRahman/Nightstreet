import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ServicesSearchController extends GetxController
    with StateMixin<List<ServiceModel>> {
  int currentPage = 1;

  RxString searchQuery = ''.obs;

  final pagingController =
      PagingController<int, ServiceModel>(firstPageKey: 1).obs;

  void startSearch() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getServices();
      },
    );
  }

  getServices() async {
    ResponseModel responseModel = await WebServices().getServices(
      name: searchQuery.value,
      page: currentPage.toString(),
    );

    if (responseModel.data["success"]) {
      final newItems = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((item) => ServiceModel.fromJson(item)),
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

      return;
    }
  }
}

class BranchSearchController extends GetxController
    with StateMixin<List<BranchModel>> {
  int currentPage = 1;

  RxString searchQuery = ''.obs;

  final pagingController =
      PagingController<int, BranchModel>(firstPageKey: 1).obs;

  void startSearch() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getBranches();
      },
    );
  }

  getBranches() async {
    ResponseModel responseModel = await WebServices().getBranches(
      page: currentPage,
      queryParameters: BranchQueryParameters(
        name: searchQuery.value,
      ),
    );

    if (responseModel.data["success"]) {
      final newItems = List<BranchModel>.from(
        responseModel.data['data']['data']
            .map((item) => BranchModel.fromJson(item)),
      );
      final isPaginate =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      if (isPaginate == false) {
        pagingController.value.appendLastPage(newItems);
      } else {
        final nextPageKey = currentPage + 1;
        pagingController.value.appendPage(newItems, nextPageKey);
      }
    }
  }
}
