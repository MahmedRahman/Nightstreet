import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseBody extends GetView {
  const BaseBody({
    super.key,
    required this.child,
    required this.appBar,
    this.bottomNavigationBar,
  });
  final Widget child;
  final PreferredSizeWidget appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, 0.394),
          end: Alignment(0.0, 1.0),
          colors: [
            const Color(0x0cea8558),
            const Color(0x1942086e),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        body: child,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
