import 'package:flutter/material.dart';

/// A widget that displays a centered circular loading indicator.
class CenterLoading extends StatelessWidget {
  final Color? color;

  const CenterLoading({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color?>(color),
        backgroundColor:
            Theme.of(context).platform == TargetPlatform.android ? null : color,
      ),
    );
  }
}
