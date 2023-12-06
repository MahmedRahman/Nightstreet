import 'package:flutter/material.dart';

Widget AppLogo() {
  return Container(
    width: 102,
    height: 102,
    decoration: BoxDecoration(
      color: Color(0xff490059),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    child: Image.asset(
      "images/png/cxss.png",
    ),
  );
}
