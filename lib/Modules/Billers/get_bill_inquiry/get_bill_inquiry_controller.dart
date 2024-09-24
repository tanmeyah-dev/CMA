// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/Bill_Inquiry_Response.dart';
import 'package:Tanmeyah/Models/biller_services_response.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Models/mobile_biller_response.dart';
import '../../../Network/mobile_billers_api.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fawry_sdk/fawry_utils.dart';
import 'package:fawry_sdk/model/bill_item.dart';
import 'package:fawry_sdk/model/fawry_launch_model.dart';
import 'package:fawry_sdk/model/launch_customer_model.dart';
import 'package:fawry_sdk/model/launch_merchant_model.dart';
import 'package:fawry_sdk/model/payment_methods.dart';
import 'package:fawry_sdk/model/response.dart';



class GetBillInquiryController extends ControllerMVC {
  // singleton
  factory GetBillInquiryController() {
    _this ??= GetBillInquiryController._();
    return _this!;
  }

  static GetBillInquiryController? _this;

  GetBillInquiryController._();

  bool loading = false,
      autoValidate = false;

  BillInquiryResponse? billInquiryResponse;
  Billers? billers;
  Services? services;
  String? paymentType;

  late StreamSubscription? _fawryCallbackResultStream;
  late List<BillItem> chargeItems;
  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool active = false;
  late FawryLaunchModel model;

  num? amount;

  @override
  void initState() {
    phoneController = TextEditingController();
    BillersApi.excuteDailyJob();
    super.initState();
    initSDKCallback();

  }

  @override
  void dispose() {
    phoneController.dispose();
    active = false;
    _fawryCallbackResultStream?.cancel();
    super.dispose();
  }


  // Initialize the Fawry SDK callback
  Future<void> initSDKCallback() async {
    try {
      _fawryCallbackResultStream =
          FawrySDK.instance.callbackResultStream().listen((event) {
            setState(() {
              ResponseStatus response = ResponseStatus.fromJson(jsonDecode(event));
              handleResponse(response);
            });
          });
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  // Handle the response from Fawry SDK
  void handleResponse(ResponseStatus response) {
    switch (response.status) {
      case FawrySDK.RESPONSE_SUCCESS:
        {
          debugPrint('Message: ${response.message}');
          debugPrint('Json Response: ${response.data}');
        }
        break;
      case FawrySDK.RESPONSE_ERROR:
        {
          debugPrint('Error: ${response.message}');
        }
        break;
      case FawrySDK.RESPONSE_PAYMENT_COMPLETED:
        {
          debugPrint(
              'Payment Completed: ${response.message}, ${response.data}');
        }
        break;
    }
  }

  // Get the current platform
  String currentPlatform() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Current platform --> Android';
      case TargetPlatform.iOS:
        return 'Current platform --> iOS';
      default:
        return 'Current platform --> Unknown';
    }
  }

  // Initialize Fawry SDK with required parameters
  Future<void> startPayment() async {
    model.launchMerchantModel.merchantRefNum =
        FawryUtils.randomAlphaNumeric(10);
    await FawryService().startPayment(model);
  }


  Future<BillInquiryResponse?> getBillInquiry() async {
    loading = true;
    setState(() {});
    billInquiryResponse = await BillersApi.getBillInquiry(phoneNumber: SharedPref.getUserObg()!.mobileNumber, billerId: billers!.id, billTypeCode: services!.billTypeCode,paymentType: paymentType);
    loading = false;
    setState(() {
    });
    if(billInquiryResponse!.isSuccess){
      getBillInfo();
    }
    return billInquiryResponse;
  }


  getBillInfo() {
    chargeItems = [];

    BillItem item = BillItem(
      itemId: 'ITEM_ID',
      description: '',
      quantity: 1,
      price: amount?.toDouble(),
    );

    chargeItems.add(item);

    LaunchCustomerModel customerModel = LaunchCustomerModel(
      customerProfileId: '533518',
      customerName: 'Mohamed Gamal',
      customerEmail: 'mgabdelmigid@tanmeyah.com',
      customerMobile: '+201033103360',
    );



    model = FawryLaunchModel(
      allow3DPayment: true,
      chargeItems: chargeItems,
      launchCustomerModel: customerModel,
      launchMerchantModel: FawryService.getMerchantModel(),
      skipLogin: true,
      skipReceipt: false,
      payWithCardToken: false,
      paymentMethods: PaymentMethods.ALL,
    );

  }

}

///////////////////// Fawry///////////////

class Constants {
  static const String merchantCode = "770000019868";
  static const String secureKey = "0525af58-50ec-4e13-b586-bf3724ad781c";
  static const String baseUrl = "https://atfawry.fawrystaging.com/";
}

class FawryService {
  static LaunchMerchantModel getMerchantModel() {
    return LaunchMerchantModel(
      merchantCode: Constants.merchantCode,
      merchantRefNum: FawryUtils.randomAlphaNumeric(10),
      secureKey: Constants.secureKey,
    );
  }

  Future<void> startPayment(FawryLaunchModel model) async {
    try {
      await FawrySDK.instance.startPayment(
        launchModel: model,
        baseURL: Constants.baseUrl,
        lang: FawrySDK.LANGUAGE_ARABIC,
      );
    } catch (e) {
      debugPrint('Error starting payment: $e');
    }
  }

}
