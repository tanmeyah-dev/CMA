class GuestTokenData {
  GuestTokenData({
    this.token,
    this.role,
  });

  String? token;
  String? role;

  factory GuestTokenData.fromJson(Map<String, dynamic> json) => GuestTokenData(
        token: json['token'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
      };
}

class GuestTokenResponse {
  GuestTokenResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? success;
  String? message;
  GuestTokenData? data;
  String? timestamp;

  bool get isSuccess => success == true;

  factory GuestTokenResponse.fromJson(Map<String, dynamic> json) =>
      GuestTokenResponse(
        success: json['success'] ?? json['isSuccess'],
        message: json['message'],
        data: json['data'] != null
            ? GuestTokenData.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        timestamp: json['timestamp']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
        'timestamp': timestamp,
      };
}

