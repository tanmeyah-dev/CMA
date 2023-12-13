// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:mvc_pattern/mvc_pattern.dart';


class LoanRequestTermsController extends ControllerMVC {
  // singleton
  factory LoanRequestTermsController() {
    _this ??= LoanRequestTermsController._();
    return _this!;
  }

  static LoanRequestTermsController? _this;

  LoanRequestTermsController._();

  bool loading = false, autoValidate = false,accept = false,accept2 = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    accept = false;
    accept2 = false;
    super.dispose();
  }

}
