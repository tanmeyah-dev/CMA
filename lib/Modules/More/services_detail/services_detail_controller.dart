// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/services_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Network/request_loan_api.dart';


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

  @override
  void initState() {
    getServiceDetail();
    super.initState();
  }

  @override
  void dispose() {
    isExpanded = false;
    super.dispose();
  }

  Future getServiceDetail() async {
    loading = true;
    setState(() {
    });
    serviceDetailModel = await RequestLoanApi.getServiceDetail(id: serviceId.toString());
    loading = false;
    setState(() {
    });
  }


}
