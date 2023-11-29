import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/component/views/service_filter_bottom_sheet_view.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferServiceController extends GetxController
    with StateMixin<List<ServiceModel>> {
  final pagingController =
      PagingController<int, ServiceModel>(firstPageKey: 1).obs;

  final _services = Rx<List<ServiceModel>?>([]);
  int currentPage = 1;
  RxString categoryId = '0'.obs;
  ServiceFilterModel filterQuery = ServiceFilterModel();

  @override
  void onInit() {
    pageListener();
    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getServices();
      },
    );
  }

  resetSearchValues() {
    _services.value!.clear();
    categoryId = ''.obs;
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  getServices() async {
    ResponseModel responseModel = await WebServices().getServices(
      page: currentPage.toString(),
      categoryId: categoryId.value,
      filter: filterQuery.filter,
      startPrice: filterQuery.startPrice.toString(),
      endPrice: filterQuery.endPrice.toString(),
      target: filterQuery.target,
      adminFeatured: '1',
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

      KOfferHighestPrice.value = responseModel.data["data"]["highest_price"];
    }
  }

  Future<void> onRefresh() async {
    categoryId.value = '0';

    filterQuery.filter = null;
    filterQuery.target = '';

    filterQuery.startPrice = null;
    filterQuery.endPrice = null;
    filterQuery.target = null;

    pagingController.value.refresh();
  }

  void onFilterDataChanged(ServiceFilterModel serviceQueryParameters) {
    filterQuery.filter = serviceQueryParameters.filter;
    filterQuery.startPrice = serviceQueryParameters.startPrice;
    filterQuery.endPrice = serviceQueryParameters.endPrice;
    filterQuery.target = serviceQueryParameters.target;

    pagingController.value = PagingController(firstPageKey: 1);

    pageListener();
  }
}
