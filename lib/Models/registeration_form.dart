class RegistrationForm {
  String fullName;
  String nationalId;
  String dateOfBirth;
  String phoneNumber;
  String? email;
  String password;
  String confirmPassword;
  String governmentId;

  RegistrationForm(
      {required this.fullName,
      required this.nationalId,
      required this.dateOfBirth,
      required this.phoneNumber,
        this.email,
      required this.password,
      required this.confirmPassword,
      required this.governmentId,
      });

  Map<String, String> toJson() {
    Map<String, String> body = {
      "fullName": fullName,
      "nationalId": nationalId,
      "dateOfBirth": dateOfBirth,
      "mobileNumber" : phoneNumber,
      "email" : email??"",
      "password" : password,
      "confirmPassword" : confirmPassword,
      "governorateId" :governmentId,
    };
    return body;
  }



}
