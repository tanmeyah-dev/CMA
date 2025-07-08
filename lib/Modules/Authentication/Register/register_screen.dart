// ignore_for_file: depend_on_referenced_packages, must_be_immutable, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Authentication/Conditions/conditions_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Register/register_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/themeclass.dart';
import '../../../Utilities/Validator.dart';
import '../../../Widgets/country_code_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import '../../../Widgets/drop_down_list.dart';
import '../../../Widgets/skip_button.dart';
import '../Terms/terms_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  String phoneNumber;

  RegisterScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateMVC<RegisterScreen> {
  _RegisterScreenState() : super(RegisterController()) {
    con = RegisterController();
  }

  late RegisterController con;

  @override
  void initState() {
    if (widget.phoneNumber != "") {
      con.phone = widget.phoneNumber;
      con.editPhone = true;
    } else {
      con.editPhone = false;
    }
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_registration_screen',
        parameters: <String,dynamic>{
          "title" : "open_registration_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: ThemeClass.whiteColor,
            appBar: BaseAppBar.main(
                title: "create_account".tr,
                isBackButtonVisible: false,
                actions: [
                  Padding(
                      padding: EdgeInsetsDirectional.only(top: 16.h, end: 20.w),
                      child: SkipButton(
                          onTap: () {
                            final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                            _analytics.logEvent(
                                name: 'skip_registration_screen',
                                parameters: <String,dynamic>{
                                  "title" : "skip_registration_screen"
                                }
                            );
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/mainScreen',
                                    (Route<dynamic> route) => false);
                          }
                            ))
                ]),
            body: LoadingScreen(
              loading: con.loading,
              child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: SingleChildScrollView(
                          child: Form(
                              key: con.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  fullNameTxtField(),
                                  SizedBox(height: 10.h),
                                  nationalIdTxtField(),
                                  SizedBox(height: 10.h),
                                  dateTimeWidget(),
                                  SizedBox(height: 10.h),
                                  phoneTxtField(),
                                  SizedBox(height: 10.h),
                                  emailTxtField(),
                                  SizedBox(height: 10.h),
                                  selectGovernment(),
                                  SizedBox(height: 10.h),
                                  passwordTxtField(),
                                  SizedBox(height: 10.h),
                                  confirmPassTxtField(),
                                  registerDes(),
                                  SizedBox(height: 30.h),
                                  createBtn(),
                                  SizedBox(height: 12.h),
                                  !con.editPhone
                                      ? loginDes()
                                      : Container(),
                                  SharedPref.isWatchIntro()
                                      ? SizedBox(height: 30.h)
                                      : Container()
                                ],
                              ))))),
            )));
  }

  Widget fullNameTxtField() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppTextRegular(
                title: "${"full_name".tr}",
                color: ThemeClass.secondaryColor,
              ),
              SizedBox(width: 6.w,),
              AppTextHint(title: "(باللغة العربية)"),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFieldWidget(
              controller: con.fullNameController,
              hint: "full_name".tr,
              validator: (value) =>
                  Validator.validateFullName(context, value!)),
        ],
      );
  }

  Widget nationalIdTxtField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "id_num".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFieldWidget(
              textInputType: TextInputType.number,
              controller: con.nationalIdController,
              onchange: (value) {
                con.calc(nationalId : value);
                setState(() {});
              },
              hint: "id_num".tr,
              validator: (value) =>
                  Validator.validateNationalId(context, value!),
              formatter: [LengthLimitingTextInputFormatter(14)]),
        ],
      );
  }

  Widget dateTimeWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "birthday".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: ThemeClass.textfieldColor,
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            width: double.infinity,
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                con.nationalIdController.text.length > 7
                    ? AppTextRegular(
                  title: con.dateOfBirth??"",
                  )
                    : const AppTextHint(title: "0000-00-00"),
                Icon(Iconsax.calendar5, color: ThemeClass.secondaryColor,),
              ],
            ),
          ),
        ],
      );
  }

  Widget phoneTxtField() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "phone_number".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              con.editPhone
                  ? CustomTextFieldWidget(
                  width: 270.w, hint: con.phone, enable: false)
                  : CustomTextFieldWidget(
                width: 270.w,
                hint: "phone_number".tr,
                controller: con.numberController,
                validator: (value) => Validator.validatePhone(context, value!),
                textInputType: TextInputType.phone,
                formatter: [
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              SizedBox(
                width: 8.w,
              ),
              const CountryCodeWidget(),
            ],
          ),
        ],
      );
  }

  Widget emailTxtField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppTextRegular(
                title: "email".tr,
                color: ThemeClass.secondaryColor,
              ),
              SizedBox(width: 8.w,),
              AppTextHint(title: "*(${"optional".tr})"),
            ],
          ),
          SizedBox(height: 10.h,),
          CustomTextFieldWidget(
            isDense: false,
            controller: con.emailController,
            hint: "example@example.com",
            validator: (value) => Validator.validateEmail(value!),
          ),
        ],
      );
  }

  Widget passwordTxtField() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "password".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(height: 10.h,),
          CustomTextFieldWidget(
            obscure: con.showPassword,
            controller: con.passwordController,
            hint: "password".tr,
            validator: (value) => Validator.validatePassword(context, value!),
            suffixIcon: GestureDetector(
              onTap: (){
                con.showPassword = !con.showPassword;
                setState(() { });
              },
               child: Icon(con.showPassword ? Iconsax.eye4 : Iconsax.eye_slash5,color: con.passwordController.text == "" ? ThemeClass.hintColor: ThemeClass.secondaryColor,),
            ),

          ),
        ],
      );
  }

  Widget selectGovernment() {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "government".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(height: 10.h,),
           CustomDropDownWidget<String>(
              hint: "المحافظه",
              selected: con.selectedValue,
              onChange: (v) {
                con.selectedValue = v!;
                setState(() {});
              },
              borderColor: Colors.grey,
              items: con.governmentsIds.map((item) {
                return DropdownMenuItem<String>(
                      value: item.id,
                  child: Text(item.title,
                      style: TextStyle(fontSize: 16.sp, height: -0.2)),
                );
              }).toList(),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Icon(
                  Iconsax.arrow_down5,
                  color: ThemeClass.secondaryColor,
                ),
              ),
            ),
        ],
      );
  }

  Widget confirmPassTxtField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextRegular(
            title: "confirm_password".tr,
            color: ThemeClass.secondaryColor,
          ),
          SizedBox(height: 10.h,),
          CustomTextFieldWidget(
            obscure: con.showConfirmPassword,
            controller: con.confirmPasswordController,
            hint: "confirm_password".tr,
            validator: (value) =>
                Validator.matchPasswords(context,
                    con.passwordController.text,
                    con.confirmPasswordController.text),
            suffixIcon: GestureDetector(
              onTap: (){
                con.showConfirmPassword = !con.showConfirmPassword;
                setState(() { });
              },
              child: Icon(con.showConfirmPassword ? Iconsax.eye4 : Iconsax.eye_slash5,color: con.confirmPasswordController.text == "" ? ThemeClass.hintColor: ThemeClass.secondaryColor,),
            ),
          ),
        ],
      );
  }

  Widget registerDes() {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  shape: ContinuousRectangleBorder(),
                  value: con.accept,
                  onChanged: (value) {
                    con.accept = !con.accept;
                    setState(() {});
                  },
                  activeColor: ThemeClass.primaryColor,
                ),
                AppTextRegular(title: "register_des".tr, fontSize: 12.sp),
              ],
            ),
            Row(children: [
              GestureDetector(
                  onTap: () {
                    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                    _analytics.logEvent(
                        name: 'request_terms_screen',
                        parameters: <String,dynamic>{
                          "title" : "request_terms_screen"
                        }
                    );
                    Navigator.pushNamed(context, TermsScreen.routeName);
                  },
                  child: AppTextBold(
                      title: "terms".tr,
                      fontSize: 12.sp,
                      textDecoration: TextDecoration.underline)),
              AppTextRegular(title: " ${"and".tr} ", fontSize: 12.sp),
              GestureDetector(
                  onTap: () {
                    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                    _analytics.logEvent(
                        name: 'request_conditions_screen',
                        parameters: <String,dynamic>{
                          "title" : "request_conditions_screen"
                        }
                    );
                    Navigator.pushNamed(context, ConditionsScreen.routeName);
                  },
                  child: AppTextBold(
                      title: "privacy".tr,
                      fontSize: 12.sp,
                      textDecoration: TextDecoration.underline)),
              AppTextRegular(title: " ${"ours".tr} ", fontSize: 12.sp)
            ])
          ],
        );
  }

  Widget createBtn() {
    return Align(
          alignment: Alignment.center,
          child:
          (con.selectedValue != null && con.accept == true ) ?
          CustomButton(
              width: 216,
              title: "save".tr,
              onTap: () async {
                  if (con.formKey.currentState!.validate()) {
                    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                    _analytics.logEvent(
                        name: 'submit_registration_screen',
                        parameters: <String,dynamic>{
                          "title" : "submit_registration_screen"
                        }
                    );
                    con.register(context);
                  }
                }
              ) :
          CustomButton(
              width: 216,
              title: "save".tr,
              onTap: () async {},
            color: ThemeClass.textFieldBackgroundColor,
            borderColor:
            ThemeClass.textFieldBackgroundColor,
            textColor: ThemeClass.hintColor,
            backgroundColor:
            ThemeClass.buttonNotActiveColor,
          )

          ,
        );
  }

  Widget loginDes() {
    return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextRegular(title: "have_account".tr, fontSize: 12.sp),
                GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, LoginScreen.routeName,
                      //     arguments: "");
                      Navigator.pop(context);
                    },
                    child: AppTextBold(
                        title: " ${"login".tr}",
                        fontSize: 16.sp,
                        textDecoration: TextDecoration.underline))
              ]),
        );
  }
}
