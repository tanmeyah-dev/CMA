class ValidateUserResponse {
  String? otp;
  bool? isReviewerUser;
  bool? isSuccess;
  String? code;
  String? message;

  ValidateUserResponse(
      {this.otp, this.isReviewerUser, this.isSuccess, this.code, this.message});

  ValidateUserResponse.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    isReviewerUser = json['isReviewerUser'];
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['isReviewerUser'] = isReviewerUser;
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}