// ignore_for_file: must_be_immutable

import 'package:Tanmeyah/Modules/Authentication/ForgetPassword/forget_password_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Widgets/country_code_widget.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import '../../../../Widgets/simple_animations.dart';


class ForgetPasswordStepOne extends StatefulWidget {
  ForgetPasswordController con;
   ForgetPasswordStepOne({required this.con,Key? key}) : super(key: key);

  @override
  State<ForgetPasswordStepOne> createState() => _ForgetPasswordStepOneState();
}

class _ForgetPasswordStepOneState extends State<ForgetPasswordStepOne> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.con.formKey,
        child: SizedBox(
            height: 330.h,
            child: Column(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextRegular(
                        title: "id_num".tr,
                        color: ThemeClass.secondaryColor,
                      ),
                    SizedBox(
                      height: 12.h,
                    ),
                     CustomTextFieldWidget(
                            controller: widget.con.nationalIdController,
                            hint: "id_num".tr,
                            onchange: (value) {
                              if (value.length == 14) {
                                widget.con.activeBtn1 = true;
                              } else {
                                widget.con.activeBtn1 = false;
                              }
                              setState(() {});
                            },
                            textInputType: TextInputType.phone,
                            validator: (value) =>
                                Validator.validateNationalId(context,value!),
                            formatter: [LengthLimitingTextInputFormatter(14)]),
                    SizedBox(height: 10.h),
                    AppTextRegular(
                        title: "phone_number".tr,
                        color: ThemeClass.secondaryColor,
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      CustomTextFieldWidget(
                                width: 215.w,
                                controller: widget.con.phoneController,
                                hint: "phone_number".tr,
                                textInputType: TextInputType.phone,
                                onchange: (value) {
                                  if (value.length >= 10) {
                                    widget.con.activeBtn12 = true;
                                  } else {
                                    widget.con.activeBtn12 = false;
                                  }
                                  setState(() {});
                                },
                                validator: (value) =>
                                    Validator.validatePhone(context,value!),
                                formatter: [
                                  LengthLimitingTextInputFormatter(11),
                                ]),
                        SizedBox(
                          width: 8.w,
                        ),
                         const CountryCodeWidget(),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 100.h),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                       Column(
                            children: [
                              (widget.con.activeBtn1 == true &&
                                  widget.con.activeBtn12 == true)
                                  ? CustomButton(
                                  width: 200,
                                  title: "continue".tr,
                                  onTap: () async {
                                    if (widget.con.formKey.currentState!.validate()) {
                                      widget.con.firstStep(context);
                                    }
                                  })
                                  : CustomButton(
                                width: 200,
                                title: "continue".tr,
                                onTap: () async {},
                                color: ThemeClass.textFieldBackgroundColor,
                                borderColor:
                                ThemeClass.textFieldBackgroundColor,
                                textColor: ThemeClass.hintColor,
                                backgroundColor:
                                ThemeClass.buttonNotActiveColor,
                              ),
                              SizedBox(height: 30.h,),
                            ],
                          ),
                      SizedBox(height:10.h,)
                    ],
                  ))
            ])));
  }
}
