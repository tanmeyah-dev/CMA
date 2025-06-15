class GetAllServicesResponse {
  List<ServiceTypes>? serviceTypes;
  bool? isSuccess;
  String? code;
  String? message;

  GetAllServicesResponse({this.serviceTypes, this.isSuccess, this.code, this.message});

  GetAllServicesResponse.fromJson(Map<String, dynamic> json) {
    if (json['serviceTypes'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['serviceTypes'].forEach((v) {
        serviceTypes!.add(new ServiceTypes.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceTypes != null) {
      data['serviceTypes'] = this.serviceTypes!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class ServiceTypes {
  int? id;
  String? serviceTypeName;
  String? serviceTypeShortName;
  String? logoUrl;

  ServiceTypes(
      {this.id, this.serviceTypeName, this.serviceTypeShortName, this.logoUrl});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceTypeName = json['serviceTypeName'];
    serviceTypeShortName = json['serviceTypeShortName'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceTypeName'] = this.serviceTypeName;
    data['serviceTypeShortName'] = this.serviceTypeShortName;
    data['logoUrl'] = this.logoUrl;
    return data;
  }
}