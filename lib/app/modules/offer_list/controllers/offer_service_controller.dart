import 'package:get/get.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/component/views/service_filter_bottom_sheet_view.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferServiceController extends GetxController
    with ScrollMixin, StateMixin<List<ServiceModel>> {
  final _services = Rx<List<ServiceModel>?>([]);
  int currentPage = 1;
  bool? isPagination;
  RxString categoryId = ''.obs;
  ServiceFilterModel filterQuery = ServiceFilterModel();

  @override
  void onInit() {
    getServices();
    super.onInit();
  }

  resetSearchValues() {
    _services.value!.clear();
    categoryId = ''.obs;
    currentPage = 1;
    change([], status: RxStatus.success());
  }

  getServices() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getServices(
      page: currentPage.toString(),
      categoryId: categoryId.value,
      filter: filterQuery.filter,
      startPrice: filterQuery.startPrice.toString(),
      endPrice: filterQuery.endPrice.toString(),
      target: filterQuery.target,
    );

    if (responseModel.data["success"]) {
      final List<ServiceModel> serviceDataList = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((category) => ServiceModel.fromJson(category)),
      );

      _services.value!.addAll(serviceDataList);

      if (_services.value!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_services.value, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      KOfferHighestPrice.value = responseModel.data["data"]["highest_price"];
    }
  }

  void onFilterDataChanged(ServiceFilterModel serviceQueryParameters) {
    filterQuery.filter = serviceQueryParameters.filter;
    filterQuery.startPrice = serviceQueryParameters.startPrice;
    filterQuery.endPrice = serviceQueryParameters.endPrice;
    filterQuery.target = serviceQueryParameters.target;

    serviceFilter();
  }

  serviceFilter() {
    change([], status: RxStatus.loading());
    _services.value!.clear();
    currentPage = 1;
    getServices();
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    change(_services.value, status: RxStatus.loadingMore());

    await getServices();
  }

  @override
  Future<void> onTopScroll() async {}
}
