// ignore_for_file: depend_on_referenced_packages, must_be_immutable, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Authentication/Conditions/conditions_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Register/register_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/app_assets.dart';
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

  RegisterScreen({super.key, required this.phoneNumber});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateMVC<RegisterScreen> {
  _RegisterScreenState() : super(RegisterController()) {
    con = controller as RegisterController;
  }

  late RegisterController con;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    con.setupSession(phoneNumberArg: widget.phoneNumber);
    FocusManager.instance.addListener(_onFocusChange);
    FirebaseAnalytics.instance.logEvent(
      name: 'open_registration_screen',
      parameters: <String, Object>{'title': 'open_registration_screen'},
    );
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);
    _scrollController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!(FocusManager.instance.primaryFocus?.hasFocus ?? false)) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToFocusedField());
  }

  void _scrollToFocusedField() {
    final focusContext = FocusManager.instance.primaryFocus?.context;
    if (focusContext == null) return;

    Scrollable.ensureVisible(
      focusContext,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: 0.2,
    );
  }

  Future<void> _onRegister() async {
    FocusManager.instance.primaryFocus?.unfocus();
    FirebaseAnalytics.instance.logEvent(
      name: 'submit_registration_screen',
      parameters: <String, Object>{'title': 'submit_registration_screen'},
    );
    await con.register(context);
  }

  void _onNationalIdChanged(String value) {
    con.calc(nationalId: value);
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  PreferredSizeWidget _buildRegisterAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'new_account'.tr,
                  style: TextStyle(
                    color: ThemeClass.primaryColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SkipButton(
                  onTap: () {
                    _logAnalytics('skip_registration_screen');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/mainScreen',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 1.sw - 44.w;
    final topPadding = MediaQuery.paddingOf(context).top + kToolbarHeight;
    final view = View.of(context);
    final screenHeight = view.physicalSize.height / view.devicePixelRatio;
    final screenWidth = view.physicalSize.width / view.devicePixelRatio;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: ThemeClass.whiteColor,
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            appBar: _buildRegisterAppBar(),
            body: LoadingScreen(
              loading: con.loading,
              child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        width: screenWidth,
                        height: screenHeight,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppAssets.IMG_LOGIN_BACK),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.only(
                            left: 22.w,
                            right: 22.w,
                            bottom: keyboardInset > 0 ? keyboardInset + 24.h : 24.h,
                          ),
                          child: Form(
                              key: con.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: topPadding + 8.h),
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
                                  createBtn(buttonWidth),
                                  SizedBox(height: 12.h),
                                  !con.editPhone ? loginDes() : Container(),
                                  SharedPref.isWatchIntro()
                                      ? SizedBox(height: 30.h)
                                      : Container()
                                ],
                              )),
                        ),
                      ),
                    ],
                  ))),
            ));
  }

  Widget fullNameTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppTextRegular(
              title: "full_name".tr,
              color: ThemeClass.secondaryColor,
            ),
            SizedBox(
              width: 6.w,
            ),
            AppTextHint(title: "(باللغة العربية)"),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFieldWidget(
            width: double.infinity,
            controller: con.fullNameController,
            hint: "full_name".tr,
            validator: (value) => Validator.validateFullName(context, value!)),
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
            width: double.infinity,
            textInputType: TextInputType.number,
            controller: con.nationalIdController,
            onchange: _onNationalIdChanged,
            hint: "id_num".tr,
            validator: (value) => Validator.validateNationalId(context, value!),
            formatter: [LengthLimitingTextInputFormatter(14)]),
      ],
    );
  }

  Widget dateTimeWidget() {
    final hasDate = con.nationalIdController.text.length > 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextRegular(
          title: 'birthday'.tr,
          color: ThemeClass.secondaryColor,
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 10.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: ThemeClass.whiteColor,
              borderRadius: BorderRadius.circular(14.sp),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.calendar5,
                  color: ThemeClass.secondaryColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    hasDate ? (con.dateOfBirth ?? '') : '0000-00-00',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: hasDate
                          ? ThemeClass.blackColor
                          : const Color(0xFFCCCBCB),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextRegular(
          title: 'phone_number'.tr,
          color: ThemeClass.secondaryColor,
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 10.h),
        con.editPhone
            ? _buildReadOnlyPhoneField(con.displayPhone)
            : Directionality(
                textDirection: TextDirection.ltr,
                child: CustomTextFieldWidget(
                  width: double.infinity,
                  hint: '1xxxxxxxxx',
                  controller: con.numberController,
                  validator: (value) =>
                      Validator.validatePhone(context, value),
                  textInputType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  backGroundColor: ThemeClass.whiteColor,
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
    );
  }

  Widget _buildReadOnlyPhoneField(String phone) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: ThemeClass.whiteColor,
          borderRadius: BorderRadius.circular(14.sp),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const CountryCodeWidget(inline: true),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: Text(
                  phone,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeClass.blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            SizedBox(
              width: 8.w,
            ),
            AppTextHint(title: "*(${"optional".tr})"),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFieldWidget(
          width: double.infinity,
          isDense: false,
          controller: con.emailController,
          hint: "example@example.com",
          validator: (value) => Validator.validateEmail(value!),
        ),
      ],
    );
  }

  Widget passwordTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextRegular(
          title: "password".tr,
          color: ThemeClass.secondaryColor,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFieldWidget(
          width: double.infinity,
          obscure: con.showPassword,
          controller: con.passwordController,
          hint: "password".tr,
          validator: (value) => Validator.validatePassword(context, value!),
          suffixIcon: GestureDetector(
            onTap: () {
              con.showPassword = !con.showPassword;
              setState(() {});
            },
            child: Icon(
              con.showPassword ? SolarIconsBold.eyeClosed : SolarIconsBold.eyeClosed,
              color: con.passwordController.text == ""
                  ? ThemeClass.hintColor
                  : ThemeClass.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget selectGovernment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextRegular(
          title: "government".tr,
          color: ThemeClass.secondaryColor,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: double.infinity,
          child: CustomDropDownWidget<String>(
            hint: "choose_gov".tr,
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
        SizedBox(
          height: 10.h,
        ),
        CustomTextFieldWidget(
          width: double.infinity,
          obscure: con.showConfirmPassword,
          controller: con.confirmPasswordController,
          hint: "confirm_password".tr,
          validator: (value) => Validator.matchPasswords(context,
              con.passwordController.text, con.confirmPasswordController.text),
          suffixIcon: GestureDetector(
            onTap: () {
              con.showConfirmPassword = !con.showConfirmPassword;
              setState(() {});
            },
            child: Icon(
              con.showConfirmPassword ? SolarIconsBold.eyeClosed : SolarIconsBold.eyeClosed,
              color: con.confirmPasswordController.text == ""
                  ? ThemeClass.hintColor
                  : ThemeClass.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget registerDes() {
    return Column(
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
                _logAnalytics('request_terms_screen');
                Navigator.pushNamed(context, TermsScreen.routeName);
              },
              child: AppTextBold(
                  title: "terms".tr,
                  fontSize: 12.sp,
                  textDecoration: TextDecoration.underline)),
          AppTextRegular(title: " ${"and".tr} ", fontSize: 12.sp),
          GestureDetector(
              onTap: () {
                _logAnalytics('request_conditions_screen');
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

  Widget createBtn(double buttonWidth) {
    return CustomButton(
      width: buttonWidth,
      title: 'save'.tr,
      onTap: con.canSubmit ? _onRegister : () {},
      color: con.canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      borderColor:
          con.canSubmit ? null : ThemeClass.textFieldBackgroundColor,
      textColor: con.canSubmit ? null : ThemeClass.hintColor,
      backgroundColor:
          con.canSubmit ? null : ThemeClass.buttonNotActiveColor,
    );
  }

  Widget loginDes() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        AppTextRegular(title: "have_account".tr, fontSize: 12.sp),
        GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppTextBold(
                title: " ${"login".tr}",
                fontSize: 16.sp,
                textDecoration: TextDecoration.underline))
      ]),
    );
  }
}
