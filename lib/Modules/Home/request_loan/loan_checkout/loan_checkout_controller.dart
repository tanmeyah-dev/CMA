// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/loan_checkout_model.dart';
import 'package:Tanmeyah/Models/loan_checkout_response.dart';
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/user_model.dart';
import '../loan_request_success/loan_request_success_screen.dart';
// import 'package:location/location.dart';



class LoanCheckoutController extends ControllerMVC {
  // singleton
  factory LoanCheckoutController() {
    _this ??= LoanCheckoutController._();
    return _this!;
  }

  static LoanCheckoutController? _this;

  LoanCheckoutController._();

  bool loading = false,
      autoValidate = false;

  LoanCheckoutModel? loanCheckoutModel;
  LoanCheckoutResponse? loanCheckoutResponse;

  final GlobalKey<FormState> formKey = GlobalKey();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future LoanCheckout({required BuildContext context}) async {
    UserModel? userModel = SharedPref.getUserObg();
    loading = true;
    setState(() {});
    loanCheckoutModel?.userId = userModel?.id;
    loanCheckoutResponse = await RequestLoanApi.loanCheckout(context, loanCheckoutModel: loanCheckoutModel);
    loading = false;
    setState(() {});
    if(loanCheckoutResponse?.isSuccess == true){
      Navigator.pushNamed(context, LoanSuccessRequestScreen.routeName,arguments: loanCheckoutResponse);
    }
  }

}


