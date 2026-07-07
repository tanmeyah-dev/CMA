// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:Tanmeyah/Models/login_form.dart';
import 'package:Tanmeyah/Modules/Authentication/Login/local_auth/local_auth_api.dart';
import 'package:Tanmeyah/Modules/Authentication/Login/local_auth/local_auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../Network/user_api.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Utilities/Validator.dart';
import 'local_auth/user_secure_storage.dart';

class LoginController extends ControllerMVC {
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }

  static LoginController? _this;

  LoginController._();

  bool loading = false;
  bool showPassword = true;
  bool canSubmit = false;

  bool hasFaceId = false;
  bool hasFingerPrint = false;
  bool hasOldFaceVersion = false;
  bool hasFingerPrintForIOS = false;

  String? encryptedPhone;
  String? encryptedPassword;
  String? phoneNumber;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController phoneController;
  late TextEditingController passwordController;

  bool get showFingerprint => hasFingerPrint || hasFingerPrintForIOS;
  bool get showFaceId => hasFaceId || hasOldFaceVersion;
  bool get hasBiometric => showFingerprint || showFaceId;

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

  void setupSession({String? phoneNumberArg}) {
    formKey = GlobalKey<FormState>();
    showPassword = true;
    loading = false;
    canSubmit = false;
    phoneNumber = null;

    phoneController.clear();
    passwordController.clear();

    final phoneArg = phoneNumberArg?.toString().trim() ?? '';
    if (phoneArg.isNotEmpty) {
      phoneController.text = _displayPhone(phoneArg);
    }

    setState(() {});
  }

  Future<void> initBiometrics() async {
    final biometrics = await LocalAuthApi.getBiometric();
    hasFaceId = biometrics.contains(BiometricType.face);
    hasFingerPrint = biometrics.contains(BiometricType.strong);
    hasOldFaceVersion = biometrics.contains(BiometricType.weak);
    hasFingerPrintForIOS = biometrics.contains(BiometricType.fingerprint);
    setState(() {});
  }

  void updateCanSubmit(BuildContext context) {
    final phoneValid =
        Validator.validatePhone(context, phoneController.text) == null;
    final passwordValid = passwordController.text.trim().isNotEmpty;
    final newCanSubmit = phoneValid && passwordValid;
    if (canSubmit != newCanSubmit) {
      canSubmit = newCanSubmit;
      setState(() {});
    }
  }

  String _displayPhone(String input) {
    final trimmed = input.trim();
    return trimmed.startsWith('0') ? trimmed.substring(1) : trimmed;
  }

  String _normalizePhone(String input) {
    final trimmed = input.trim();
    return trimmed.startsWith('0') ? trimmed : '0$trimmed';
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  Future<bool> getBiometricsData() async {
    final cachedPhone = await UserSecureStorage.getPhoneNumber();
    final cachedPassword = await UserSecureStorage.getPassword();
    if (cachedPhone != null && cachedPassword != null) {
      encryptedPhone = cachedPhone;
      encryptedPassword = cachedPassword;
      return true;
    }
    return false;
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate() || !canSubmit) return;

    phoneNumber = _normalizePhone(phoneController.text);
    loading = true;
    setState(() {});

    try {
      final loginForm = LoginForm(
        phoneNumber: phoneNumber!,
        password: passwordController.text,
      );
      final result =
          await UserApi.loginWithInginex(context, loginForm: loginForm);
      if (!context.mounted) return;

      if (result) {
        await SharedPref.saveAlreadyExist();
        await SharedPref.saveWatchIntro();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainScreen',
          (Route<dynamic> route) => false,
        );
      }
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> biometricLogin(BuildContext context) async {
    _logAnalytics('request_biometric_login_screen');

    final hasData = await getBiometricsData();
    if (!context.mounted) return;

    if (!hasData) {
      Navigator.pushNamed(context, LocalAuthScreen.routeName);
      return;
    }

    final isAuthenticated = await LocalAuthApi.authenticate();
    if (!isAuthenticated || !context.mounted) return;

    phoneController.text = encryptedPhone!;
    passwordController.text = encryptedPassword!;
    updateCanSubmit(context);
    _logAnalytics('submit_biometric_login_screen');
    await login(context);
  }
}
