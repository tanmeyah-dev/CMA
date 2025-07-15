
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:Tanmeyah/Models/login_form.dart';
import 'package:Tanmeyah/Models/registeration_form.dart';
import 'package:Tanmeyah/Models/registeration_response.dart';
import 'package:Tanmeyah/Models/reset_password_model.dart';
import 'package:Tanmeyah/Models/terms_response.dart';
import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/session_token_model.dart';
import '../Models/user_model.dart';
import '../Models/verify_otp_model.dart';
import '../Shared/shared_prefirences.dart';
import '../Utilities/general_toast.dart';
import 'api.dart';
import 'network_methods.dart';import 'package:http/http.dart' as http;


class UserApi {
  static Future<SessionToken?> getToken() async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.token,
      body: {
          "UserName": "\$2a\$10\$oCBmRosDIQOW3JCyddMOnexv0BW85s.7Ao3XfvxP..0QngN4FupES",
          "Password": "\$2a\$10\$jzDQNjvTVyD07xvJ5bGNyOIMcZiQCOvoxNgwq89WNtrzwEqny6G6m"
      }
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      SharedPref.saveToken(sessionToken: response["token"]);
      return SessionToken.fromJson(response);
    } else {
      //ToastHelper.showError(context , message: response["message"]);
      return null;
    }
  }

  static Future<ValidateUserResponse?> validateUser(BuildContext context,{required String phone}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.validateUser,
      body: {
        "mobileNumber" : phone
      },
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
       ToastHelper.showSuccess(context , message: response["message"]);
        return ValidateUserResponse.fromJson(response);
    } else {
      ToastHelper.showError(context , message: response["message"]);
      return null;
    }
  }


  static Future<bool> loginWithInginex(BuildContext context,{required LoginForm loginForm}) async {
    Map<String, String>? headers = {};
    headers.addAll({
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "${SharedPref.getGuestToken()}",
    });
    var response = await http.post(Uri.parse("${API.baseServerURL}/api/v1/Identity/Login"), headers: headers,
        body: jsonEncode(loginForm.toJson()));
    if (response == null) return false;
    var result = json.decode(utf8.decode(response.bodyBytes));
    print("<<<<<<<<<<<>>>>>>>>>>" + result.toString());
    if( result["isSuccess"] == true  && result["code"] == "200") {
      Map<String, String> headers = response.headers;
      UserModel? userModel;
      String headerValue = headers['authorization'] ?? '';
      print("NEEEEEEEE===>>>   ${headerValue}");
      print("NEEEEEEEE===>>>   ${result["user"]["token"]}");

      userModel = UserModel.fromJson(result["user"]);
      userModel..token = "Bearer $headerValue";
      SharedPref.saveUserObj(userModel: userModel);
      return true;
    } else {
      ToastHelper.showError(context, message: result["message"]);
      return false;
    }
  }
  // static Future<bool> login(BuildContext context,{required LoginForm loginForm}) async {
  //   var response = await NetworkMethods.postRequestAsRow(
  //     url: API.login,
  //     body: loginForm.toJson(),
  //   );
  //     if (response == null) return false;
  //     if (response["isSuccess"] == true && response["user"]["isDeactivated"] == true) {
  //     ToastHelper.showError(context, message: response["message"]);
  //     return false;
  //   } else if (response["isSuccess"] == true && response["code"] == "200") {
  //     UserModel userModel = UserModel.fromJson(response["user"]);
  //     SharedPref.saveUserObj(userModel: userModel);
  //     return true;
  //   } else {
  //     ToastHelper.showError(context , message: response["message"]);
  //     return false;
  //   }
  // }


  static Future<VerifyOtpModel?> otpForgetPassword(
      BuildContext context,{required String phone, required String code}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.otpForgetPassword,
      body: {
        'mobileNumber': phone,
        'otp': code,
      },
    );
    if (response == null) return null;
    debugPrint(response.toString());
    if (response["isSuccess"] == true) {
      ToastHelper.showSuccess(context , message: response["message"]);
      return VerifyOtpModel.fromJson(response);
    } else {
      ToastHelper.showError(context ,message: response["message"]);
      return null;
    }
  }

  static Future<VerifyOtpModel?> otp(
      BuildContext context,{required String phone, required String code}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.verifyOtp,
      body: {
        'mobileNumber': phone,
        'otp': code,
      },
    );
    if (response == null) return null;
    debugPrint(response.toString());
    if (response["isSuccess"] == true && response["alreadyExists"] == true) {
      return VerifyOtpModel.fromJson(response);
    } else if (response["isSuccess"] == true) {
      ToastHelper.showError(context , message: response["message"]);
      return VerifyOtpModel.fromJson(response);
    }
    else {
      ToastHelper.showError(context ,message: response["message"]);
      return null;
    }
  }


  static Future<RegistrationResponse?> registration(
      BuildContext context,{required RegistrationForm registrationForm}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.register,
      body: registrationForm.toJson(),
    );
     if (response == null) return null;
    debugPrint(response.toString());
    if (response["isSuccess"] == true) {
      await SharedPref.saveAlreadyExist();
      ToastHelper.showSuccess(context,message: response["message"]);
      return RegistrationResponse.fromJson(response);
    }   else {
      ToastHelper.showError(context,message: response["message"]);
      return null;
    }
  }

  static Future<ValidateUserResponse?> forgetPassword(BuildContext context
      ,{required String mobileNumber , required String  nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.forgetPassword,
      body: {
            "mobileNumber" : mobileNumber,
            "nationalIdNumber" : nationalId
      },
    );
    if (response == null) return null;
    debugPrint(response.toString());
    if (response["isSuccess"] == true && response["isDeactivated"] == true) {
      ToastHelper.showError(context, message: response["message"]);
      return null;
    } else if (response["isSuccess"] == true) {
       ToastHelper.showSuccess(context,message: response["message"]);
       return ValidateUserResponse.fromJson(response);
      // return true;
    } else {
      ToastHelper.showError(context,message: response["message"]);
      return null;
      // return false;
    }
  }

  static Future<bool> resetPassword(BuildContext context,
      {required ResetPasswordModel resetPasswordModel}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.resetPassword,
      body: resetPasswordModel.toJson(),
    );
    if (response == null) return false;
    debugPrint(response.toString());
    if (response["isSuccess"] == true) {
      ToastHelper.showSuccess(context,message: response["message"]);
      return true;
    } else {
      ToastHelper.showError(context,message: response["message"]);
      return false;
    }
  }

  static Future<MessageResponse?> getTerms() async {
    var response = await NetworkMethods.getRequest(
      url: API.terms,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return MessageResponse.fromJson(response);
    } else {
      return null;
    }
  }

  static Future<MessageResponse?> getConditions() async {

    var response = await NetworkMethods.getRequest(
      url: API.conditions,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return MessageResponse.fromJson(response);
    } else {
      return null;
    }
  }


  static Future<bool?> deactivateUser(
      BuildContext context,{required String phone, required String nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.deactivateUser,
      body: {
        'mobile': phone,
        'nationalId': nationalId,
      },
    );
    if (response == null) return null;
    debugPrint(response.toString());
    if (response["isSuccess"] == true) {
       ToastHelper.showSuccess(context , message: response["message"]);
      return true;
    } else {
      ToastHelper.showError(context ,message: response["message"]);
      return null;
    }
  }


}
