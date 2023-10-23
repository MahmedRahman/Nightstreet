import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ShareIconView extends GetView {
  const ShareIconView({
    Key? key,
    required this.onShareTapped,
  }) : super(key: key);

  final Function() onShareTapped;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onShareTapped,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: DecoratedContainer(
        width: 40,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            AppSvgAssets.shareIcon,
          ),
        ),
      ),
    );
  }
}
