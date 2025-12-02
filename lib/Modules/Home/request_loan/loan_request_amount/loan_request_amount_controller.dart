// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:ffi';
import 'dart:io';

import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:Tanmeyah/Models/submit_loan_response.dart';
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Widgets/alert_for_location.dart';
import '../../../../Widgets/animated_alert.dart';
import '../../../../Widgets/location_alert.dart';
import '../loan_request_out_of_cairo/loan_request_out_of_cairo_screen.dart';
import '../loan_request_success/loan_request_success_screen.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permsion;
import '../../../../Utilities/firebase_helper.dart';


import 'package:url_launcher/url_launcher.dart';

class LoanRequestAmountController extends ControllerMVC {
  // singleton
  factory LoanRequestAmountController() {
    _this ??= LoanRequestAmountController._();
    return _this!;
  }

  static LoanRequestAmountController? _this;

  LoanRequestAmountController._();

  bool loading = false,
      autoValidate = false,
      activeBtn = false;

  String? currentLatitude, currentLongitude;

  LocationData? currentPosition;

  // LocationData? locationData;


  late TextEditingController loanAmount;
  final GlobalKey<FormState> formKey = GlobalKey();


  @override
  void initState() {
    loanAmount = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loanAmount.dispose();
    super.dispose();
  }


  static Future<LocationData?> getCurrentLocation(BuildContext context) async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // ToastHelper.showError(message: 'Location services are disabled.');
        return null;
      }
    }
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.denied) {
        // ToastHelper.showError(message: 'Location permissions are denied');
        return null;
      }
    }
    if (permission == PermissionStatus.deniedForever) {
      // ToastHelper.showError(
      //     message:
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }

    return await location.getLocation();
  }


  // bool checkApproveLocation(BuildContext context) async {
  //   bool result = await checkGps();
  //   if(result) return true;
  //   // await Future.delayed(const Duration(milliseconds: 100));
  //   if (!result) {
  //     if(context.mounted) AlertLocation.checkGpsWidget(context: context, onDismiss: () {  },);
  //     return false;
  //   }
  //   return false;
  // }

  static Future<bool> checkGps() async {
    Location location = Location();
    if (await location.serviceEnabled()) {
      return true;
    } else {
      return false;
    }
  }


  checkLocation({required BuildContext context, bool isInitLocation = false}) async {
    bool result = await checkGps();
    setState(() {});
    if (!result) {
      if (context.mounted) {
        AlertLocation.checkGpsWidget(
        context: context, onDismiss: () {},);
      }
      return;
    } else {
      var permission = await permsion.Permission.location.request();
      print("}}}}}}<>>>>>>>>>>>>>>$permission");
      if (permission == permsion.PermissionStatus.denied ||
          permission == permsion.PermissionStatus.permanentlyDenied) {
        await permsion.openAppSettings();
        return;
      } else if (permission == permsion.PermissionStatus.granted) {
          submitLoan(context:context,isInit: isInitLocation);
      }
    }
  }

  submitLoan({required BuildContext context, bool isInit = false}) async {
    loading = true;
    setState(() { });
    LocationData? position = await getCurrentLocation(context);
    if (position == null) return;
    setState(() {
      loading = false;
      currentPosition = position;
    });
    if(isInit) applyForLoan(context);
 }


 applyForLoan(BuildContext context) async{
   final now = DateTime.now();
   String formatter = DateFormat('yyyy-MM-dd').format(now);

   SharedPref.setUserLongitude(long: currentPosition!.longitude.toString());
   SharedPref.setUserLatitude(lat: currentPosition!.latitude.toString());

   RequestLoanModel requestLoanModel = RequestLoanModel(
       userId: SharedPref.getUserObg()!.id.toString(),
       amount: loanAmount.text,
       requestDate: formatter,
       latitude: currentPosition?.latitude.toString()??"",
       longitude: currentPosition?.longitude.toString() ?? "");
   setState(() {
     loading = true;
   });
   SubmitLoanResponse? result = await RequestLoanApi.requestLoan(
       context, requestLoanModel: requestLoanModel);
   setState(() {
     loading = false;
   });
  if (result?.isCapital == true) {
    FirebaseHelper.logEvent(
        name: 'loan_submitted_from_cairo_successfully',
        parameters: <String, Object>{
          "title": "loan_submitted_from_cairo_successfully"
        }
    );
    Navigator.pushNamed(context, LoanSuccessRequestScreen.routeName);
  } else if (result?.isCapital == false) {
    FirebaseHelper.logEvent(
        name: 'loan_submitted_out_of_cairo_successfully',
        parameters: <String, Object>{
          "title": "loan_submitted_out_of_cairo_successfully"
        }
    );
     Navigator.pushNamed(context, LoanRequestOutOfCairoScreen.routeName,
         arguments: result?.branches);
   }

 }

}


