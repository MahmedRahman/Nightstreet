import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  final String? customerPhone;
  const AuthHeader({
    super.key,
    required this.title,
    required this.description,
    this.customerPhone,
  });

  const AuthHeader.login({
    super.key,
    this.customerPhone,
  })  : title = "مرحباً بعودتك",
        description = 'سجل الدخول الى حسابك وتمتع بأقوى وأميز عروض العيادات\nوالمراكز الطبية والتجميلية';

  const AuthHeader.register({
    super.key,
    this.customerPhone,
  })  : title = "انشاء حساب",
        description = 'انضم الينا وتمتع بأقوى عروض العيادات والمراكز الطبية في\nالمملكة';

  const AuthHeader.verifyCode({
    super.key,
    required this.customerPhone,
  })  : title = "ادخل رمز التفعيل",
        description = 'لقد أرسلنا رسالة نصية قصيرة تحتوي على رمز التفعيل\nإلى هاتفك $customerPhone';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppSvgAssets.verticalIcon),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.mainColor,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.008,
            height: 2.81,
          ),
        ),
      ],
    );
  }
}
