// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/Validator.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/country_code_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import 'validate_user_controller.dart';
import '../../../Utilities/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class ValidateUserScreen extends StatefulWidget {
  static const String routeName = "/validateUser";

  const ValidateUserScreen({super.key});

  @override
  _ValidateUserScreenState createState() => _ValidateUserScreenState();
}

class _ValidateUserScreenState extends StateMVC<ValidateUserScreen> {
  _ValidateUserScreenState() : super(ValidateUserController()) {
    con = controller as ValidateUserController;
  }

  late ValidateUserController con;

  @override
  void initState() {
    super.initState();
    con.resetForm();
    FirebaseAnalytics.instance.logEvent(
      name: 'open_phone_number_screen',
      parameters: <String, Object>{'title': 'open_phone_number_screen'},
    );
  }

  void _onPhoneChanged(String value) {
    final isValid = Validator.validatePhone(context, value) == null;
    if (con.activeBtn != isValid) {
      con.activeBtn = isValid;
      setState(() {});
    }
  }

  Future<void> _onContinue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    FirebaseAnalytics.instance.logEvent(
      name: 'submit_phone_number_screen',
      parameters: <String, Object>{'title': 'submit_phone_number_screen'},
    );
    if (con.formKey.currentState!.validate()) {
      await con.validateUser(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingScreen(
        loading: con.loading,
        child: Scaffold(
          backgroundColor: ThemeClass.whiteColor,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ThemeClass.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Form(
                key: con.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 100.h),
                      image(),
                      SizedBox(height: 20.h),
                      title(),
                      SizedBox(height: 79.h),
                      _phoneFieldSection(),
                      SizedBox(height: 160.h),
                      _phoneFieldSection(child: continueBtn()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return AppTextMedium(title: "enter_number".tr);
  }

  Widget image() {
    return Image.asset(
      AppAssets.IMG_VALIDATE_USER,
      height: 320.h,
      width: 320.w,
      fit: BoxFit.fill,
    );
  }

  Widget _phoneFieldSection({Widget? child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextRegular(
                title: 'phone_number'.tr,
                color: ThemeClass.secondaryColor,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextFieldWidget(
                  onchange: _onPhoneChanged,
                  width: double.infinity,
                  controller: con.phoneController,
                  hint: '1xxxxxxxxx',
                  textInputType: TextInputType.phone,
                  validator: (value) => Validator.validatePhone(context, value),
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

  Widget continueBtn() {
  final buttonWidth = 1.sw - 80.w;

    return Column(
      children: [
        CustomButton(
          width: buttonWidth,
          title: 'continue'.tr,
          onTap: con.activeBtn ? _onContinue : () {},
          color: con.activeBtn ? null : ThemeClass.textFieldBackgroundColor,
          borderColor:
              con.activeBtn ? null : ThemeClass.textFieldBackgroundColor,
          textColor: con.activeBtn ? null : ThemeClass.hintColor,
          backgroundColor:
              con.activeBtn ? null : ThemeClass.buttonNotActiveColor,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
