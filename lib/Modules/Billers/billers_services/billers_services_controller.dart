// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/biller_services_response.dart';
import 'package:Tanmeyah/Models/mobile_biller_response.dart';
import 'package:Tanmeyah/Models/user_model.dart';
import 'package:Tanmeyah/Network/mobile_billers_api.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Models/mobile_biller_response.dart';


class BillersServicesController extends ControllerMVC {
  // singleton
  factory BillersServicesController() {
    _this ??= BillersServicesController._();
    return _this!;
  }

  static BillersServicesController? _this;

  BillersServicesController._();

  bool loading = false,
      autoValidate = false;

  BillerServicesResponse? billerServicesResponse;
  Billers? billers;
  @override
  void initState() {
    getBillersServices();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getBillersServices() async {
    loading = true;
    setState(() {});
    billerServicesResponse = await BillersApi.getBillerServices(billerID: billers!.id.toString(), phoneNumber: SharedPref.getUserObg()!.mobileNumber);
    loading = false;
    setState(() {
    });
  }

}