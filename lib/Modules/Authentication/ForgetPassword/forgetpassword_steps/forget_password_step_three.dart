// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import '../../../../Widgets/simple_animations.dart';

class ForgetPasswordStepThree extends StatefulWidget {
  ForgetPasswordController con;
   ForgetPasswordStepThree({required this.con,Key? key}) : super(key: key);

  @override
  State<ForgetPasswordStepThree> createState() => _ForgetPasswordStepThreeState();
}

class _ForgetPasswordStepThreeState extends State<ForgetPasswordStepThree> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.con.formKey3,
        child: SizedBox(
          height: 330.h,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextRegular(
                    title: "new_password".tr,
                    color: ThemeClass.secondaryColor,
                  ),
                SizedBox(height: 10.h),
                CustomTextFieldWidget(
                        onchange: (value) {
                          if (value.length > 8) {
                            widget.con.activeBtn31 = true;
                          } else {
                            widget.con.activeBtn31 = false;
                          }
                        },
                        obscure: widget.con.showPassword,
                        controller: widget.con.newPasswordController,
                        hint: "new_password".tr,
                        textInputType: TextInputType.text,
                        validator: (value) => Validator.validatePassword(context,value!),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            widget.con.showPassword = !widget.con.showPassword;
                            setState(() {});
                          },
                          child: Icon(
                            widget.con.showPassword ? Icons.visibility : Icons.visibility_off,
                            color: ThemeClass.secondaryColor,
                          ),
                        )

                    ),
                SizedBox(height: 10.h),
                AppTextRegular(
                    title: "confirm_new_password".tr,
                    color: ThemeClass.secondaryColor,
                ),
                SizedBox(height: 10.h),
                 CustomTextFieldWidget(
                        obscure: widget.con.showConfirmPassword,
                        controller: widget.con.confirmNewPasswordController,
                        hint: "confirm_new_password".tr,
                        textInputType: TextInputType.text,
                        onchange: (value) {
                          if (value.length > 8) {
                            widget.con.activeBtn32 = true;
                          } else {
                            widget.con.activeBtn32 = false;
                          }
                        },
                        validator: (value) => Validator.matchPasswords(context,
                            widget.con.newPasswordController.text,
                            widget.con.confirmNewPasswordController.text),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            widget.con.showConfirmPassword = !widget.con.showConfirmPassword;
                            setState(() {});
                          },
                          child: Icon(
                            widget.con.showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            color: ThemeClass.secondaryColor,
                          ),
                        )

                    ),
              ],),),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      // (con.activeBtn32 == true) ?
                      CustomButton(
                        width: 200,
                        title: "reset".tr,
                        onTap: () async {
                          if (widget.con.formKey3.currentState!.validate()) {
                            widget.con.thirdStep(context);
                          }
                        },
                      ),
                      //     :
                      // CustomButton(
                      //   width: 200.w,
                      //   title: "reset".tr,
                      //   onTap: () {},
                      //   color: ThemeClass.textFieldBackgroundColor,
                      //   borderColor: ThemeClass.textFieldBackgroundColor,
                      //   textColor: ThemeClass.hintColor,
                      //   backgroundColor: ThemeClass.buttonNotActiveColor,
                      // ),
                      SizedBox(height: 40.h,),
                    ],
                  ),
            ),
          ]),
        ));
  }
}
