// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Network/user_api.dart';


class OtpController extends ControllerMVC {
  // singleton
  factory OtpController() {
    _this ??= OtpController._();
    return _this!;
  }

  static OtpController? _this;

  OtpController._();

  late GlobalKey<FormState> formKey;
  late TextEditingController codeController;
  bool loading = false,
      autoValidate = false,
      showConfirmPassword = true,
      activeResend = false,
      showPassword = true,
      activeBtn = false;
  String? phoneNumber;

  Function(String)? onConfirm;


  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    codeController = TextEditingController();
    codeController.clear();
    startTimer();
    activeResend = false;
    start = 30;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    codeController.dispose();
    super.dispose();
  }

  Timer? timer;
  int start = 30;

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
    setState(() {
      loading = true;
    });
    await UserApi.validateUser(context,phone: phoneNumber!);
    activeResend = false;
    start = 30;
    startTimer();
    setState(() {
      loading = false;
    });
  }

  Future onConfirmPin() async {
    setState(() {
      loading = true;
    });
    if (onConfirm != null) {
      await onConfirm!(codeController.text);
    }
    setState(() {
      loading = false;
    });
  }
}
