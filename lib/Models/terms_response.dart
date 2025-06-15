import 'dart:convert';

MessageResponse termsResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String termsResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
  bool isSuccess;
  String code;
  String message;

  MessageResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}
