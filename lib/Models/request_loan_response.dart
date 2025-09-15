// To parse this JSON data, do
//
//     final requestLoanResponse = requestLoanResponseFromJson(jsonString);

import 'dart:convert';

RequestLoanResponse requestLoanResponseFromJson(String str) => RequestLoanResponse.fromJson(json.decode(str));

String requestLoanResponseToJson(RequestLoanResponse data) => json.encode(data.toJson());

class RequestLoanResponse {
  RequestLoanResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.loanRequest,
  });

  bool isSuccess;
  String code;
  String message;
  RequestLoanModel loanRequest;

  factory RequestLoanResponse.fromJson(Map<String, dynamic> json) => RequestLoanResponse(
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
    loanRequest: RequestLoanModel.fromJson(json["loanRequest"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
    "loanRequest": loanRequest.toJson(),
  };
}

class RequestLoanModel {
  RequestLoanModel({
     this.id,
    required this.userId,
    required this.amount,
    required this.requestDate,
    this.latitude,
    this.longitude,
  });

  int? id;
  String userId;
  String amount;
  String requestDate;
  String? latitude;
  String? longitude;

  factory RequestLoanModel.fromJson(Map<String, dynamic> json) => RequestLoanModel(
    id: json["id"]??"",
    userId: json["userId"]??"",
    amount: json["amount"]?.toString() ?? "",
    requestDate: json["requestDate"]??"",
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "amount": amount,
    "requestDate": requestDate,
    "latitude" : latitude,
    "longitude" : longitude,
  };
}
