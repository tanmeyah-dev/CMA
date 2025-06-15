// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:math';

import 'package:Tanmeyah/Models/services_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/service_api.dart';
import '../../../Theme/themeclass.dart';

class MainServicesController extends ControllerMVC {
  // singleton
  factory MainServicesController() {
    _this ??= MainServicesController._();
    return _this!;
  }

  static MainServicesController? _this;

  MainServicesController._();

  bool loading = false, autoValidate = false;

  ServicesResponse? servicesResponse;


  var list = [
    ThemeClass.serviceColor1,
    ThemeClass.serviceColor2,
    ThemeClass.serviceColor3,
    ThemeClass.serviceColor4,
    ThemeClass.serviceColor4,
    ThemeClass.serviceColor5,
    ThemeClass.serviceColor6,
    ThemeClass.serviceColor7,
    ThemeClass.serviceColor8
  ];

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
    servicesResponse = await ServiceApi.getServices();
    loading = false;
    setState(() {});
  }
}
