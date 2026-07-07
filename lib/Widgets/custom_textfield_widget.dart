// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';

// ignore: must_be_immutable
class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final Color? backGroundColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final bool? enable, isDense;
  final Color? borderColor;
  final double? borderRadiusValue, width, height;
  final EdgeInsets? insidePadding;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onchange, onFieldSubmitted;
  final Function()? onSuffixTap;
  final void Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final double? suffixWidth;
  final BoxConstraints? prefixIconConstraints;
  final TextAlign? textAlign;

  const CustomTextFieldWidget({
    super.key,
    this.isDense,
    this.style,
    this.onchange,
    this.onFieldSubmitted,
    this.insidePadding,
    this.validator,
    this.maxLine,
    this.hint,
    this.backGroundColor,
    this.controller,
    this.obscure = false,
    this.enable = true,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.borderColor,
    this.borderRadiusValue,
    this.prefixIcon,
    this.width,
    this.hintStyle,
    this.suffixIcon,
    this.onSuffixTap,
    this.height,
    this.onTap,
    this.formatter,
    this.suffixWidth = 30,
    this.prefixIconConstraints,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 366.w,
       // height: height ?? 48.h,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        readOnly: readOnly ?? false,
        validator: validator,
        onTap: () => onTap,
        enabled: enable,
        inputFormatters: formatter ?? [],
        obscureText: obscure ?? false,
        controller: controller,
        decoration: InputDecoration(
          helperText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(width: 1,color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ThemeClass.secondaryMediumColor),
            borderRadius: BorderRadius.circular(14.sp),
          ),
          errorStyle: TextStyle(height: 1),
          errorBorder:OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: ThemeClass.primaryColor),
            borderRadius: BorderRadius.circular(14.sp),
          ),
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          isDense: isDense ?? false,
          prefixIconConstraints: prefixIconConstraints ??
              BoxConstraints(
                minWidth: prefixIcon == null ? 0 : 35.w,
                maxHeight: prefixIcon == null ? 0 : 48.h,
              ),
          suffixIconConstraints: BoxConstraints(
              minWidth: suffixIcon == null ? 0 : 45.w, maxHeight: 40.h),
          contentPadding: insidePadding ?? EdgeInsets.symmetric(vertical: 16.h,horizontal: 4.w),
          fillColor: backGroundColor,
          filled: backGroundColor != null,
          hintText: hint,
          prefixIcon: prefixIcon ?? SizedBox(
                  width: 10.w,
                ),
          suffixIcon: suffixIcon == null
              ? SizedBox(
                  width: 5.w,
                )
              : InkWell(
                  onTap: onSuffixTap,
                  child: SizedBox(
                      width: suffixWidth?.w ?? 30.w, child: suffixIcon),
                ),
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFCCCBCB),
                  fontWeight: FontWeight.w400,

              ),
        ),
        onChanged: onchange,
        textCapitalization: TextCapitalization.words,
        maxLines: maxLine ?? 1,
        keyboardType: textInputType,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ThemeClass.blackColor,
            ),
      ),
    );
  }
}
