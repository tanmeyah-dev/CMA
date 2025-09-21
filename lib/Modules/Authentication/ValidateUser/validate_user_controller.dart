// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:Tanmeyah/Models/verify_otp_model.dart';
import 'package:Tanmeyah/Modules/Authentication/Login/local_auth/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/user_api.dart';
import '../Login/login_screen.dart';
import '../OTP/otp_screen.dart';
import '../Register/register_screen.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

class ValidateUserController extends ControllerMVC {
  // singleton
  factory ValidateUserController() {
    _this ??= ValidateUserController._();
    return _this!;
  }

  static ValidateUserController? _this;

  ValidateUserController._();

  bool loading = false,
      autoValidate = false,activeBtn = false;

  String? phoneNumber;

  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    activeBtn = false;

    super.dispose();
  }

  Future validateUser(BuildContext context) async {
    await UserSecureStorage.deleteData();
    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() {});
    }
    loading = true;
    setState(() {});
    ValidateUserResponse? result = await UserApi.validateUser(context,phone: phoneNumber!);
    loading = false;
    setState(() {});
    if (result?.isReviewerUser == false) {
      Navigator.pushNamed(context, OtpScreen.routeName, arguments: [
        phoneNumber!,
            (code) => onConfirm(code, context)
      ]);
    } else if(result?.isReviewerUser == true){
        Navigator.pushNamed(context, LoginScreen.routeName , arguments: phoneNumber);
    }
  }

  Future onConfirm(String code, BuildContext context) async {
    setState(() {
      loading = true;
    });
    VerifyOtpModel? result = await UserApi.otp(context,
      phone: phoneNumber!,
      code: code,
    );
    setState(() {
      loading = false;
    });
    if (result?.alreadyExists == true && result?.isSuccess == true) {
      // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      // analytics.logEvent(
      //     name: 'success_phone_number_screen',
      //     parameters: <String,dynamic>{
      //       "title" : "success_phone_number_screen"
      //     }
      // );
      Navigator.pushNamed(
          context, LoginScreen.routeName, arguments: phoneController.text);
    } else if (result?.alreadyExists == false && result?.isSuccess == true) {
      // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      // analytics.logEvent(
      //     name: 'success_phone_number_screen',
      //     parameters: <String,dynamic>{
      //       "title" : "success_phone_number_screen"
      //     }
      // );
      Navigator.pushNamed(
          context, RegisterScreen.routeName, arguments: phoneController.text);
    }
  }
}

