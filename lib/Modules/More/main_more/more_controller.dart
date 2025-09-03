// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../Authentication/Login/local_auth/user_secure_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MoreController extends ControllerMVC {
  // singleton
  factory MoreController() {
    _this ??= MoreController._();
    return _this!;
  }

  static MoreController? _this;

  MoreController._();

  bool loading = false, autoValidate = false, guestMood = false;

  @override
  void initState() {
    if (SharedPref.getUserObg() != null) {
      guestMood = false;
      setState(() {});
    } else {
      guestMood = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future logout(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await SharedPref.logOut();
    setState(() {
      loading = false;
    });

    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'submit_logout',
        parameters: <String,dynamic>{
          "title" :"submit_logout"
        }
    );
    Modular.to.pushNamedAndRemoveUntil(
        "/loginScreen", (Route<dynamic> route) => false,
        arguments: "");
  }
}
