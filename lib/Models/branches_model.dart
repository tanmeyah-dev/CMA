// To parse this JSON data, do
//
//     final branchesResponse = branchesResponseFromJson(jsonString);

import 'dart:convert';

BranchesResponse branchesResponseFromJson(String str) => BranchesResponse.fromJson(json.decode(str));

String branchesResponseToJson(BranchesResponse data) => json.encode(data.toJson());

class BranchesResponse {
  BranchesResponse({
    required this.branches,
    required this.isSuccess,
    this.code,
    this.message,
  });

  List<BranchModel> branches;
  bool isSuccess;
  String? code;
  String? message;

  factory BranchesResponse.fromJson(Map<String, dynamic> json) => BranchesResponse(
    branches: List<BranchModel>.from(json["branches"].map((x) => BranchModel.fromJson(x))),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}


class BranchModel {
  String? id;
  String? nameAr;
  String? nameEn;
  String? address;
  dynamic latitude;
  dynamic longitude;
  int? governorateId;
  String? governorateName;
  dynamic distance;
  String? distanceText;

  BranchModel(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.address,
        this.latitude,
        this.longitude,
        this.governorateId,
        this.governorateName,
        this.distance,
        this.distanceText,
      });

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nameAr = json['nameAr'];
    nameEn = json['nameEn'] != null ? json['nameEn'] : null;
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    governorateId = json['governorateId'];
    governorateName = json['governorateName'];
    distanceText = json['distanceText'];
    distance =   json['distance'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['governorateId'] = governorateId;
    data['governorateName'] = governorateName;
    data['distance'] = distance;
    return data;
  }
}
