// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class User {
  User({
    required this.userModel,
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  UserModel userModel;
  bool isSuccess;
  String code;
  String message;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userModel: UserModel.fromJson(json["user"]),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": userModel.toJson(),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}

class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.birthDate,
    required this.mobileNumber,
     this.email,
    required this.isActive,
     this.token,
    this.governmentId,
  });

  int id;
  String fullName;
  String nationalId;
  String birthDate;
  String mobileNumber;
  String? email;
  bool isActive;
  String? token;
  String? governmentId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    fullName: json["fullName"],
    nationalId: json["nationalId"],
    birthDate: json["birthDate"],
    mobileNumber: json["mobileNumber"],
    email: json["email"] != null ? json["email"]: null,
    isActive: json["isActive"],
    token: json["token"] != null ? json["token"] : null,
    governmentId: json["governorateId"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "nationalId": nationalId,
    "birthDate": birthDate,
    "mobileNumber": mobileNumber,
    "email": email,
    "isActive": isActive,
    "token": token,
    "governorateId": governmentId,
  };

  @override
  String toString() {
    return 'UserModel(id: $id, isActive: $isActive)';
  }
}
