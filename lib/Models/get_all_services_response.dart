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
        serviceTypes!.add(ServiceTypes.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (serviceTypes != null) {
      data['serviceTypes'] = serviceTypes!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceTypeName'] = serviceTypeName;
    data['serviceTypeShortName'] = serviceTypeShortName;
    data['logoUrl'] = logoUrl;
    return data;
  }
}