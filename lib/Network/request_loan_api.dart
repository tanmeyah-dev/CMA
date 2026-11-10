
// ignore_for_file: use_build_context_synchronously

import 'package:Tanmeyah/Models/due_installment_response.dart';
import 'package:Tanmeyah/Models/loan_checkout_model.dart';
import 'package:Tanmeyah/Models/loan_checkout_response.dart';
import 'package:Tanmeyah/Models/previous_loan_model.dart';
import 'package:Tanmeyah/Models/services_model.dart';
import 'package:Tanmeyah/Network/network_methods.dart';
import 'package:flutter/cupertino.dart';
import '../Models/loan_detail_response.dart';
import '../Models/paid_installment_response.dart';
import '../Utilities/general_toast.dart';
import 'api.dart';

class RequestLoanApi {
  static Future<LoanCheckoutResponse?> loanCheckout(
      BuildContext context,{LoanCheckoutModel? loanCheckoutModel}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.requestLoan,
      body: loanCheckoutModel!.toJson(),
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      ToastHelper.showSuccess(context , message: response["message"]);
      return LoanCheckoutResponse.fromJson(response);
    } else {
      ToastHelper.showError(context,message: response["message"]);
      return null;
    }
  }

  static Future<LoanResponse?> getLoanDetails(
      {required String nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.getLoanDetails,
      body: {"nationalId": nationalId},
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return LoanResponse.fromJson(response);
    } else {
      //ToastHelper.showError(message: response["message"]);
      return null;
    }
  }

  static Future<PaidInstallmentResponse?> getPaidInstallment({required String nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.paidInstallment,
      body: {"nationalId": nationalId},
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return PaidInstallmentResponse.fromJson(response);
    } else {
      //ToastHelper.showError(context ,message: response["message"]);
      return null;
    }
  }


  static Future<PreviousLoanResponse?> getPreviousLoan({required String nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.previousLoan,
      body: {"nationalId": nationalId},
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return PreviousLoanResponse.fromJson(response);
    } else {
      //ToastHelper.showError(context ,message: response["message"]);
      return null;
    }
  }

  static Future<DueInstallmentResponse?> getDueInstallment(
      {required String nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.dueInstallment,
      body: {"nationalId": nationalId},
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return DueInstallmentResponse.fromJson(response);
    } else {
      //ToastHelper.showError(message: response["message"]);
      return null;
    }
  }

  static Future<ServiceDetailModel?> getServiceDetail(
      {required String id}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.servicesDetail,
      body: {"productId": id},
    );
    if (response is! Map) return null;
    final Map<String, dynamic> body = Map<String, dynamic>.from(response);
    if (body["isSuccess"] != true) return null;

    final dynamic product = body["product"] ?? body["Product"] ?? body["data"];
    if (product is Map) {
      return ServiceDetailModel.fromJson(Map<String, dynamic>.from(product));
    }
    if (body["info"] is List || body["id"] != null) {
      return ServiceDetailModel.fromJson(body);
    }
    return null;
  }
}
