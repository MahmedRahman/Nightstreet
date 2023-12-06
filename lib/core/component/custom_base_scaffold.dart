import 'package:app_night_street/core/app_color.dart';
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
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}
