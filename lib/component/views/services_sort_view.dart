import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';

class ServicesSortView extends GetView {
  const ServicesSortView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'العيادات',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
        Spacer(),
        DecoratedContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Text(
                    'الترتيب',
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 0.86,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  SvgPicture.asset(
                    "assets/svg/Iconly-Light-outline-Swap.svg",
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
