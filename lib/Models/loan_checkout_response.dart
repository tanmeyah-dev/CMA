import 'package:Tanmeyah/Models/branches_model.dart';

import 'home_response.dart';

class LoanCheckoutResponse {
  bool? isSuccess;
  String? code;
  String? message;
  LoanRequestModel? loanRequest;
  BranchModel? loanRequestBranch;

  LoanCheckoutResponse(
      {this.isSuccess,
        this.code,
        this.message,
        this.loanRequest,
        this.loanRequestBranch});

  LoanCheckoutResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
    loanRequestBranch =  json["loanRequestBranch"] != null
        ? BranchModel.fromJson(json["loanRequestBranch"])
        : null;
    loanRequest = json['loanRequest'] != null
        ? new LoanRequestModel.fromJson(json['loanRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.loanRequest != null) {
      data['loanRequest'] = this.loanRequest!.toJson();
    }
    data['loanRequestBranch'] = this.loanRequestBranch;
    return data;
  }
}



