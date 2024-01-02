import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainInformation extends GetView {
  const MainInformation({
    super.key,
    required this.onAboutTapped,
    required this.onTermsTapped,
    required this.onContactUsTapped,
    required this.onShareTapped,
  });

  final Function() onAboutTapped;
  final Function() onTermsTapped;
  final Function() onContactUsTapped;
  final Function() onShareTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المعلومات الاساسية',
          style: TextStyles.font14mediumBlack.copyWith(
            color: const Color(0xff666c89),
          ),
        ),
        const SizedBox(height: 17),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(11.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x08000000),
                offset: Offset(0, 5),
                blurRadius: 60,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                _buildListTile(
                  title: 'من نحن',
                  leadingIcon: "images/svg/about_us_icon.svg",
                  onTap: onAboutTapped,
                ),
                Divider(
                  color: Color(0xffE0E4F5),
                ),
                _buildListTile(
                  title: 'شروط الاستخدام',
                  leadingIcon: "images/svg/terms_icon.svg",
                  onTap: onTermsTapped,
                ),
                Divider(
                  color: Color(0xffE0E4F5),
                ),
                _buildListTile(
                  title: 'تواصل معنا',
                  leadingIcon: "images/svg/contact_us_icon.svg",
                  onTap: onContactUsTapped,
                ),
                Divider(
                  color: Color(0xffE0E4F5),
                ),
                _buildListTile(
                  title: 'شارك التطبيق مع صديق و اكسب',
                  leadingIcon: "images/svg/share_icon.svg",
                  onTap: onShareTapped,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required String title,
    required String leadingIcon,
    required Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leadingIcon),
      title: Text(
        title,
        style: TextStyles.font14mediumBlack,
      ),
      trailing: SvgPicture.asset("images/svg/menu_arrow.svg"),
    );
  }
}
