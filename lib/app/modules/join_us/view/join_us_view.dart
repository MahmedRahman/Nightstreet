import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JoinUs extends StatelessWidget {
  WebViewController? controller;

  JoinUs() {
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

            print("progress ${progress.toString()}");
            if (progress == 100) {
              EasyLoading.dismiss();
              return;
            }
          },
          onPageStarted: (String url) {
            print("url Started ${url.toString()}");
          },
          onPageFinished: (String url) {
            print("url Finished ${url.toString()}");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://krz.sa/j'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "انضم كعيادة أو متجر",
      ),
      body: WebViewWidget(
        controller: controller!,
      ),
    );
  }
}
