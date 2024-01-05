import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  OrderAppBar({
    required String this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          CustomBackButton(
            backGroundColor: const Color(0x0f6c727f),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyles.font14mediumBlack,
          )
        ],
      ),
      actions: [
        Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset("images/svg/support_icon.svg"),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
