class ResetPasswordModel {

  String mobileNumber;
  String password;
  String confirmPassword;
  String? salt;

  ResetPasswordModel({required this.mobileNumber,required this.password,required this.confirmPassword, this.salt});


  Map<String, String> toJson() {
    Map<String, String> body = {
      "mobileNumber": mobileNumber,
      "password": password,
      "confirmPassword": confirmPassword,
    };
    return body;
  }


}