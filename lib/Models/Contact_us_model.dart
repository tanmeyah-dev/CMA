class ContactUsModel{
  String phoneNumber;
  String name;
  String message;
  String? lookupId;
  ContactUsModel({required this.phoneNumber,required this.name,required this.message, this.lookupId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> body = {
      "customerName": name,
      "phone": phoneNumber,
      "message": message,
    };
    if (lookupId != null && lookupId!.isNotEmpty) {
      body["lookupId"] = lookupId;
    }
    return body;
  }

}

class ContactUsResponse {
  Contact? contact;
  bool? isSuccess;
  String? code;
  String? message;

  ContactUsResponse({
    this.contact,
    this.isSuccess,
    this.code,
    this.message,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => ContactUsResponse(
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact?.toJson(),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}

class Contact {
  String? email;
  String? phone;
  DateTime? timestamp;
  String? message;

  Contact({
    this.email,
    this.phone,
    this.timestamp,
    this.message,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    email: json["email"],
    phone: json["phone"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "timestamp": timestamp?.toIso8601String(),
    "message": message,
  };
}
