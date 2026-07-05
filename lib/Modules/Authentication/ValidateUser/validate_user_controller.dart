// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:Tanmeyah/Models/verify_otp_model.dart';
import 'package:Tanmeyah/Modules/Authentication/Login/local_auth/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Network/user_api.dart';
import '../Login/login_screen.dart';
import '../OTP/otp_screen.dart';
import '../Register/register_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class ValidateUserController extends ControllerMVC {
  factory ValidateUserController() {
    _this ??= ValidateUserController._();
    return _this!;
  }

  static ValidateUserController? _this;

  ValidateUserController._();

  bool loading = false;
  bool activeBtn = false;

  String? phoneNumber;

  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    activeBtn = false;
    super.dispose();
  }

  void resetForm() {
    phoneController.clear();
    activeBtn = false;
    phoneNumber = null;
    loading = false;
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

  Future<void> validateUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    phoneNumber = _normalizePhone(phoneController.text);
    loading = true;
    setState(() {});

    try {
      await UserSecureStorage.deleteData();
      final ValidateUserResponse? result =
          await UserApi.validateUser(context, phone: phoneNumber!);
      if (!context.mounted) return;

      if (result?.isSuccess != true) {
        _logAnalytics('error_phone_number_screen');
        return;
      }

      if (result?.isReviewerUser == true) {
        Navigator.pushNamed(
          context,
          LoginScreen.routeName,
          arguments: phoneNumber,
        );
      } else {
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: [
            phoneNumber!,
            (String code) => onConfirm(code, context),
          ],
        );
      }
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }

  Future<void> onConfirm(String code, BuildContext context) async {
    loading = true;
    setState(() {});

    try {
      final VerifyOtpModel? result = await UserApi.otp(
        context,
        phone: phoneNumber!,
        code: code,
      );
      if (!context.mounted) return;

      if (result?.isSuccess != true) return;

      _logAnalytics('success_phone_number_screen');

      final route = result?.registeredUser == true
          ? LoginScreen.routeName
          : RegisterScreen.routeName;
      Navigator.pushNamed(context, route, arguments: phoneNumber);
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }
}
