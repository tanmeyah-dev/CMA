  // ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../Widgets/custom_textfield_widget.dart';

class ForgetPasswordStepThree extends StatefulWidget {
  ForgetPasswordController con;
  final VoidCallback? onChanged;

  ForgetPasswordStepThree({required this.con, this.onChanged, super.key});

  @override
  State<ForgetPasswordStepThree> createState() =>
      _ForgetPasswordStepThreeState();
}

class _ForgetPasswordStepThreeState extends State<ForgetPasswordStepThree> {
  ForgetPasswordController get con => widget.con;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: con.formKey3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextRegular(
            title: 'new_password'.tr,
            color: ThemeClass.secondaryColor,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            obscure: con.showPassword,
            controller: con.newPasswordController,
            hint: 'new_password'.tr,
            width: double.infinity,
            textInputType: TextInputType.text,
            onchange: (_) => widget.onChanged?.call(),
            validator: (value) => Validator.validatePassword(context, value!),
            suffixIcon: GestureDetector(
              onTap: () {
                con.toggleShowPassword();
                setState(() {});
              },
              child: Icon(
                con.showPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                color: ThemeClass.secondaryColor,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          AppTextRegular(
            title: 'confirm_new_password'.tr,
            color: ThemeClass.secondaryColor,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            obscure: con.showConfirmPassword,
            controller: con.confirmNewPasswordController,
            hint: 'confirm_new_password'.tr,
            width: double.infinity,
            textInputType: TextInputType.text,
            onchange: (_) => widget.onChanged?.call(),
            validator: (value) => Validator.matchPasswords(
              context,
              con.newPasswordController.text,
              con.confirmNewPasswordController.text,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                con.toggleShowConfirmPassword();
                setState(() {});
              },
              child: Icon(
                con.showConfirmPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                color: ThemeClass.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
