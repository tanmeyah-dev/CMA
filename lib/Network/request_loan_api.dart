
// ignore_for_file: use_build_context_synchronously

import 'package:Tanmeyah/Models/due_installment_response.dart';
import 'package:Tanmeyah/Models/previous_loan_model.dart';
import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:Tanmeyah/Models/services_model.dart';
import 'package:Tanmeyah/Network/network_methods.dart';
import 'package:flutter/cupertino.dart';
import '../Models/loan_detail_response.dart';
import '../Models/paid_installment_response.dart';
import '../Models/submit_loan_response.dart';
import '../Utilities/general_toast.dart';
import 'api.dart';

class RequestLoanApi {
  static Future<SubmitLoanResponse?> requestLoan(
      BuildContext context,{required RequestLoanModel requestLoanModel}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.requestLoan,
      body: requestLoanModel.toJson(),
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      ToastHelper.showSuccess(context , message: response["message"]);
      return SubmitLoanResponse.fromJson(response);
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
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return ServiceDetailModel.fromJson(response["product"]);
    } else {
      //ToastHelper.showError(message: response["message"]);
      return null;
    }
  }
}
