// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/More/contact_us/contact_us_controller.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Iconsax/Iconsax.dart';
import '../../../Utilities/Validator.dart';
import '../../../Widgets/country_code_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class ContactUsScreen extends StatefulWidget {
  static const String routeName = "/contactUsScreen";

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends StateMVC<ContactUsScreen> {
  _ContactUsScreenState() : super(ContactUsController()) {
    con = ContactUsController();
  }

  late ContactUsController con;

  @override
  void initState() {
    // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    // _analytics.logEvent(
    //     name: 'open_contact_us_screen',
    //     parameters: <String,dynamic>{
    //       "title" :"open_contact_us_screen"
    //     }
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: Scaffold(
        appBar: BaseAppBar.main(
          title: "contact_us".tr,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.h,),
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeClass.secondaryLightColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24.sp),
                    ),
                    padding: EdgeInsets.all(16.sp),
                    child: Form(
                      key: con.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration : BoxDecoration(
                                      color: ThemeClass.secondaryLightColor.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center ,
                                  padding: EdgeInsets.all(6.w),
                                  child: Icon(Iconsax.send_2,color: ThemeClass.primaryColor,size: 30.sp,)),
                              SizedBox(width: 8.w,),
                              AppTextRegular(title: "ارسال رسالة نصية لتنميه",fontSize: 24.sp,),

                            ],
                          ),
                          SizedBox(height: 20.h,),
                          nameTxtField(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextRegular(
                                title: "phone_number".tr,
                                color: ThemeClass.secondaryColor,
                              ),
                              SizedBox(height: 8.h,),
                              mobileTxtField(),
                            ],
                          ),
                          AppTextRegular(
                            title: "أرسل استفسارك",
                            color: ThemeClass.secondaryColor,
                          ),
                          SizedBox(height: 6.h,),
                          TextFormField(
                            controller: con.messageController,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            maxLength: 200,
                            decoration: InputDecoration(
                              helperText: ' ', // keep space reserved for error/helper text
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.sp),
                                borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: ThemeClass.secondaryMediumColor),
                                borderRadius: BorderRadius.circular(14.sp),
                              ),
                              errorStyle: TextStyle(height: 1.5, fontSize: 12, color: ThemeClass.primaryColor), // fixed height & font
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: ThemeClass.primaryColor),
                                borderRadius: BorderRadius.circular(14.sp),
                              ),
                              hoverColor: ThemeClass.primaryColor,
                              border: OutlineInputBorder(),
                              hintText: 'أرسل استفسارك',
                              hintStyle: TextStyle(
                                color: ThemeClass.borderColor,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 13.h),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (value.trim().length < 10) {
                                return 'يجب ألا يقل الاستفسار عن 10 أحرف';
                              }
                              if (value.trim().length > 200) {
                                return 'يجب ألا يتجاوز الاستفسار 200 حرف';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 6.h,),
                          CustomButton(title: "send".tr, onTap: (){
                            // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                            // _analytics.logEvent(
                            //     name: 'submit_contact_us',
                            //     parameters: <String,dynamic>{
                            //       "title" :"submit_contact_us"
                            //     }
                            // );
                            if (con.formKey.currentState!.validate()) {
                              con.contactMessage(context: context);
                            } else {
                              con.autoValidate = true;
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileTxtField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFieldWidget(
          width: 190.w,
          controller: con.phoneController,
          hint: "1xxxxxxxxxx",
          textInputType: TextInputType.phone,
          validator: (value) {
            String phone = value?.trim() ?? '';
            if (phone.isEmpty) {
              return "رقم الهاتف لا يمكن أن يكون فارغًا";
            }
            if (phone.length <= 9) {
              return "رقم الهاتف يجب أن يحتوي على 11 رقمًا";
            }
            RegExp arabicTextOrDigits = RegExp(r'[\u0621-\u064A\u0660-\u0669]');
            if (arabicTextOrDigits.hasMatch(phone)) {
              return "يرجى إدخال الرقم باللغة الإنجليزية فقط";
            }
            RegExp phoneRegExp = RegExp(r'^(0?1)[0125][0-9]{8}$');
            if (!phoneRegExp.hasMatch(phone)) {
              return "رقم الهاتف غير صحيح";
            }
            return null;
            },
          formatter: [
            LengthLimitingTextInputFormatter(11),
          ],
        ),
        Spacer(),
        const CountryCodeWidget(),
      ],
    );
  }


  Widget nameTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextRegular(
          title: "الاسم",
          color: ThemeClass.secondaryColor,
        ),
        SizedBox(height: 10.h,),
        CustomTextFieldWidget(
          isDense: false,
          controller: con.fullName,
          hint: "الاسم بالكامل",
          validator: (value) => Validator.validateFullName(context, value!),
        ),
      ],
    );
  }

}
