import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/payment_bank/payment_failed_page.dart';
import 'package:krzv2/app/modules/payment_bank/payment_success_page.dart';

// class AppPaymentController extends GetxController with StateMixin {
//   bool Isloading = false;

//   @override
//   void onInit() {
//     change(null, status: RxStatus.success());
//     // TODO: implement onInit
//     super.onInit();
//   }

//   // void success() {
//   //   change(null, status: RxStatus.success());
//   // }
//   void success() {
//     change(null, status: RxStatus.success());
//   }

//   void loading() {
//     // Isloading = true;
//     // if Isloading = false
//     change(null, status: RxStatus.loading());
//   }
// }

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
  //AppPaymentController controller = Get.put(AppPaymentController());
  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onUrlChanged.listen(
      (String url) {
        log(url.toString());
        if (url == FailedPaymentUrl) {
          onFailed.call();
        }

        if (url == SuccessPaymentUrl) {
          print("PaymentSuccess");
          onSuccess.call();
        }
      },
    );

    // flutterWebviewPlugin.onStateChanged.listen(
    //   (state) async {
    //     print("state ${state.type.toString()}");
    //     EasyLoading.show();
    //     switch (state.type) {
    //       case WebViewState.shouldStart:
    //         break;
    //     }
    //   },
    // );

    flutterWebviewPlugin.onProgressChanged.listen(
      (event) async {
        // controller.loading();
        print("event ${event.toStringAsFixed(0).toString()}");

        if (event.toStringAsFixed(0).toString() == "1") {
          // controller.success();
          print("event Done");
        }
      },
    );

    return controller.obx((data) {
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
    });
  }
}
