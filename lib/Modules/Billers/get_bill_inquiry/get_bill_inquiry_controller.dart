// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/Bill_Inquiry_Response.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Network/mobile_billers_api.dart';



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



  @override
  void initState() {
    BillersApi.excuteDailyJob();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future getBillInquiry() async {
    loading = true;
    setState(() {});
    billInquiryResponse = await BillersApi.getBillInquiry();
    loading = false;
    setState(() {
    });
  }

}