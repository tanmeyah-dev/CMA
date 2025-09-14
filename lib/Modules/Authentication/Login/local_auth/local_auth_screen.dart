// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/Validator.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import 'local_auth_controller.dart';import 'package:iconsax/iconsax.dart';import 'package:firebase_analytics/firebase_analytics.dart';



class LocalAuthScreen extends StatefulWidget {
  static String routeName = "/localAuthScreen";

  const LocalAuthScreen({Key? key}) : super(key: key);

  @override
  _LocalAuthScreenState createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends StateMVC<LocalAuthScreen> {
  _LocalAuthScreenState() : super(LocalAuthController()) {
    con = LocalAuthController();
  }

  late LocalAuthController con;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(title: "add_biometric_title".tr),
        body: LoadingScreen(
          loading: con.loading,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: ThemeClass.whiteColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: con.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      localAuthDes(),
                      SizedBox(height: 100.h),
                       Align(
                            alignment:
                            AlignmentDirectional.centerStart,
                            child: AppTextRegular(
                              title: "phone_number".tr,
                              color: ThemeClass.secondaryColor,
                            ),
                      ),
                      SizedBox(height: 10.h),
                      phoneTxtField(),
                       Align(
                            alignment:
                            AlignmentDirectional.centerStart,
                            child: AppTextRegular(
                              title: "password".tr,
                              color: ThemeClass.secondaryColor,
                            ),
                      ),
                      SizedBox(height: 10.h),
                      passwordTxtField(),
                      SizedBox(height: 100.h),
                      confirmBtn(),
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


  Widget localAuthDes() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: AppTextRegular(title: "add_biometric_des".tr,textAlign: TextAlign.center,fontSize: 20.sp,));
  }

  Widget phoneTxtField() {
    return  CustomTextFieldWidget(
            controller: con.phoneController,
            hint: "phone_number".tr,
            textInputType: TextInputType.number,
            validator: (value) => Validator.validatePhone(context,value!),
            formatter: [LengthLimitingTextInputFormatter(11),
            ]);
  }

  Widget passwordTxtField() {
    return CustomTextFieldWidget(
          obscure: con.showPassword,
          controller: con.passwordController,
          hint: "password".tr,
          validator: (value) =>
              Validator.validateEmpty(value!, con.passwordController.text),

            suffixIcon: GestureDetector(
              onTap: () {
                con.showPassword = !con.showPassword;
                setState(() {});
              },
              child: Icon(
                con.showPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                color: ThemeClass.secondaryColor,
              ),
            )


        );
  }

  Widget confirmBtn() {
    return CustomButton(
        width: 230,
        title: "confirm".tr,
        onTap: () {
          if (con.formKey.currentState!.validate()) {
            final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
            analytics.logEvent(
                name: 'submit_biometric_login_screen',
                parameters: <String,dynamic>{
                  "title" :"submit_biometric_login_screen"
                }
            );
             con.localAuthApi(context);
          }
        },
    );
  }
}
