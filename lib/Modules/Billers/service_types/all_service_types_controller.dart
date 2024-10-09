// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/get_all_services_response.dart';
import 'package:Tanmeyah/Models/previous_loan_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/mobile_billers_api.dart';


class AllServicesTypeController extends ControllerMVC {
  // singleton
  factory AllServicesTypeController() {
    _this ??= AllServicesTypeController._();
    return _this!;
  }

  static AllServicesTypeController? _this;

  AllServicesTypeController._();

  bool loading = false,
      autoValidate = false;

  GetAllServicesResponse?  getAllServicesResponse;


  @override
  void initState() {
    getAllServices();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future getAllServices() async {
    loading = true;
    setState(() {});
    getAllServicesResponse = await  BillersApi.getAllServices();
    loading = false;
    setState(() {
    });
  }

}