import 'package:get/get.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class MarketCategoriesController extends GetxController with StateMixin {
  final marketData = Rx<dynamic>(null);
  void getMarketCategories({
    required String marketId,
  }) async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel =
        await WebServices().getCategoriesByMarketId(marketId: marketId);

    if (responseModel.data["success"]) {
      final List<dynamic> categoryDataList = responseModel.data["data"];

      if (categoryDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      print('response message data 1 => ${responseModel.data["message"]}');
      print('response data => ${responseModel.data["data"]}');

      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }
    print('response message data 2 => ${responseModel.data["message"]}');
    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void getMarketData({
    required String marketId,
  }) async {
    ResponseModel responseModel =
        await WebServices().getMaretDate(marketId: marketId);

    if (responseModel.data["success"]) {
      marketData.value = responseModel.data["data"];
    }
  }
}
