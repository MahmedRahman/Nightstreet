import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBuilder extends GetView {
  const CategoryBuilder({
    super.key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  });
  final String name;
  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xffD7D9DB),
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(name),
        ],
      ),
    );
  }
}
