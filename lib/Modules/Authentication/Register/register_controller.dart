// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'package:Tanmeyah/Models/government_model.dart';
import 'package:Tanmeyah/Modules/Authentication/OTP/otp_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Register/registeration_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/registeration_form.dart';
import '../../../Models/registeration_response.dart';
import '../../../Models/verify_otp_model.dart';
import '../../../Network/user_api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class RegisterController extends ControllerMVC {
  factory RegisterController() {
    _this ??= RegisterController._();
    return _this!;
  }

  static RegisterController? _this;

  RegisterController._();

  bool loading = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool editPhone = false;
  bool accept = false;

  String? dateOfBirth;
  String? phoneNumber;
  String? newMobile;

  final GlobalKey<FormState> formKey = GlobalKey();

  String? phone;
  String? selectedValue;

  List<GovernmentModel> governmentsIds = [
    GovernmentModel(id: '1', title: 'القاهرة'),
    GovernmentModel(id: '23', title: 'الفيوم'),
    GovernmentModel(id: '15', title: 'كفر الشيخ'),
    GovernmentModel(id: '2', title: 'الاسكندرية'),
    GovernmentModel(id: '22', title: 'بني سويف'),
    GovernmentModel(id: '16', title: 'الغربية'),
    GovernmentModel(id: '12', title: 'الدقهلية'),
    GovernmentModel(id: '13', title: 'الشرقية'),
    GovernmentModel(id: '18', title: 'البحيرة'),
    GovernmentModel(id: '32', title: 'الوادي الجديد'),
    GovernmentModel(id: '31', title: 'البحر الاحمر'),
    GovernmentModel(id: '26', title: 'سوهاج'),
    GovernmentModel(id: '28', title: 'اسوان'),
    GovernmentModel(id: '25', title: 'اسيوط'),
    GovernmentModel(id: '27', title: 'قنا'),
    GovernmentModel(id: '24', title: 'المنيا'),
    GovernmentModel(id: '21', title: 'الجيزه'),
    GovernmentModel(id: '33', title: 'مرسي مطروح'),
    GovernmentModel(id: '11', title: 'دمياط'),
    GovernmentModel(id: '14', title: 'القليوبيه'),
    GovernmentModel(id: '17', title: 'المنوفيه'),
    GovernmentModel(id: '4', title: 'السويس'),
    GovernmentModel(id: '3', title: 'بورسعيد'),
    GovernmentModel(id: '19', title: 'الاسماعليه'),
    GovernmentModel(id: '29', title: 'الاقصر'),
  ];

  late TextEditingController fullNameController,
      nationalIdController,
      numberController,
      emailController,
      passwordController,
      confirmPasswordController;

  bool get canSubmit => selectedValue != null && accept;

  @override
  void initState() {
    fullNameController = TextEditingController();
    nationalIdController = TextEditingController();
    numberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }


  void setupSession({String? phoneNumberArg}) {
    final phoneArg = phoneNumberArg?.toString().trim() ?? '';

    accept = false;
    selectedValue = null;
    showPassword = true;
    showConfirmPassword = true;
    loading = false;
    dateOfBirth = null;
    phoneNumber = null;
    newMobile = null;
    phone = null;
    editPhone = false;

    fullNameController.clear();
    nationalIdController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    numberController.clear();

    if (phoneArg.isNotEmpty) {
      phone = _normalizePhone(phoneArg);
      editPhone = true;
      numberController.text = displayPhone;
    }

    setState(() {});
  }

  String get displayPhone {
    final value = phone ?? numberController.text;
    if (value.isEmpty) return '';
    return value.startsWith('0') ? value.substring(1) : value;
  }

  String _normalizePhone(String input) {
    final trimmed = input.trim();
    return trimmed.startsWith('0') ? trimmed : '0$trimmed';
  }

  String? calc({required String nationalId}) {
    if (nationalId.length < 7) {
      dateOfBirth = null;
      setState(() {});
      return dateOfBirth;
    }
    final century = nationalId.startsWith('2') ? '19' : '20';
    dateOfBirth =
        '$century${nationalId.substring(1, 3)}-${nationalId.substring(3, 5)}-${nationalId.substring(5, 7)}';
    setState(() {});
    return dateOfBirth;
  }

  void _logAnalytics(String name) {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: <String, Object>{'title': name},
    );
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate() || !canSubmit) return;

    phoneNumber =
        editPhone ? _normalizePhone(phone!) : _normalizePhone(numberController.text);
    newMobile = phoneNumber;

    final nationalId = nationalIdController.text.trim();
    calc(nationalId: nationalId);

    final registrationForm = RegistrationForm(
      fullName: fullNameController.text.trim(),
      nationalId: nationalId,
      dateOfBirth: dateOfBirth!,
      phoneNumber: phoneNumber!,
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      governmentId: selectedValue ?? '',
    );

    loading = true;
    setState(() {});

    try {
      final RegistrationResponse? result =
          await UserApi.registration(context, registrationForm: registrationForm);
      if (!context.mounted) return;

      if (result?.isSuccess == true && result?.active == true) {
        _logAnalytics('success_registration_screen');
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/loginScreen',
          (Route<dynamic> route) => false,
          arguments: phoneNumber,
        );
      } else if (result?.isSuccess == true && result?.active == false) {
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: [
            phoneNumber!,
            (String code) => onConfirm(code, context),
          ],
        );
      } else if (result?.isAlreadyMobileNumberExist == true) {
        _logAnalytics('error_registration_screen');
        Navigator.pushNamed(
          context,
          RegistrationError.routeName,
          arguments: newMobile,
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
        phone: phoneNumber ?? '',
        code: code,
      );
      if (!context.mounted) return;

      if (result?.isSuccess == true) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/loginScreen',
          (Route<dynamic> route) => false,
          arguments: phoneNumber ?? numberController.text,
        );
      }
    } finally {
      loading = false;
      if (context.mounted) setState(() {});
    }
  }
}
