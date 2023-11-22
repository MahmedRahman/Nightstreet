import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppPageLoadingMore extends GetView {
  final bool display;

  const AppPageLoadingMore({
    required this.display,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: Visibility(
        visible: display,
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
