// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:async';

import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Models/reset_password_model.dart';
import '../../../Models/verify_otp_model.dart';
import '../../../Network/user_api.dart';
import '../Login/local_auth/user_secure_storage.dart';
import '../Login/login_screen.dart';

enum ForgetPasswordStep {
  identity,
  otp,
  newPassword,
  success,
}

class ForgetPasswordController extends ControllerMVC {
  factory ForgetPasswordController() {
    _this ??= ForgetPasswordController._();
    return _this!;
  }

  static ForgetPasswordController? _this;

  ForgetPasswordController._();

  static const int nationalIdLength = 14;
  static const int minPhoneLength = 10;
  static const int otpLength = 5;
  static const int resendSeconds = 30;

  Timer? timer;
  int start = resendSeconds;

  bool loading = false;
  bool activeResend = false;
  bool showPassword = true;
  bool showConfirmPassword = true;

  ForgetPasswordStep currentStep = ForgetPasswordStep.identity;

  String? phoneNumber;

  late TextEditingController nationalIdController;
  late TextEditingController phoneController;
  late TextEditingController codeController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> formKey2 = GlobalKey();
  final GlobalKey<FormState> formKey3 = GlobalKey();

  bool get isSuccess => currentStep == ForgetPasswordStep.success;

  bool get canSubmitIdentity =>
      nationalIdController.text.length == nationalIdLength &&
      phoneController.text.length >= minPhoneLength;

  bool get canSubmitOtp => codeController.text.length == otpLength;

  /// Last 2 digits masked for OTP copy, safe for short numbers.
  String get maskedPhoneSuffix {
    final phone = phoneNumber ?? phoneController.text.trim();
    if (phone.length < 2) return '**';
    return '${phone.substring(phone.length - 2)}**';
  }

  @override
  void initState() {
    nationalIdController = TextEditingController();
    phoneController = TextEditingController();
    codeController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    nationalIdController.dispose();
    phoneController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    _resetState();
    super.dispose();
  }

  void resetForm() {
    timer?.cancel();
    nationalIdController.clear();
    phoneController.clear();
    codeController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    phoneNumber = null;
    loading = false;
    _resetState();
  }

  void _resetState() {
    currentStep = ForgetPasswordStep.identity;
    activeResend = false;
    start = resendSeconds;
    showPassword = true;
    showConfirmPassword = true;
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    setState(() {});
  }

  void toggleShowConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    setState(() {});
  }

  String _normalizePhone(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.startsWith('0') ? trimmed : '0$trimmed';
  }

  void _syncPhoneNumber() {
    phoneNumber = _normalizePhone(phoneController.text);
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  void _goTo(ForgetPasswordStep step) {
    if (step == ForgetPasswordStep.otp) {
      activeResend = false;
      start = resendSeconds;
      startTimer();
    } else {
      timer?.cancel();
    }
    currentStep = step;
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (start == 0) {
        setState(() {
          t.cancel();
          activeResend = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Future<void> firstStep(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _syncPhoneNumber();
    loading = true;
    setState(() {});

    try {
      final ValidateUserResponse? result = await UserApi.forgetPassword(
        context,
        mobileNumber: phoneNumber!,
        nationalId: nationalIdController.text.trim(),
      );
      if (!context.mounted) return;

      if (result?.isReviewerUser == true) {
        _goTo(ForgetPasswordStep.newPassword);
      } else if (result?.isReviewerUser == false) {
        _goTo(ForgetPasswordStep.otp);
      }
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> secondStep(BuildContext context) async {
    _syncPhoneNumber();
    loading = true;
    setState(() {});

    try {
      final VerifyOtpModel? result = await UserApi.otpForgetPassword(
        context,
        phone: phoneNumber!,
        code: codeController.text.trim(),
      );
      if (!context.mounted) return;

      if (result?.isSuccess == true) {
        _goTo(ForgetPasswordStep.newPassword);
      }
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> thirdStep(BuildContext context) async {
    if (!formKey3.currentState!.validate()) return;

    _syncPhoneNumber();
    loading = true;
    setState(() {});

    try {
      final resetPasswordModel = ResetPasswordModel(
        mobileNumber: phoneNumber!,
        password: newPasswordController.text,
        confirmPassword: confirmNewPasswordController.text,
      );

      final bool result = await UserApi.resetPassword(
        context,
        resetPasswordModel: resetPasswordModel,
      );
      if (!context.mounted) return;

      if (!result) return;

      _logAnalytics('success_reset_password_screen');
      await UserSecureStorage.deleteData();
      _goTo(ForgetPasswordStep.success);
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (Route<dynamic> route) => false,
        arguments: phoneNumber,
      );
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> onResendCode(BuildContext context) async {
    if (!activeResend) return;

    _syncPhoneNumber();
    loading = true;
    setState(() {});

    try {
      await UserApi.forgetPassword(
        context,
        mobileNumber: phoneNumber!,
        nationalId: nationalIdController.text.trim(),
      );
      if (!context.mounted) return;

      activeResend = false;
      start = resendSeconds;
      startTimer();
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }
}
