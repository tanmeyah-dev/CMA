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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['isReviewerUser'] = this.isReviewerUser;
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}