// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:mvc_pattern/mvc_pattern.dart';


class TermsController extends ControllerMVC {
  // singleton
  factory TermsController() {
    _this ??= TermsController._();
    return _this!;
  }

  static TermsController? _this;

  TermsController._();

  bool loading = false,
      autoValidate = false;

  // MessageResponse? terms;


  @override
  void initState() {
    // getTerms();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //  getTerms() async {
  //   loading = true;
  //   setState(() {});
  //   terms = await TermsAndConditionsApi.getTermsData();
  //   loading = false;
  //   setState(() {
  //   });
  // }

}