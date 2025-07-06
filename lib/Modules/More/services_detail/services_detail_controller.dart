// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/services_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Network/request_loan_api.dart';
import '../../../Shared/shared_prefirences.dart';


class ServicesDetailController extends ControllerMVC {
  // singleton
  factory ServicesDetailController() {
    _this ??= ServicesDetailController._();
    return _this!;
  }

  static ServicesDetailController? _this;

  ServicesDetailController._();

  bool loading = false, autoValidate = false,isExpanded = false;

  int? serviceId;
  ServiceDetailModel? serviceDetailModel;

  bool? canRequestLoan = false,isLogin = false;


  @override
  void initState() {
    getServiceDetail();
    super.initState();
  }

  @override
  void dispose() {
    isExpanded = false;
    canRequestLoan = false;
    super.dispose();
  }

  Future getServiceDetail() async {
    print(">>>>>>>><<<<<<< GAMAL IS HERE" + SharedPref.getCanRequestLoan().toString());
    if(SharedPref.getCanRequestLoan() == true){
      print("GAMAL IS HERE AND YES ");
      canRequestLoan = true;
    }
    if(SharedPref.getUserObg() != null) {
      isLogin = true;
    } else {isLogin = false;}
    loading = true;
    setState(() {
    });
    serviceDetailModel = await RequestLoanApi.getServiceDetail(id: serviceId.toString());
    loading = false;
    setState(() {
    });
  }


}
