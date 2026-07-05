// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../Network/user_api.dart';

class OtpController extends ControllerMVC {
  factory OtpController() {
    _this ??= OtpController._();
    return _this!;
  }

  static OtpController? _this;

  OtpController._();

  static const int otpLength = 5;
  static const int resendSeconds = 30;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();

  bool loading = false;
  bool activeResend = false;
  bool activeBtn = false;

  String? phoneNumber;
  Function(String)? onConfirm;

  Timer? timer;
  int start = resendSeconds;

  String get maskedPhoneSuffix {
    final phone = phoneNumber;
    if (phone == null || phone.length < 2) return '**';
    return '**${phone.substring(phone.length - 2)}';
  }

  @override
  void dispose() {
    timer?.cancel();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void setupSession({
    required String? phone,
    Function(String)? confirmCallback,
  }) {
    phoneNumber = phone;
    onConfirm = confirmCallback;
    timer?.cancel();
    formKey = GlobalKey<FormState>();
    codeController.clear();
    activeBtn = false;
    activeResend = false;
    start = resendSeconds;
    loading = false;
    SmsAutoFill().listenForCode(smsCodeRegexPattern: '\\d{$otpLength}');
    startTimer();
  }

  void updateActiveBtn(String code) {
    final isValid = code.length == otpLength;
    if (activeBtn != isValid) {
      activeBtn = isValid;
      setState(() {});
    }
  }

  void startTimer() {
    timer?.cancel();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
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
    });
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  Future<void> onResendCode(BuildContext context) async {
    if (!activeResend || phoneNumber == null) return;

    loading = true;
    setState(() {});

    try {
      await SmsAutoFill().listenForCode(smsCodeRegexPattern: '\\d{$otpLength}');
      final result =
          await UserApi.validateUser(context, phone: phoneNumber!);
      if (!context.mounted) return;

      if (result?.isSuccess != true) {
        _logAnalytics('error_resend_otp_screen');
        return;
      }

      _logAnalytics('success_resend_otp_screen');
      timer?.cancel();
      activeResend = false;
      start = resendSeconds;
      startTimer();
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> onConfirmPin() async {
    final code = codeController.text.trim();
    if (code.length != otpLength || onConfirm == null) return;

    loading = true;
    setState(() {});

    try {
      await onConfirm!(code);
    } finally {
      loading = false;
      setState(() {});
    }
  }
  }

