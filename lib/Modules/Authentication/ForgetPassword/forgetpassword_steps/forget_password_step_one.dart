// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Widgets/country_code_widget.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../Widgets/custom_textfield_widget.dart';

class ForgetPasswordStepOne extends StatefulWidget {
  ForgetPasswordController con;
  final VoidCallback? onChanged;

  ForgetPasswordStepOne({required this.con, this.onChanged, super.key});

  @override
  State<ForgetPasswordStepOne> createState() => _ForgetPasswordStepOneState();
}

class _ForgetPasswordStepOneState extends State<ForgetPasswordStepOne> {
  ForgetPasswordController get con => widget.con;

  void _onChanged(String _) {
    widget.onChanged?.call();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: con.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextRegular(
            title: 'id_num'.tr,
            color: ThemeClass.secondaryColor,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            controller: con.nationalIdController,
            hint: 'id_num'.tr,
            onchange: _onChanged,
            width: double.infinity,
            textInputType: TextInputType.phone,
            validator: (value) => Validator.validateNationalId(context, value!),
            formatter: [
              LengthLimitingTextInputFormatter(
                ForgetPasswordController.nationalIdLength,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AppTextRegular(
            title: 'phone_number'.tr,
            color: ThemeClass.secondaryColor,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.h),
          Directionality(
            textDirection: TextDirection.ltr,
            child: CustomTextFieldWidget(
              controller: con.phoneController,
              hint: '1xxxxxxxxx',
              onchange: _onChanged,
              width: double.infinity,
              textInputType: TextInputType.phone,
              validator: (value) => Validator.validatePhone(context, value!),
              formatter: [
                LengthLimitingTextInputFormatter(11),
              ],
              prefixIcon: const CountryCodeWidget(inline: true),
              prefixIconConstraints: BoxConstraints(
                minWidth: 88.w,
                minHeight: 48.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
