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
        ? LoanRequestModel.fromJson(json['loanRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    if (loanRequest != null) {
      data['loanRequest'] = loanRequest!.toJson();
    }
    data['loanRequestBranch'] = loanRequestBranch;
    return data;
  }
}



