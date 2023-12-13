// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:Tanmeyah/Modules/Authentication/Login/local_auth/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/login_form.dart';
import '../../../../Network/user_api.dart';
import '../../../../Shared/shared_prefirences.dart';

class LocalAuthController extends ControllerMVC {
  // singleton
  factory LocalAuthController() {
    _this ??= LocalAuthController._();
    return _this!;
  }

  static LocalAuthController? _this;
  late TextEditingController phoneController, passwordController;

  LocalAuthController._();

  bool loading = false,showPassword = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future localAuthApi(BuildContext context) async {
    LoginForm loginForm = LoginForm(
        phoneNumber: phoneController.text, password: passwordController.text);
    setState(() {
      loading = true;
    });
    bool result = await UserApi.loginWithInginex(context , loginForm: loginForm);
    setState(() {
      loading = false;
    });
    if (result) {
      await SharedPref.saveAlreadyExist();
      await SharedPref.saveWatchIntro();
      await UserSecureStorage.setPhone(phone: phoneController.text);
     await  UserSecureStorage.setPassword(password: passwordController.text);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainScreen', (Route<dynamic> route) => false);
    }
  }
}
