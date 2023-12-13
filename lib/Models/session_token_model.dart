// To parse this JSON data, do
//
//     final sessionToken = sessionTokenFromJson(jsonString);

import 'dart:convert';

SessionToken sessionTokenFromJson(String str) => SessionToken.fromJson(json.decode(str));

String sessionTokenToJson(SessionToken data) => json.encode(data.toJson());

class SessionToken {
  SessionToken({
    required this.token,
    // required this.passwordWordsDictionary,
    required this.isSuccess,
    required this.code,
    this.message,
  });

  String token;
  // List<String> passwordWordsDictionary;
  bool isSuccess;
  String code;
  String? message;

  factory SessionToken.fromJson(Map<String, dynamic> json) => SessionToken(
    token:  json["token"],
    // passwordWordsDictionary: List<String>.from(json["passwordWordsDictionary"].map((x) => x)),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"] ,
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    // "passwordWordsDictionary": List<dynamic>.from(passwordWordsDictionary.map((x) => x)),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}
