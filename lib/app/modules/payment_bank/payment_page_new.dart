
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppPaymentNewPage extends StatelessWidget {
  final String PaymentUrl;
  final String FailedPaymentUrl;
  final String SuccessPaymentUrl;
  Function onFailed;
  Function onSuccess;
  WebViewController? controller;
  AppPaymentNewPage({
    required this.PaymentUrl,
    required this.FailedPaymentUrl,
    required this.SuccessPaymentUrl,
    required this.onFailed,
    required this.onSuccess,
  }) {
    EasyLoading.show();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            if (progress == 0) {
              return;
            }

            //print("progress ${progress.toString()}");
            if (progress == 100) {
              EasyLoading.dismiss();
              return;
            }
          },
          onPageStarted: (String url) {
            // print("url Started ${url.toString()}");

         

            // print(url);
          },
          onPageFinished: (String url) {
            print("url Finished ${url.toString()}");

               if (url == FailedPaymentUrl) {
              onFailed.call();
            }

            if (url == SuccessPaymentUrl) {
              onSuccess.call();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(PaymentUrl.toString()));
  }

  // final flutterWebviewPlugin = new FlutterWebviewPlugin();
  //AppPaymentController controller = Get.put(AppPaymentController());
  // @override
  // Widget build(BuildContext context) {
  //   // flutterWebviewPlugin.onUrlChanged.listen(
  //   //   (String url) {
  //   //     log(url.toString());
  //   //     if (url == FailedPaymentUrl) {
  //   //       onFailed.call();
  //   //     }

  //   //     if (url == SuccessPaymentUrl) {
  //   //       print("PaymentSuccess");
  //   //       onSuccess.call();
  //   //     }
  //   //   },
  //   // );

  //   // // flutterWebviewPlugin.onStateChanged.listen(
  //   // //   (state) async {
  //   // //     print("state ${state.type.toString()}");
  //   // //     EasyLoading.show();
  //   // //     switch (state.type) {
  //   // //       case WebViewState.shouldStart:
  //   // //         break;
  //   // //     }
  //   // //   },
  //   // // );

  //   // flutterWebviewPlugin.onProgressChanged.listen(
  //   //   (event) async {
  //   //     // controller.loading();
  //   //     print("event ${event.toStringAsFixed(0).toString()}");

  //   //     if (event.toStringAsFixed(0).toString() == "1") {
  //   //       // controller.success();
  //   //       print("event Done");
  //   //     }
  //   //   },
  //   // );

  //   // return controller.obx((data) {
  //   //   return Scaffold(
  //   //     body: WebviewScaffold(
  //   //       appBar: AppBar(
  //   //         backgroundColor: Colors.transparent,
  //   //         automaticallyImplyLeading: false,
  //   //         title: Text(
  //   //           "صفحه الدفع",
  //   //           style: TextStyle(
  //   //             color: Colors.black,
  //   //           ),
  //   //         ),
  //   //         elevation: 0,
  //   //       ),
  //   //       url: PaymentUrl,
  //   //       initialChild: Container(
  //   //         child: Center(
  //   //           child: CircularProgressIndicator(),
  //   //         ),
  //   //       ),
  //   //     ),
  //   //   );
  //   // });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: WebViewWidget(
        controller: controller!,
      ),
    );
  }
}
