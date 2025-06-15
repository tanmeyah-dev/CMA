class LoginForm{
  String phoneNumber;
  String password;
  LoginForm({required this.phoneNumber,required this.password});

  Map<String, String> toJson() {
    Map<String, String> body = {
      "mobileNumber": phoneNumber,
      "password": password,
    };
    return body;
  }


}