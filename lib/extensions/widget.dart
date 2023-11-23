import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetX on Widget {
  Widget shimmer({bool loading = true}) {
    if (loading == false) return this;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: this,
    );
  }
}
