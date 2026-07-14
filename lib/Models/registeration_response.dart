class RegistrationData {
  RegistrationData({this.active});

  bool? active;

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(active: json['active']);

  Map<String, dynamic> toJson() => {
        'active': active,
      };
}

class RegistrationResponse {
  RegistrationResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
    this.isAlreadyMobileNumberExist,
  });

  bool? success;
  String? message;
  RegistrationData? data;
  String? timestamp;
  bool? isAlreadyMobileNumberExist;

  bool get isSuccess => success == true;
  bool? get active => data?.active;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        success: json['success'] ?? json['isSuccess'],
        message: json['message'],
        data: json['data'] != null
            ? RegistrationData.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        timestamp: json['timestamp']?.toString(),
        isAlreadyMobileNumberExist: json['isAlreadyMobileNumberExist'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
        'timestamp': timestamp,
        'isAlreadyMobileNumberExist': isAlreadyMobileNumberExist,
      };
}
