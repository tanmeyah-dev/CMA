// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/due_installment_response.dart';
import '../../../Shared/shared_prefirences.dart';


class PaymentNeededController extends ControllerMVC {
  // singleton
  factory PaymentNeededController() {
    _this ??= PaymentNeededController._();
    return _this!;
  }

  static PaymentNeededController? _this;

  PaymentNeededController._();

  DueInstallmentResponse?  dueInstallmentResponse;

  bool loading = false,
      autoValidate = false;


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
    dueInstallmentResponse = await RequestLoanApi.getDueInstallment(nationalId: SharedPref.getUserObg()!.nationalId);
    loading = false;
    setState(() {
    });
  }

}