// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:async';
import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/reset_password_model.dart';
import '../../../Models/verify_otp_model.dart';
import '../../../Network/user_api.dart';
import '../Login/local_auth/user_secure_storage.dart';import 'package:firebase_analytics/firebase_analytics.dart';


class ForgetPasswordController extends ControllerMVC {
  // singleton
  factory ForgetPasswordController() {
    _this ??= ForgetPasswordController._();
    return _this!;
  }

  static ForgetPasswordController? _this;

  ForgetPasswordController._();

  Timer? timer;
  int start = 30;

  bool loading = false,
      autoValidate = false,
      activeResend = false,
      stepOne = true,
      stepTwo = false,
      stepThree = false,
      stepOneSuccess = false,
      stepTwoSuccess = false,
      stepThreeSuccess  = false,
      activeBtn1 = false,
      activeBtn12 = false,
      activeBtn2 = false,
      activeBtn31 = false,
      activeBtn32 = false,
      showPassword = true,
      showConfirmPassword = true;


  String? phoneNumber;

  late TextEditingController nationalIdController,
      phoneController,
      codeController,
      newPasswordController,
      confirmNewPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> formKey2 = GlobalKey();
  final GlobalKey<FormState> formKey3 = GlobalKey();

  @override
  void initState() {
    phoneController = TextEditingController();
    nationalIdController = TextEditingController();
    codeController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nationalIdController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    timer?.cancel();
    stepOne = true;
    stepTwo = false;
    stepThree = false;
    stepOneSuccess = false;
    stepTwoSuccess = false;
    stepThreeSuccess = false;
    showPassword = true;
    showConfirmPassword = true;
    activeBtn1 = false;
    activeBtn2 = false;
    activeBtn12 = false;
    activeBtn31 = false;
    activeBtn32 = false;
    super.dispose();
  }

  Future firstStep(BuildContext context) async {
    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() {});
    }

    setState(() {
      loading = true;
    });
    ValidateUserResponse? result = await UserApi.forgetPassword(context ,mobileNumber: phoneNumber!,nationalId: nationalIdController.text);
    setState(() {
      loading = false;
    });
    if (result?.isReviewerUser == true) {
      stepOne = false;
      stepTwo = false;
      stepThree = true;
      stepTwoSuccess = true;
      setState(() {});
    } else if (result?.isReviewerUser == false) {
      stepTwo = true;
      stepOne = false;
      stepThree = false;
      stepOneSuccess = true;
      startTimer();
      activeResend = false;
      start = 30;
      setState(() {});
    }

  }


  Future secondStep(BuildContext context) async {
    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() {});
    }
    setState(() {
      loading = true;
    });
    VerifyOtpModel? result = await UserApi.otpForgetPassword(context , phone: phoneNumber!,code: codeController.text);
    setState(() {
      loading = false;
    });
    if (result?.isSuccess == true) {
      stepOne = false;
      stepTwo = false;
      stepThree = true;
      stepTwoSuccess = true;
      setState(() {});
    }
  }



  Future thirdStep(BuildContext context) async {

    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() {});
    }


    ResetPasswordModel resetPasswordModel = ResetPasswordModel(mobileNumber: phoneNumber!, password: newPasswordController.text, confirmPassword: confirmNewPasswordController.text,);
    setState(() {
      loading = true;
    });
    bool result = await UserApi.resetPassword(context ,resetPasswordModel: resetPasswordModel);
    setState(() {
      loading = false;
    });
    if (result) {
      final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      analytics.logEvent(
          name: 'success_reset_password_screen',
          parameters: <String,dynamic>{
            "title" :"success_reset_password_screen"
          }
      );
      UserSecureStorage.deleteData();
      stepOne = false;
      stepTwo = false;
      stepThree = false;
      stepThreeSuccess = true;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/loginScreen', (Route<dynamic> route) => false ,arguments: phoneController.text);
      setState(() {});
    }
  }



  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            activeResend = true;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }


  Future onResendCode(BuildContext context) async {


    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() {});
    }

    setState(() {
      loading = true;
    });
    await UserApi.validateUser(context, phone: phoneNumber!);
    activeResend = false;
    start = 30;
    startTimer();
    setState(() {
      loading = false;
    });
  }
}
