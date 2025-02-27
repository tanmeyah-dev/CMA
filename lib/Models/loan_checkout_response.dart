import 'package:Tanmeyah/Models/branches_model.dart';

import 'home_response.dart';

class LoanCheckoutResponse {
  bool? isSuccess;
  String? code;
  String? message;
  LoanRequestModel? loanRequest;
  List<BranchModel>? branches;

  LoanCheckoutResponse(
      {this.isSuccess,
        this.code,
        this.message,
        this.loanRequest,
        this.branches});

  LoanCheckoutResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
    loanRequest = json['loanRequest'] != null
        ? new LoanRequestModel.fromJson(json['loanRequest'])
        : null;
    if (json['branches'] != null) {
      branches = <BranchModel>[];
      json['branches'].forEach((v) {
        branches!.add(new BranchModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.loanRequest != null) {
      data['loanRequest'] = this.loanRequest!.toJson();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



