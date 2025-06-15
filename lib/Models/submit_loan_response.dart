import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Models/request_loan_response.dart';

class SubmitLoanResponse {
  RequestLoanModel? requestLoanModel;
  List<BranchModel>? branches;
  bool? isSuccess;
  String? code;
  String? message;

  SubmitLoanResponse(
      {this.requestLoanModel,
        this.branches,
        this.isSuccess,
        this.code,
        this.message});

  SubmitLoanResponse.fromJson(Map<String, dynamic> json) {
    requestLoanModel = json['loanRequest'] != null
        ? RequestLoanModel.fromJson(json['loanRequest'])
        : null;
    if (json['branches'] != null) {
      branches = <BranchModel>[];
      json['branches'].forEach((v) {
        branches!.add(BranchModel.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (requestLoanModel != null) {
      data['loanRequest'] = requestLoanModel!.toJson();
    }
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

