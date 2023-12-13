// To parse this JSON data, do
//
//     final dueInstallmentResponse = dueInstallmentResponseFromJson(jsonString);

import 'dart:convert';

DueInstallmentResponse dueInstallmentResponseFromJson(String str) => DueInstallmentResponse.fromJson(json.decode(str));

String dueInstallmentResponseToJson(DueInstallmentResponse data) => json.encode(data.toJson());

class DueInstallmentResponse {
  DueInstallmentResponse({
     this.dueInstallments,
     this.isSuccess,
     this.code,
    this.message,
  });

  List<DueInstallment>? dueInstallments;
  bool? isSuccess;
  String? code;
  String? message;

  factory DueInstallmentResponse.fromJson(Map<String, dynamic> json) => DueInstallmentResponse(
    dueInstallments: List<DueInstallment>.from(json["dueInstallments"].map((x) => DueInstallment.fromJson(x))),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "dueInstallments": List<dynamic>.from(dueInstallments!.map((x) => x.toJson())),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}

class DueInstallment {
  DueInstallment({
    required this.instalmentAmount,
    required this.installmentDate,
    required this.partialAmount,
  });

  double instalmentAmount;
  DateTime installmentDate;
  double partialAmount;

  factory DueInstallment.fromJson(Map<String, dynamic> json) => DueInstallment(
    instalmentAmount: json["instalmentAmount"]?.toDouble(),
    installmentDate: DateTime.parse(json["installmentDate"]),
    partialAmount: json["partialAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "instalmentAmount": instalmentAmount,
    "installmentDate": installmentDate.toIso8601String(),
    "partialAmount": partialAmount,
  };
}
