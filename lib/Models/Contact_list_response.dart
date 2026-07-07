class ContactListResponse {
  List<ContactUsLookups>? contactUsLookups;
  bool? isSuccess;
  String? code;
  String? message;

  ContactListResponse(
      {this.contactUsLookups, this.isSuccess, this.code, this.message});

  ContactListResponse.fromJson(Map<String, dynamic> json) {
    if (json['contactUsLookups'] != null) {
      contactUsLookups = <ContactUsLookups>[];
      json['contactUsLookups'].forEach((v) {
        contactUsLookups!.add(ContactUsLookups.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contactUsLookups != null) {
      data['contactUsLookups'] =
          contactUsLookups!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class ContactUsLookups {
  int? id;
  String? text;

  ContactUsLookups({this.id, this.text});

  ContactUsLookups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    return data;
  }
}