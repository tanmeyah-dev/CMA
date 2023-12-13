// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
     this.alreadyExists,
     this.isSuccess,
     this.code,
     this.message,
  });

  bool? alreadyExists;
  bool? isSuccess;
  String? code;
  String? message;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    alreadyExists: json["alreadyExists"],
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"] != null ? json["message"] : null,
  );

  Map<String, dynamic> toJson() => {
    "alreadyExists": alreadyExists,
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}
