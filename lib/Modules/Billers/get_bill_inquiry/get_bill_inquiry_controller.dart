// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:html';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';



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



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


}