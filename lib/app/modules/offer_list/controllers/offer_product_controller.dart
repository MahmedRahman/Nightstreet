import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OfferProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final productList = Rx<List<ProductModel>?>([]);
  int currentPage = 1;
  bool? isPagination;
  ProductQueryParameters queryParams = ProductQueryParameters(adminFeatured: 1);

  final pagingController =
      PagingController<int, ProductModel>(firstPageKey: 1).obs;

  @override
  void onInit() {
    pageListener();
    super.onInit();
  }

  void pageListener() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getOffersProduct();
      },
    );
  }

  Future<void> getOffersProduct() async {
    ResponseModel responseModel = await WebServices().getProducts(
      page: currentPage,
      queryParameters: queryParams,
    );

    if (responseModel.data["success"]) {
      final newItems = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((item) => ProductModel.fromJson(item)),
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

      KProductHighestPrice.value = responseModel.data["data"]["highest_price"];

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void onFilterDataChanged(ProductQueryParameters productQueryParameters) {
    queryParams.filter = productQueryParameters.filter;
    queryParams.startPrice = productQueryParameters.startPrice;
    queryParams.endPrice = productQueryParameters.endPrice;
    queryParams.brandIds = productQueryParameters.brandIds;

    pagingController.value = PagingController(firstPageKey: 1);

    pageListener();
  }

  Future<void> onRefresh() async {
    queryParams.filter = null;
    queryParams.categoryId = null;
    queryParams.startPrice = null;
    queryParams.endPrice = null;
    queryParams.brandIds = null;
    pagingController.value.refresh();
  }
}
