import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetX on Widget {
  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: this,
    );
  }
}
