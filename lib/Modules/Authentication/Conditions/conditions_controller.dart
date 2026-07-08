// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:mvc_pattern/mvc_pattern.dart';

class ConditionsController extends ControllerMVC {
  // singleton
  factory ConditionsController() {
    _this ??= ConditionsController._();
    return _this!;
  }

  static ConditionsController? _this;

  ConditionsController._();

  bool loading = false,
      autoValidate = false;

  // MessageResponse? conditions;


  @override
  void initState() {
    // getConditions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  //
  // getConditions() async {
  //   loading = true;
  //   setState(() {});
  //   conditions = await TermsAndConditionsApi.getConditionsData();
  //   loading = false;
  //   setState(() {
  //   });
  // }
}