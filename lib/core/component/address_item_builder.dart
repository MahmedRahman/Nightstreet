import 'package:app_night_street/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../app_dimensions.dart';
import '../themes/text_styles.dart';

class AddressItemBuilder extends GetView {
  const AddressItemBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
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
        padding: AppDimension.appPadding,
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0x1ee0a387),
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  "images/svg/location_icon.svg",
                ),
              ),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'المنزل',
                  style: TextStyles.font12regularGray2,
                ),
                SizedBox(height: 5),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * .5,
                  ),
                  child: Text(
                    'منوف شارعع مجلس المدينة ، عمارةع مجلس المدينة ، عمارةع مجلس المدينة ، عمارة ٤ب',
                    style: TextStyles.font12regularBlack,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            PopupMenuButton(
              child: SvgPicture.asset("images/svg/3_dots_icon.svg"),
              itemBuilder: (context) {
                return List.generate(
                  Constants.KDropMenuList.length,
                  (index) {
                    final item = Constants.KDropMenuList[index];
                    return PopupMenuItem(
                      child: Text(item),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
