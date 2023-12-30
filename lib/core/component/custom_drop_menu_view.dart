import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDropMenuView<T> extends GetView {
  const CustomDropMenuView({
    Key? key,
    required this.labelText,
    required this.itemAsString,
    required this.items,
    required this.onChanged,
    required this.dropdownBuilder,
    required this.popupItemBuilder,
    this.fieldHeight,
    this.fieldWidth,
    this.requiredFiled = false,
    this.selectedItem,
    this.popupItemDisabled,
  }) : super(key: key);

  final List<T>? items;
  final T? selectedItem;
  final String? labelText;
  final double? fieldWidth;
  final bool requiredFiled;
  final double? fieldHeight;
  final Function(T?)? onChanged;
  final bool Function(T)? popupItemDisabled;
  final DropdownSearchItemAsString<T>? itemAsString;
  final Widget Function(BuildContext, T?)? dropdownBuilder;
  final Widget Function(BuildContext, T, bool)? popupItemBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      dropdownButtonProps: DropdownButtonProps(
        icon: SvgPicture.asset("images/svg/drop_menu.svg"),
      ),
      items: items!,
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      validator: (value) {
        if (requiredFiled) {
          if (value == null || value == '') {
            return 'required_field'.tr;
          }
        }
        return null;
      },
      dropdownBuilder: dropdownBuilder ?? null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 25,
          ),
          filled: true,
          hintStyle: TextStyle(
            fontSize: 13,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
        ),
      ),
      onChanged: onChanged,
    );
  }

  OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          30,
        ),
      );
}
