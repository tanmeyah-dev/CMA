class VerifyOtpData {
  String? prospectToken;
  bool? registeredUser;

  VerifyOtpData({this.prospectToken, this.registeredUser});

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) => VerifyOtpData(
        prospectToken: json['prospectToken'],
        registeredUser: json['registeredUser'],
      );

  Map<String, dynamic> toJson() => {
        'prospectToken': prospectToken,
        'registeredUser': registeredUser,
      };
}

class VerifyOtpModel {
  VerifyOtpModel({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? success;
  String? message;
  VerifyOtpData? data;
  String? timestamp;

  bool get isSuccess => success == true;
  bool? get registeredUser => data?.registeredUser;
  String? get prospectToken => data?.prospectToken;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        success: json['success'] ?? json['isSuccess'],
        message: json['message'],
        data: json['data'] != null
            ? VerifyOtpData.fromJson(json['data'])
            : null,
        timestamp: json['timestamp'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
        'timestamp': timestamp,
      };
}
