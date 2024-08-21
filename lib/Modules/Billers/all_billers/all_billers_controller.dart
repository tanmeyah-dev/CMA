// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/previous_loan_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/request_loan_api.dart';
import '../../../Shared/shared_prefirences.dart';


class AllBillersController extends ControllerMVC {
  // singleton
  factory AllBillersController() {
    _this ??= AllBillersController._();
    return _this!;
  }

  static AllBillersController? _this;

  AllBillersController._();

  bool loading = false,
      autoValidate = false;

  PreviousLoanResponse?  previousLoanResponse;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


}