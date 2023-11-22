import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:krzv2/models/product_brand_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductsBrandController extends GetxController
    with StateMixin<List<ProuctBrandModel>> {
  final brandsList = Rx<List<ProuctBrandModel>?>([]);

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    if ((brandsList.value ?? []).isNotEmpty) return;
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getProductsBrands();

    if (responseModel.data["success"]) {
      final List<ProuctBrandModel> productDataList =
          List<ProuctBrandModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProuctBrandModel.fromJson(category)),
      );

      brandsList.value?.addAll(productDataList);

      if (brandsList.value!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(brandsList.value!, status: RxStatus.success());

      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }
}
