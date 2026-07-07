class MobileBillersResponse {
  List<Billers>? billers;
  bool? isSuccess;
  String? code;
  String? message;

  MobileBillersResponse({this.billers, this.isSuccess, this.code, this.message});

  MobileBillersResponse.fromJson(Map<String, dynamic> json) {
    if (json['billers'] != null) {
      billers = <Billers>[];
      json['billers'].forEach((v) { billers!.add(Billers.fromJson(v)); });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billers != null) {
      data['billers'] = billers!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Billers {
  int? id;
  String? billerName;
  String? logoUrl;

  Billers({this.id, this.billerName, this.logoUrl});

  Billers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billerName = json['billerName'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['billerName'] = billerName;
    data['logoUrl'] = logoUrl;
    return data;
  }
}