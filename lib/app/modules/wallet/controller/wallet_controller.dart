import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/app/modules/wallet/model/transaction_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class WalletController extends GetxController with StateMixin<TransactionData> {
  final transactions = List<Map<String, dynamic>>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    change(null, status: RxStatus.loading());
    await getTransactions(1);
    super.onInit();
  }

  Future<void> getTransactions(int pageNo) async {
    ResponseModel response = await WebServices().getTransactions(
      pageNo: pageNo,
    );

    if (response.data['success'] == false) {
      change(null, status: RxStatus.error(response.data['message']));
      return;
    }

    try {
      final data = TransactionData.fromJson(response.data['data']);
      change(data, status: RxStatus.success());

      final trasMapList =
          (response.data['data']['transactions']['data'] as List);

      transactions.clear();

      transactions.addAll(
        List.generate(
          trasMapList.length,
          (index) => {
            "operation": trasMapList[index]['type'],
            "description": trasMapList[index]['description'],
            "amount": trasMapList[index]['amount'],
          },
        ),
      );
    } catch (e, st) {
      print('error $e');
      print('stack $st');
    }
  }

  void onPagedChanged(int page) {
    getTransactions(page);
  }

  Future<void> redeemWallet({
    required String code,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().walletRedeem(
      code: code,
    );
    EasyLoading.dismiss();

    if (response.data['success'] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );
      return;
    }

    AppDialogs.showToast(message: response.data["message"].toString());
    final authController = Get.find<AuthenticationController>();
    Future.wait([
      onInit(),
      authController.getProfile(),
    ]);
  }
}
