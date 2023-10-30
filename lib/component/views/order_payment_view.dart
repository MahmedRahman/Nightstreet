import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/payment_bank/payment_failed_page.dart';
//import 'package:krzv2/app/modules/gift_cards/views/payment_failed_page.dart';
import 'package:krzv2/component/views/order_payment_success_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_constant.dart';

class OrderPaymentView extends GetView {
  final String PaymentUrl;
  OrderPaymentView({required this.PaymentUrl});
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onUrlChanged.listen(
      (String url) {
        print('url => $url');
        if (url == "${ApiConstant.baseUrl}/orders/rajhi-failed-callback") {
          Get.offAll(PaymentFailedPage());
        }

        if (url == "${ApiConstant.baseUrl}/orders/rajhi-success-callback") {
          Get.offAll(OrderPaymentSuccessView());
          authController.getProfile();
        }
      },
    );

    return Scaffold(
      body: WebviewScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            "صفحه الدفع",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        url: PaymentUrl,
        initialChild: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
