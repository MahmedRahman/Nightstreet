import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/payment_bank/payment_failed_page.dart';
import 'package:krzv2/app/modules/payment_bank/payment_success_page.dart';
import 'package:krzv2/web_serives/api_constant.dart';

class paymentPage extends GetView {
  final String PaymentUrl;

  paymentPage({required this.PaymentUrl});
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onStateChanged.listen((viewState) async {
      if (viewState.type == WebViewState.finishLoad) {
        // flutterWebViewPlugin.evalJavascript(js);
      }
    });

    flutterWebviewPlugin.onUrlChanged.listen(
      (String url) {
        if (url == "${ApiConstant.baseUrl}/coupons/rajhi-failed-callback") {
          Get.offAll(PaymentFailedPage());
        }

        if (url == "${ApiConstant.baseUrl}/coupons/rajhi-success-callback") {
          print("PaymentSuccess");
          Get.offAll(PaymentSuccessPage());
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
