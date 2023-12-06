import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductSearchController extends GetxController {
  final List<ProductModel> productList = [];
  int currentPage = 1;
  bool? isPagination;
  RxString searchQuery = ''.obs;

  final pagingController =
      PagingController<int, ProductModel>(firstPageKey: 1).obs;

  void startSearch() {
    pagingController.value.addPageRequestListener(
      (pageKey) {
        currentPage = pageKey;
        getProducts();
      },
    );
  }

  resetSearchValues() {
    productList.clear();
    searchQuery = ''.obs;
    currentPage = 1;
  }

  Future<void> getProducts() async {
    ResponseModel responseModel = await WebServices().getProducts(
      page: currentPage,
      queryParameters: ProductQueryParameters(
        name: searchQuery.value,
      ),
    );

    if (responseModel.data["success"]) {
      final newItems = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((item) => ProductModel.fromJson(item)),
      );
      final isPaginate =
          responseModel.data['data']['pagination']['is_pagination'] as bool;

      print('new items length => ${newItems.length}');

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
