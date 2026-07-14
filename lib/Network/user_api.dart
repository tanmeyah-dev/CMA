
// ignore_for_file: use_build_context_synchronously

import 'package:Tanmeyah/Models/guest_token_response.dart';
import 'package:Tanmeyah/Models/login_form.dart';
import 'package:Tanmeyah/Models/registeration_form.dart';
import 'package:Tanmeyah/Models/registeration_response.dart';
import 'package:Tanmeyah/Models/reset_password_model.dart';
import 'package:Tanmeyah/Models/terms_response.dart';
import 'package:Tanmeyah/Models/validate_user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/user_model.dart';
import '../Models/verify_otp_model.dart';
import '../Shared/shared_prefirences.dart';
import '../Utilities/general_toast.dart';
import '../Utilities/device_id_helper.dart';
import 'api.dart';
import 'network_methods.dart';


class UserApi {


  static Future<GuestTokenResponse?> fetchGuestToken() async {
    final deviceId = await DeviceIdHelper.getDeviceId();
    final response = await NetworkMethods.postRequestAsRow(
      url: API.token,
      body: {"deviceId": deviceId},
      suppressAuthRedirect: true,
      skipAuthHeader: true,
    );
    if (response == null) return null;

    final guestTokenResponse = GuestTokenResponse.fromJson(response);
    final token = guestTokenResponse.data?.token;
    if (guestTokenResponse.isSuccess && token != null && token.isNotEmpty) {
      await SharedPref.saveGuestToken(token: "Bearer $token");
    }
    return guestTokenResponse;
  }



  static Future<ValidateUserResponse?> validateUser(BuildContext context,{required String phone}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.validateUser,
      body: {
        "mobileNumber" : phone
      },
    );
    if (response == null) return null;
    final isSuccess = response["success"] == true || response["isSuccess"] == true;
    if (isSuccess) {
       ToastHelper.showSuccess(context , message: response["message"]);
        return ValidateUserResponse.fromJson(response);
    } else {
      ToastHelper.showError(context , message: response["message"]);
      return null;
    }
  }


  static Future<bool> login(BuildContext context,
      {required LoginForm loginForm}) async {
    return false;
    // final response = await NetworkMethods.postRequestAsRow(
    //   url: API.login,
    //   body: loginForm.toJson(),
    // );
    // if (response == null) return false;
    // debugPrint(response.toString());
    // if (response["success"] == true) {
    //   ToastHelper.showSuccess(context , message: response["message"]);
    //   return VerifyOtpModel.fromJson(response);
    // } else {
    //   ToastHelper.showError(context ,message: response["message"]);
    //   return null;
    // }
    //
    // final isSuccess = response["success"] == true;
    // if (!isSuccess) {
    //   ToastHelper.showError(context, message: response["message"]);
    //   return false;
    // }
    //
    // final rawData = response["data"] ?? response["user"];
    // if (rawData is! Map) {
    //   ToastHelper.showError(context, message: response["message"]);
    //   return false;
    // }
    //
    // final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
    // final Map<String, dynamic> userJson = data["user"] is Map
    //     ? Map<String, dynamic>.from(data["user"] as Map)
    //     : data;
    //
    // if (userJson["isDeactivated"] == true) {
    //   ToastHelper.showError(context, message: response["message"]);
    //   return false;
    // }
    //
    // final userModel = UserModel.fromJson(userJson);
    // final token = (data["token"] ?? userJson["token"])?.toString();
    // if (token != null && token.isNotEmpty) {
    //   userModel.token = token.startsWith("Bearer ") ? token : "Bearer $token";
    // }
    // await SharedPref.saveUserObj(userModel: userModel);
    // return true;
  }


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
        'otpCode': code,
      },
    );
    if (response == null) return null;
    debugPrint(response.toString());
    final isSuccess = response["success"] == true || response["isSuccess"] == true;
    if (isSuccess) {
      ToastHelper.showSuccess(context, message: response["message"]);
      return VerifyOtpModel.fromJson(response);
    } else {
      ToastHelper.showError(context, message: response["message"]);
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
    final isSuccess = response["success"] == true || response["isSuccess"] == true;
    if (isSuccess) {
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
