// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/paid_installment_response.dart';
import '../../../Network/request_loan_api.dart';
import '../../../Shared/shared_prefirences.dart';


class AlreadyPaidController extends ControllerMVC {
  // singleton
  factory AlreadyPaidController() {
    _this ??= AlreadyPaidController._();
    return _this!;
  }

  static AlreadyPaidController? _this;

  AlreadyPaidController._();

  bool loading = false,
      autoValidate = false;

  PaidInstallmentResponse?  paidInstallmentResponse;


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
    paidInstallmentResponse = await RequestLoanApi.getPaidInstallment(nationalId: SharedPref.getUserObg()!.nationalId);
    loading = false;
    setState(() {
    });
  }

}