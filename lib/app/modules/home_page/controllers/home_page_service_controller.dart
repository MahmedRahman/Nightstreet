import 'package:get/get.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class HomePageServiceController extends GetxController
    with StateMixin<List<ServiceModel>> {
  final servicesList = Rx<List<ServiceModel>?>([]);
  @override
  void onInit() {
    getServices();
    super.onInit();
  }

  void getServices() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getServices();

    if (responseModel.data["success"]) {
      servicesList.value!.clear();
      final List<ServiceModel> serviceDataList = List<ServiceModel>.from(
        responseModel.data['data']['data']
            .map((category) => ServiceModel.fromJson(category)),
      );

      servicesList.value!.addAll(serviceDataList);

      if (servicesList.value!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(servicesList.value!, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  void toggleFavorite(int productId) {
    final product = servicesList.value!.firstWhere(
      (p) => p.id == productId,
    );
    product.isFavorite = !product.isFavorite;
    update();
  }
}
