// To parse this JSON data, do
//
//     final loanResponse = loanResponseFromJson(jsonString);

import 'dart:convert';

LoanResponse loanResponseFromJson(String str) => LoanResponse.fromJson(json.decode(str));

String loanResponseToJson(LoanResponse data) => json.encode(data.toJson());

class LoanResponse {
  LoanResponse({
    this.havePreviousLoan,
    this.activeLoan,
     this.isSuccess,
     this.code,
     this.message,
  });

  ActiveLoan? activeLoan;
  bool? isSuccess;
  String? code;
  String? message;
  bool? havePreviousLoan;

  factory LoanResponse.fromJson(Map<String, dynamic> json) => LoanResponse(
    havePreviousLoan: json["havePreviousLoan"] ,
    activeLoan: json["activeLoan"] != null ?  ActiveLoan.fromJson(json["activeLoan"]) : null,
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "activeLoan": activeLoan!.toJson(),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,

  };
}

class ActiveLoan {
  ActiveLoan({
    required this.totalAmount,
    required this.paidAmount,
    required this.nextInstallmentDate,
    required this.numberOfpaidMonths,
    required this.numberOfNotPaidMonths,
    required this.totalDueAmount,
    required this.dueInstallmentAmount,
    this.penaltyAmount
  });

  double totalAmount;
  double paidAmount;
  String nextInstallmentDate;
  int? numberOfpaidMonths;
  int? numberOfNotPaidMonths;
  double totalDueAmount;
  double dueInstallmentAmount;
  double? penaltyAmount;

  factory ActiveLoan.fromJson(Map<String, dynamic> json) => ActiveLoan(
    totalAmount: json["totalAmount"].toDouble(),
    paidAmount: json["paidAmount"]?.toDouble(),
    nextInstallmentDate: json["nextInstallmentDate"],
    numberOfpaidMonths: json["numberOfpaidMonths"],
    numberOfNotPaidMonths: json["numberOfNotPaidMonths"],
    totalDueAmount: json["totalDueAmount"]?.toDouble(),
    dueInstallmentAmount: json["dueInstallmentAmount"].toDouble(),
      penaltyAmount : json["penaltyAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "nextInstallmentDate": nextInstallmentDate,
    "numberOfpaidMonths": numberOfpaidMonths,
    "numberOfNotPaidMonths": numberOfNotPaidMonths,
    "totalDueAmount": totalDueAmount,
    "dueInstallmentAmount" : dueInstallmentAmount,
  };
}
