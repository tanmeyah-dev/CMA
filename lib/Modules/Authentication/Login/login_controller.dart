// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:Tanmeyah/Models/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/user_api.dart';
import '../../../Shared/shared_prefirences.dart';
import 'local_auth/user_secure_storage.dart';

class LoginController extends ControllerMVC {
  // singleton
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }

  static LoginController? _this;

  LoginController._();

  bool loading = false, autoValidate = false, showPassword = true;
  bool hasFaceId = false;
  bool hasFingerPrint = false;
  bool hasOldFaceVersion = false;
  bool hasFingerPrintForIOS = false;
  String? encryptedPhone, encryptedPassword,phoneNumber;

  late TextEditingController phoneController, passwordController;
  GlobalKey<FormState> newFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    getBiometricsData();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> getBiometricsData() async {
    String? cachedPhone = await UserSecureStorage.getPhoneNumber();
    String? cachedPassword = await UserSecureStorage.getPassword();
    if (cachedPhone != null || cachedPassword != null) {
      encryptedPhone = await UserSecureStorage.getPhoneNumber();
      encryptedPassword = await UserSecureStorage.getPassword();
      return true;
    }
    return false;
  }

  Future logIn(BuildContext context) async {

    // LoginForm loginForm = LoginForm(
    //     phoneNumber: "01033103360", password: passwordController.text);
    // bool response = await UserApi.httpGet(context, loginForm: loginForm);

    if(!phoneController.text.startsWith("0")) {
      phoneNumber = "0${phoneController.text}";
      setState(() { });
    } else {
      phoneNumber = phoneController.text;
      setState(() { });
    }

    LoginForm loginForm = LoginForm(
        phoneNumber: phoneNumber!, password: passwordController.text);
    setState(() {
      loading = true;
    });
    bool result = await UserApi.loginWithInginex(context, loginForm: loginForm);
    setState(() {
      loading = false;
    });
    if (result) {
      await SharedPref.saveAlreadyExist();
      await SharedPref.saveWatchIntro();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainScreen', (Route<dynamic> route) => false);
    }
   }
}
