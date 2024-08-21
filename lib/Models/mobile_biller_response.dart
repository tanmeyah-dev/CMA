class MobileBillersResponse {
  List<Billers>? billers;
  bool? isSuccess;
  String? code;
  String? message;

  MobileBillersResponse({this.billers, this.isSuccess, this.code, this.message});

  MobileBillersResponse.fromJson(Map<String, dynamic> json) {
    if (json['billers'] != null) {
      billers = <Billers>[];
      json['billers'].forEach((v) { billers!.add(new Billers.fromJson(v)); });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billers != null) {
      data['billers'] = this.billers!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['billerName'] = this.billerName;
    data['logoUrl'] = this.logoUrl;
    return data;
  }
}