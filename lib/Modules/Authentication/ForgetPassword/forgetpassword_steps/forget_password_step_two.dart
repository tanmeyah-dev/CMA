// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/pin_code.dart';

class ForgetPasswordStepTwo extends StatefulWidget {
  ForgetPasswordController con;
  final VoidCallback? onChanged;

  ForgetPasswordStepTwo({required this.con, this.onChanged, super.key});

  @override
  State<ForgetPasswordStepTwo> createState() => _ForgetPasswordStepTwoState();
}

class _ForgetPasswordStepTwoState extends State<ForgetPasswordStepTwo> {
  ForgetPasswordController get con => widget.con;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: con.formKey2,
      child: Column(
        children: [
          PinCodeWidget(
            controller: con.codeController,
            length: ForgetPasswordController.otpLength,
            onChangeOTP: (_) {
              widget.onChanged?.call();
              setState(() {});
            },
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (con.activeResend) {
                    con.onResendCode(context);
                  }
                },
                child: Text(
                  'send_again'.tr,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight:
                        con.activeResend ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 16.sp,
                    color: con.activeResend
                        ? ThemeClass.blackColor
                        : ThemeClass.fontColor,
                  ),
                ),
              ),
              Text(
                ' ${con.start} ${'seconds'.tr}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: ThemeClass.blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
