// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/previous_loan_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/request_loan_api.dart';
import '../../../Shared/shared_prefirences.dart';


class PreviousLoanController extends ControllerMVC {
  // singleton
  factory PreviousLoanController() {
    _this ??= PreviousLoanController._();
    return _this!;
  }

  static PreviousLoanController? _this;

  PreviousLoanController._();

  bool loading = false,
      autoValidate = false;

  PreviousLoanResponse?  previousLoanResponse;


  @override
  void initState() {
    getPaidLoans();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getPaidLoans() async {
    loading = true;
    setState(() {});
    previousLoanResponse = await RequestLoanApi.getPreviousLoan(nationalId: SharedPref.getUserObg()!.nationalId);
    loading = false;
    setState(() {
    });
  }

}