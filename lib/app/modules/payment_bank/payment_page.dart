import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/payment_bank/payment_failed_page.dart';
import 'package:krzv2/app/modules/payment_bank/payment_success_page.dart';
import 'package:krzv2/web_serives/api_constant.dart';

class AppPaymentPage extends GetView {
  final String PaymentUrl;
  final String FailedPaymentUrl;
  final String SuccessPaymentUrl;
  Function onFailed;
  Function onSuccess;
  AppPaymentPage({
    required this.PaymentUrl,
    required this.FailedPaymentUrl,
    required this.SuccessPaymentUrl,
    required this.onFailed,
    required this.onSuccess,
  });
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onUrlChanged.listen(
      (String url) {
        log(url.toString());
        if (url == FailedPaymentUrl) {
          onFailed.call();
          //Get.offAll(PaymentFailedPage());
        }

        if (url == SuccessPaymentUrl) {
          print("PaymentSuccess");
          onSuccess.call();
          //Get.offAll(PaymentSuccessPage());
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
