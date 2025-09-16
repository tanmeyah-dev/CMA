import 'branches_model.dart';

class CityResponse {
  List<BranchModel>? branches;
  bool? isSuccess;
  String? code;
  String? message;

  CityResponse({this.branches, this.isSuccess, this.code, this.message});

  CityResponse.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <BranchModel>[];
      json['branches'].forEach((v) {
        branches!.add(BranchModel.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}