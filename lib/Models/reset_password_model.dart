class ResetPasswordModel {

  String mobileNumber;
  String password;
  String confirmPassword;
  String otp;
  String? salt;

  ResetPasswordModel({required this.mobileNumber,required this.password,required this.confirmPassword, required this.otp, this.salt});


  Map<String, String> toJson() {
    Map<String, String> body = {
      "mobileNumber": mobileNumber,
      "password": password,
      "confirmPassword": confirmPassword,
      "otp": otp,
    };
    return body;
  }


}