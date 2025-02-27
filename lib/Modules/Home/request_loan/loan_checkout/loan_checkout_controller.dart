// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:ffi';
import 'dart:io';

import 'package:Tanmeyah/Models/loan_checkout_model.dart';
import 'package:Tanmeyah/Models/loan_checkout_response.dart';
import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:Tanmeyah/Models/submit_loan_response.dart';
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../../../../Models/government_model.dart';
import '../../../../Models/user_model.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Widgets/alert_for_location.dart';
import '../../../../Widgets/animated_alert.dart';
import '../../../../Widgets/location_alert.dart';
import '../loan_request_success/loan_request_success_screen.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permsion;
import 'package:firebase_analytics/firebase_analytics.dart';


import 'package:url_launcher/url_launcher.dart';

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
  }

}


