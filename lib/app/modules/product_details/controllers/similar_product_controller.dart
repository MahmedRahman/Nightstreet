import 'package:get/get.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class SimilarProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  void getMostSimilarProducts({required String categoryId}) async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getProducts(
      queryParameters: ProductQueryParameters(
        categoryId: categoryId,
      ),
    );

    if (responseModel.data["success"]) {
      final List<ProductModel> productDataList = List<ProductModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductModel.fromJson(category)),
      );

      if (productDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(productDataList, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
