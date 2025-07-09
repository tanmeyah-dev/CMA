// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/loan_detail_response.dart';
import '../../../Shared/shared_prefirences.dart';

class MainRequestLoanController extends ControllerMVC {
  // singleton
  factory MainRequestLoanController() {
    _this ??= MainRequestLoanController._();
    return _this!;
  }

  static MainRequestLoanController? _this;

  MainRequestLoanController._();

  bool loading = false,
      autoValidate = false,
      isLogin = true;

  bool? canRequestLoan;

  LoanResponse? activeLoanModel;

  @override
  void initState() {
    if(SharedPref.getUserObg()?.nationalId != null ) {
      getLoan();
      canRequestLoan = SharedPref.getCanRequestLoan();
    } else {
      isLogin = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    isLogin = true;
    super.dispose();
  }

  Future getLoan() async {
    print(">>>>>>>><<<<<<< GAMAL IS HERE" + SharedPref.getCanRequestLoan().toString());
    if(SharedPref.getCanRequestLoan() == true){
      print("GAMAL IS HERE AND YES ");
      canRequestLoan = true;
    }
    loading = true;
    setState(() {});
    activeLoanModel = await RequestLoanApi.getLoanDetails(nationalId: SharedPref.getUserObg()!.nationalId);
    print(activeLoanModel?.havePreviousLoan.toString());
    print(activeLoanModel?.activeLoan?.paidAmount.toString());
    loading = false;
    setState(() {});
  }
}
