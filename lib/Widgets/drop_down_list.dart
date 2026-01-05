// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Shared/shared_prefirences.dart';
import '../Theme/themeclass.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  final Widget? prefixIcon;
  final Color? borderColor;
  final List<DropdownMenuItem<T>> items;
  final T? selected;
  final void Function(T?) onChange;
  final String hint;
  final String? Function(dynamic)? validate;
  final double? width;
  final OutlineInputBorder? outlineInputBorder;

  const CustomDropDownWidget(
      {Key? key,
      this.prefixIcon,
      this.selected,
      required this.onChange,
      required this.hint,
      this.validate,
      required this.items,
      required this.borderColor,
      this.width,
      this.outlineInputBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(15.w),
    );
    // Ensure selected value exists in items list, otherwise set to null to show hint
    // If selected is null or empty, always show hint
    // Only use selected value if it exists AND matches an item in the list
    final T? validSelected;
    if (selected == null) {
      validSelected = null; // Show hint when nothing is selected
    } else if (items.isEmpty) {
      validSelected = null; // Show hint when items list is empty
    } else {
      // Check if selected value exists in items list
      final existsInItems = items.any((item) => item.value == selected);
      validSelected = existsInItems ? selected : null;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.w),
      child: DropdownButtonFormField<T>(
        validator: validate,
        iconSize: 0.0,
        value: validSelected,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          enabled: true,
          enabledBorder: defaultBorder,
          disabledBorder: defaultBorder,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.w),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: outlineInputBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15.w),
              ),
          suffixIcon: Container(
            child: prefixIcon ??
                RotatedBox(
                  quarterTurns: SharedPref.getCurrentLang() == "ar" ? 1 : 3,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: borderColor ?? ThemeClass.primaryColor,
                  ),
                ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp),
        ),
        items: items,
        onChanged: onChange,
      ),
    );
  }
}
