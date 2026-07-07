// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/loan_products_response.dart';
import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../../../../Network/loan_products_api.dart';
import '../../../../Widgets/alert_for_location.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';


import '../../../../Widgets/alert_for_permission.dart';

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
      activeBtn = false,
      accept = false,
      accept2 = false;

  String? currentLatitude, currentLongitude;

  Position? currentPosition;

  LoanProductsResponse? loanProductsResponse;

  int? selectedValue;
  String? selectedTitle;
  // LocationData? locationData;

  late TextEditingController loanAmount;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    loanAmount = TextEditingController();
    getLoanProducts();
    super.initState();
  }

  @override
  void dispose() {
    loanAmount.dispose();
    accept = false;
    accept2 = false;
    super.dispose();
  }

  static Future<Position?> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ToastHelper.showError(message: 'Location services are disabled.');
      return null;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ToastHelper.showError(message: 'Location permissions are denied');
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ToastHelper.showError(
      //     message:
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
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
    if (await Geolocator.isLocationServiceEnabled()) {
      return true;
    } else {
      return false;
    }
  }

  checkLocation(
      {required BuildContext context, bool isInitLocation = false}) async {
    bool result = await checkGps();
    setState(() {});
    if (!result) {
      if (context.mounted) {
        AlertLocation.checkGpsWidget(
          context: context,
          onDismiss: () {},
        );
      }
      return;
    } else {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("}}}}}}<>>>>>>>>>>>>>>$permission");
        AlertForPermission.checkPermission(
            context: context, onDismiss: () {});
        return;
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        submitLoan(context: context, isInit: isInitLocation);
      }
    }
  }
  submitLoan({required BuildContext context, bool isInit = false}) async {
    loading = true;
    setState(() {});
    Position? position = await getCurrentLocation(context);
    if (position == null) return;
    setState(() {
      loading = false;
      currentPosition = position;
    });
    if (isInit) applyForLoan(context);
  }

  Future getLoanProducts() async {
    loading = true;
    setState(() {});
    loanProductsResponse = await LoanProductsApi.getLoanProducts();
    loading = false;
    setState(() {});
  }

  applyForLoan(BuildContext context) async {
    final now = DateTime.now();
    String formatter = DateFormat('yyyy-MM-dd').format(now);

    SharedPref.setUserLongitude(long: currentPosition!.longitude.toString());
    SharedPref.setUserLatitude(lat: currentPosition!.latitude.toString());

    RequestLoanModel requestLoanModel = RequestLoanModel(
        userId: SharedPref.getUserObg()!.id.toString(),
        amount: loanAmount.text,
        requestDate: formatter,
        latitude: currentPosition?.latitude.toString() ?? "",
        longitude: currentPosition?.longitude.toString() ?? "");
    setState(() {
      loading = true;
    });
    // SubmitLoanResponse? result = await RequestLoanApi.requestLoan(
    //     context, requestLoanModel: requestLoanModel);
    setState(() {
      loading = false;
    });
    // Navigator.pushNamed(context, CheckoutSc.routeName);
  }
}
