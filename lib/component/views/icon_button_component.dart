import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final int? count;

  CustomIconButton({
    required this.onTap,
    required this.iconPath,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Badge.count(
        isLabelVisible: !(count == 0),
        count: count!,
        backgroundColor: AppColors.mainColor,
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: onTap,
          child: Container(
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.greyColor4,
              border: Border.all(
                width: 1.0,
                color: AppColors.borderColor2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                iconPath,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


          //  count: count ?? 0,
          // isLabelVisible: count == 0,
    // );
    // Container(
    //   margin: const EdgeInsets.all(5),
    //   ,
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: ,
    //   ),
    // ),
    //  Stack(
    //   alignment: Alignment.topRight,
    //   children: [
    //     InkWell(
    //       overlayColor: MaterialStateProperty.all(Colors.transparent),
    //       onTap: onTap,
    //       child: Container(
    //         width: 50.0,
    //         height: 50.0,
    //         margin: const EdgeInsets.all(5),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10.0),
    //           color: AppColors.greyColor4,
    //           border: Border.all(
    //             width: 1.0,
    //             color: AppColors.borderColor2,
    //           ),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: SvgPicture.asset(
    //             iconPath,
    //           ),
    //         ),
    //       ),
    //     ),
    //     if (count! > 0)
    //       Container(
    //         width: 16.0,
    //         height: 16.0,
    //         decoration: const BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: AppColors.mainColor,
    //         ),
    //         child: Center(
    //           child: Text(
    //             count.toString(),
    //             style: TextStyle(
    //               fontSize: 9.0,
    //               color: Colors.white.withOpacity(0.9),
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //       ),
    //   ],
    // );
