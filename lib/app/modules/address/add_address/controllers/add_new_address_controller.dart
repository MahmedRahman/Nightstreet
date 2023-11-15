import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/list_addresses/controllers/delivery_addresses_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class AddNewAddressController extends GetxController with StateMixin {
  @override
  void onInit() async {
    super.onInit();

    change(null, status: RxStatus.success());
  }

  void addNewAddress({
    required String cityId,
    required String phone,
    required String address,
    required String email,
    required String name,
    required String notes,
    required String isDefault,
    required String previousRoute,
  }) async {
    //print(cityId.toString());
    //AppDialogs.addAddressSuccess();
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().saveAddresses(
      cityId: cityId.toString(),
      phone: phone.toString(),
      address: address.toString(),
      email: email.toString(),
      name: name.toString(),
      notes: notes.toString(),
      isDefault: isDefault.toString(),
    );

    if (responseModel.data["success"]) {
      AppDialogs.addAddressSuccess();
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.find<DeliveryAddressesController>().getAddress();

          if (previousRoute != '' && previousRoute == '/order-complete') {
            return Get.offAndToNamed(Routes.ORDER_COMPLETE);
          }

          Get.back(closeOverlays: true);
        },
      );
      change("", status: RxStatus.success());
      return;
    } else {
      AppDialogs.showToast(
        message: responseModel.data["message"],
      );
      change("", status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}
