import 'package:Tanmeyah/Models/user_model.dart';

class RegistrationResponse {
  bool? isSuccess;
  String? code;
  String? message;
  bool? isAlreadyMobileNumberExist;
  UserModel? user;

  RegistrationResponse(
      {this.isSuccess,
        this.code,
        this.message,
        this.isAlreadyMobileNumberExist,
        this.user});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    isAlreadyMobileNumberExist = json['isAlreadyMobileNumberExist'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    data['isAlreadyMobileNumberExist'] = isAlreadyMobileNumberExist;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
