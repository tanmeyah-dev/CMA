// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class LoanSuccessRequestController extends ControllerMVC {
  // singleton
  factory LoanSuccessRequestController() {
    _this ??= LoanSuccessRequestController._();
    return _this!;
  }

  static LoanSuccessRequestController? _this;

  LoanSuccessRequestController._();

  bool loading = false, autoValidate = false;

  late TextEditingController loanAmount;
  final GlobalKey<FormState> formKey = GlobalKey();



  @override
  void initState() {
    loanAmount  = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loanAmount.dispose();
    super.dispose();
  }

}
