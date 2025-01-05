// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/mobile_biller_response.dart';
import 'package:Tanmeyah/Network/mobile_billers_api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class CheckoutController extends ControllerMVC {
  // singleton
  factory CheckoutController() {
    _this ??= CheckoutController._();
    return _this!;
  }

  static CheckoutController? _this;

  CheckoutController._();

  bool loading = false,
      autoValidate = false;

  MobileBillersResponse? mobileBillersResponse;
  int? billerId;

  @override
  void initState() {
   // getBillersOptions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getBillersOptions() async {
    loading = true;
    setState(() {});
    mobileBillersResponse = await BillersApi.getBillers(billerID: billerId.toString());
    loading = false;
    setState(() {
    });
  }

}