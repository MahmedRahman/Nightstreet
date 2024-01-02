import 'package:app_night_street/core/component/rounded_text_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CopounField extends GetView {
  CopounField({required this.onSubmitCopoun});
  final Function(String) onSubmitCopoun;
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "كوبون خصم",
          style: TextStyles.font12MediumBlack,
        ),
        const SizedBox(height: 15),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(30),
          dashPattern: const <double>[8, 5],
          padding: EdgeInsets.zero,
          color: Color(0xffA4B0BE),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Row(
              children: [
                Expanded(
                  child: RoundedTextField(
                    controller: textEditingController,
                    labelText: "اضف كود الخصم هنا",
                    maxLines: 1,
                    borderRadius: 18,
                    hideBorder: true,
                  ),
                ),
                InkWell(
                  onTap: () {
                    onSubmitCopoun(textEditingController.text);
                  },
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  child: Container(
                    width: 109,
                    height: 38,
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: Color(0xff490059),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'تحقـــق',
                        style: TextStyles.font16regularwhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
