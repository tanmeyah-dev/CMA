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
    con = ValidateUserController();
  }

  late ValidateUserController con;

  @override
  void initState() {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_phone_number_screen',
        parameters: <String,dynamic>{
          "title" : "open_phone_number_screen"
        }
    );
    super.initState();
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
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ThemeClass.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Form(
                key: con.formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: 60.h),
                    image(),
                    SizedBox(height: 10.h),
                    title(),
                    SizedBox(height: 79.h),
                    mobileTxtField(),
                    SizedBox(height: 160.h,),
                    continueBtn()
                  ],),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return AppTextMedium(
          title: "enter_number".tr,
        );
  }

  Widget image() {
    return Image.asset(
        AppAssets.IMG_VALIDATE_USER,
        height: 300.h,
        width: 300.w,
        fit: BoxFit.fill,
    );
  }

  Widget mobileTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWidget(
              onchange: (value){
                if(value.length == 11 || value.length == 10){
                  con.activeBtn = true;
                  setState(() { });
                } else {
                  con.activeBtn = false;
                  setState(() { });
                }
              },
              width: 173.w,
              controller: con.phoneController,
              hint: "1xxxxxxxxxx",
              textInputType: TextInputType.phone,
              validator: (value) {
                 return Validator.validatePhone(context,value);
              },
              formatter: [
                LengthLimitingTextInputFormatter(11),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            const CountryCodeWidget(),
          ],
      ),
    );
  }

  Widget continueBtn() {
    return  Column(
        children: [con.activeBtn
                ? CustomButton(
                    width: 200,
                    title: "continue".tr,
                    onTap: () async {
                      final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                      analytics.logEvent(
                          name: 'submit_phone_number_screen',
                          parameters: <String,dynamic>{
                            "title" : "submit_phone_number_screen"
                          }
                      );
                      if (con.formKey.currentState!.validate()) {
                         con.validateUser(context);
                      }
                    },
                  ) : CustomButton(
              width: 200,
              title: "continue".tr,
              onTap: () async {},
              color: ThemeClass.textFieldBackgroundColor,
              borderColor: ThemeClass.textFieldBackgroundColor,
              textColor: ThemeClass.hintColor,
              backgroundColor: ThemeClass.buttonNotActiveColor,
          ),
          SizedBox(height: 20.h,)
        ],
    );
  }
}
