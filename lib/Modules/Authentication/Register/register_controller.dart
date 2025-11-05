// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'package:Tanmeyah/Models/government_model.dart';
import 'package:Tanmeyah/Modules/Authentication/OTP/otp_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Register/registeration_error.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/registeration_form.dart';
import '../../../Models/registeration_response.dart';
import '../../../Models/verify_otp_model.dart';
import '../../../Network/user_api.dart';
import '../../../Theme/themeclass.dart';
import '../Login/login_screen.dart';import 'package:firebase_analytics/firebase_analytics.dart';


class RegisterController extends ControllerMVC {
  factory RegisterController() {
    _this ??= RegisterController._();
    return _this!;
  }

  static RegisterController? _this;

  RegisterController._();

  bool loading = false,
      autoValidate = false,
      showPassword = true,
      showConfirmPassword = true,
      editPhone = false,
      accept = false;
      String? dateOfBirth,phoneNumber,newMobile;
      
  final GlobalKey<FormState> formKey = GlobalKey();

  String? phone;
  String? selectedValue;
  List<GovernmentModel> governmentsIds = [
    GovernmentModel(id: "1", title: 'القاهرة'),
    GovernmentModel(id: "2", title: 'الفيوم'),
    GovernmentModel(id: "61", title: 'كفر الشيخ'),
    GovernmentModel(id: "62", title: 'الاسكندرية'),
    GovernmentModel(id: "63", title: 'بني سويف'),
    GovernmentModel(id: "64", title: 'الغربية'),
    GovernmentModel(id: "65", title: 'الدقهلية'),
    GovernmentModel(id: "66", title: 'الشرقية'),
    GovernmentModel(id: "67", title: 'البحيرة'),
    GovernmentModel(id: "68", title: 'الوادي الجديد'),
    GovernmentModel(id: "69", title: 'البحر الاحمر'),
    GovernmentModel(id: "70", title: 'سوهاج'),
    GovernmentModel(id: "71", title: 'اسوان'),
    GovernmentModel(id: "72", title: 'اسيوط'),
    GovernmentModel(id: "73", title: 'قنا'),
    GovernmentModel(id: "74", title: 'المنيا'),
    GovernmentModel(id: "75", title: 'الجيزه'),
    GovernmentModel(id: "76", title: 'مرسي مطروح'),
    GovernmentModel(id: "79", title: 'دمياط'),
    GovernmentModel(id: "81", title: 'القليوبيه'),
    GovernmentModel(id: "101", title: 'المنوفيه'),
    GovernmentModel(id: "121", title: 'السويس'),
    GovernmentModel(id: "141", title: 'بورسعيد'),
    GovernmentModel(id: "161", title: 'الاسماعليه'),
    GovernmentModel(id: "162", title: 'الاقصر'),
  ];

  late TextEditingController fullNameController,
      nationalIdController,
      dateController,
      numberController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void initState() {
    fullNameController = TextEditingController();
    nationalIdController = TextEditingController();
    dateController = TextEditingController();
    numberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    selectedValue = null;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nationalIdController.dispose();
    dateController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  String? calc({required String nationalId}){
      if(nationalId.substring(0,1) == "2"){
        dateOfBirth =  "19${nationalIdController.text.substring(1,3)}-${nationalIdController.text.substring(3,5)}-${nationalIdController.text.substring(5,7)}";
        setState(() { });
      } else {
        dateOfBirth =  "20${nationalIdController.text.substring(1,3)}-${nationalIdController.text.substring(3,5)}-${nationalIdController.text.substring(5,7)}";
        setState(() { });

      }
    return dateOfBirth;
  }

  Future register(BuildContext context) async {

    if(!numberController.text.startsWith("0")) {
      phoneNumber = "0${numberController.text}";
      setState(() { });
    } else {
      phoneNumber = numberController.text;
      setState(() { });
    }


    if(phone != null && !phone!.startsWith("0")) {
      newMobile = "0$phone";
      setState(() { });
    } else {
      newMobile = phone;
      setState(() { });
    }

    RegistrationForm registrationForm = RegistrationForm(
      fullName: fullNameController.text,
      nationalId: nationalIdController.text,
      dateOfBirth: "19${nationalIdController.text.substring(1,3)}${nationalIdController.text.substring(3,5)}${nationalIdController.text.substring(5,7)}",
      phoneNumber: editPhone ? newMobile! : phoneNumber!,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      governmentId: selectedValue??"",
    );
    loading = true;

    setState(() {});
    RegistrationResponse? result =
        await UserApi.registration(context,registrationForm: registrationForm);
    loading = false;
    setState(() {});
    print(">>>>>>  ${result?.isAlreadyMobileNumberExist}");
    print(">>>>>>  ${result?.isSuccess}");


    if (result?.isSuccess == true && result?.user?.isActive == true) {
      // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
      // _analytics.logEvent(
      //     name: 'success_registration_screen',
      //     parameters: <String,dynamic>{
      //       "title" : "success_registration_screen"
      //     }
      // );
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/loginScreen', (Route<dynamic> route) => false,arguments: "");
    } else if (result?.user?.isActive == false && result?.isAlreadyMobileNumberExist == false) {
      Navigator.pushNamed(context, OtpScreen.routeName,arguments: [phoneNumber,
            (code) => onConfirm(code, context)
      ]);
    } else if (result?.isAlreadyMobileNumberExist == true ){
      print(">>>>>>>>>>>>>>>>>>phoneNumber From REgister Screen : $newMobile");

      // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
      // _analytics.logEvent(
      //     name: 'error_registration_screen',
      //     parameters: <String,dynamic>{
      //       "title" : "error_registration_screen"
      //     }
      // );
      print(">>>>>>>>>>>>>>>>>>phoneNumber From REgister Screen : $newMobile");
      Navigator.pushNamed(context, RegistrationError.routeName,arguments: newMobile);
    }
  }



  Future onConfirm(String code, BuildContext context) async {
    setState(() {
      loading = true;
    }); //
    VerifyOtpModel? result = await UserApi.otp(context,
      phone: phoneNumber??"",
      code: code,
    );
    setState(() {
      loading = false;
    });
    if (result?.isSuccess == true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/loginScreen', (Route<dynamic> route) => false,arguments: numberController.text);
    }
  }
}
