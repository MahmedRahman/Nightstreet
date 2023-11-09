import 'package:get/get.dart';
import 'package:krzv2/models/shipping_companies_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ShippingCompaniesController extends GetxController
    with StateMixin<List<ShippingCompaniesModel>> {
  getShppingCompanies({
    required String addressId,
  }) async {
    change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getShippingCompanies(
      addressId: addressId,
    );

    print('responseModel.data["success"] => ${responseModel.data["success"]}');

    if (responseModel.data["success"]) {
      final List<ShippingCompaniesModel> featchedData =
          responseModel.data['data'] == null
              ? []
              : List<ShippingCompaniesModel>.from(
                  responseModel.data['data'].map(
                      (category) => ShippingCompaniesModel.fromMap(category)),
                );

      if (featchedData.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(featchedData, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data['message']));
  }
}
