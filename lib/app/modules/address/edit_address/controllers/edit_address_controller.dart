import 'dart:developer';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/list_addresses/controllers/delivery_addresses_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class editAddressController extends GetxController with StateMixin {
  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void editAddress({
    required int Id,
    required String cityId,
    required String phone,
    required String address,
    required String notes,
    required String isDefault,
    required String previousRoute,
  }) async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().updateAddresses(
      id: Id,
      cityId: cityId.toString(),
      phone: phone.toString(),
      address: address.toString(),
      notes: notes.toString(),
      isDefault: isDefault.toString(),
    );

    if (responseModel.data["success"]) {
      AppDialogs.addAddressSuccess();
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.find<DeliveryAddressesController>().getAddress();

          if (previousRoute == '/order-complete') {
            return Get.offAndToNamed(Routes.ORDER_COMPLETE);
          }

          Get.back(closeOverlays: true);
        },
      );
      change(null, status: RxStatus.success());
      return;
    } else {
      AppDialogs.showToast(
        message: responseModel.data["message"],
      );
    }

    change(null, status: RxStatus.error());
  }
}
