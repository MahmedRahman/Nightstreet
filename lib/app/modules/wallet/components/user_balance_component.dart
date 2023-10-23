import 'package:flutter/material.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class UserBalanceWidget extends StatelessWidget {
  const UserBalanceWidget({
    super.key,
    required this.userBalance,
  });

  final String userBalance;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      height: 110.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            userBalance,
            style: const TextStyle(
              fontSize: 30.0,
              color: AppColors.blackColor,
              height: 0.63,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height10,
          const Text(
            'رصيد محفظتك الحالي',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              letterSpacing: 0.48,
              height: 0.75,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
