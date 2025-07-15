import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'general_toast.dart';

class Validator {
  static validateEmpty(String value, String textField) {
    if (value.trim().isEmpty) {
      return "$textField ${"field_is_required".tr}";
    }
    return null;
  }

  static validateSpecialCharacter(BuildContext context ,String name, String textField) {
    var nameReg = RegExp(r'^[^\d]*$');

    if (Validator.validateEmpty(name, textField) == null) {
      if (!nameReg.hasMatch(name)) {
        ToastHelper.showError(context ,message: "name_error".tr);
        return "";
      }
    } else {
      return Validator.validateEmpty(name, textField);
    }
  }

  static String? validateEmail(String email) {
    var emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.trim().isEmpty) {
      return null;
    }
    if (!emailRegExp.hasMatch(email.trim())) {
      return "email_error".tr;
    }
    return null;
  }

  static validateFullName(BuildContext context ,String name) {
    var nameReg = RegExp(r'^[\u0600-\u06FF\s]+$');
    if (name.trim().isEmpty) {
      return "field_is_required".tr;
    } else if (!nameReg.hasMatch(name)) {
      return "name_error".tr;
    }
    return null;
  }

  static validatePassword(BuildContext context,String password) {
    var passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.trim().isEmpty) {
      return "password_field_is_required".tr;
    } else if(password.length < 8) {
      return "password_length".tr;
    }
    else if (!passwordRegExp.hasMatch(password)) {
      return "password_error".tr;
    }
    return null;
  }

  static matchPasswords(BuildContext context,String password, String passwordConfirmation) {
    if (passwordConfirmation.isEmpty) {
      // NewToastHelper.showError(message: "confirm_password_required".tr);
      // return "";
       return "confirm_password_required".tr;
    } else if (password != passwordConfirmation) {
      // NewToastHelper.showError(message: "password_not_match".tr);
      // return "";
      return "password_not_match".tr;
    }
    return null;
  }
  static RegExp phoneRegExp = RegExp(r'^0|1[0125][0-9]{8}$');

  static validatePhone(BuildContext context, String? phone) {
    var phoneRegExp = RegExp(r'^0|1[0125][0-9]{8}$');
    var textIsArabic = RegExp(r'^[\0621-\064A0-9 ]+$');
    if (phone!.trim().isEmpty) {
        return 'phone_field_is_required'.tr;
    }  else if(!textIsArabic.hasMatch(phone)){
      return "number_wrong".tr;
    } else if (phone.length != 11) {
      return "phone_must_be_11_digits".tr;
    } else if (!phoneRegExp.hasMatch(phone)) {
      return "phone_error".tr;
    }
    return null;
  }

  static validateNationalId(BuildContext context,String? nationalId) {
    var nationlRegExp = RegExp(r'^([2,3])([0-9]{2})(0[1-9]|1[0-2])(?:0[1-9]|[12][0-9]|3[01])([0-9]{2})[0-9]{3}([0-9])[0-9]$');
    var textIsArabic = RegExp(r'^[\0621-\064A0-9 ]+$');
    if (nationalId!.trim().isEmpty) {
        return "national_id_required".tr;
    } else if(nationalId.length != 14){
       return "national_id_length".tr;
    }  else if(!textIsArabic.hasMatch(nationalId)){
      return "number_wrong".tr;
    } else if (!nationlRegExp.hasMatch(nationalId)) {
        return "national_id_valid".tr;
    }
    return null;
  }

  static validateLength(
      String value, String textField, int minLength, int maxLength) {
    if (validateEmpty(value, textField) != null) {
      return validateEmpty(value, textField);
    } else if (value.length < minLength || value.length > maxLength) {
      return "${"message".tr} ${"less_than".tr} $minLength ${"letters".tr} ${"characters".tr}${"more_than".tr} $maxLength ${"letters".tr} ";
    }
    return null;
  }
}
