// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Theme/themeclass.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController controller;
  final int length;
  final double? size;
  final Function(String) onChangeOTP;

  const PinCodeWidget(
      {Key? key, required this.controller, this.length = 5, this.size, required this.onChangeOTP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 375.w,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // 💡 Only allow digits (0-9)
          ],
          appContext: context,
          length: length,
          obscureText: false,
          animationType: AnimationType.fade,
          cursorColor: ThemeClass.blackColor,
          validator: (String? v) {
            if (v == null || v.isEmpty || v.length != 5){
              return  "";
            }
            return null;
          },
          pinTheme: PinTheme(
            borderRadius: BorderRadius.circular(10.w),
            borderWidth: 1,
            errorBorderColor: Colors.red,
            shape: PinCodeFieldShape.box,
            fieldHeight: 48.h,
            fieldWidth: 48.w,
            activeFillColor: Colors.transparent,
            activeColor: ThemeClass.hintColor,
            inactiveColor: ThemeClass.textFieldBackgroundColor,
            selectedColor:  ThemeClass.secondaryColor,
            inactiveFillColor: ThemeClass.buttonNotActiveColor,
            selectedFillColor: Color(0xFFF9F9F9),
          ),
          hintCharacter: " ",
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          autoDisposeControllers: false,
          controller: controller,
          onChanged: (value) {
            onChangeOTP(value);
          },
          keyboardType: TextInputType.phone,
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
