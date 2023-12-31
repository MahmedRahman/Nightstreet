import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  BaseScaffold({
    required this.body,
    this.appBar,
  });
  Widget body;
  PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body,
        ),
      ),
    );
  }
}
