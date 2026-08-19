// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Models/services_model.dart';

import 'offers_model.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    this.loanRequest,
    this.offers,
    this.products,
    this.activeCustomer,
    this.isSuccess,
    this.code,
    this.message,
    this.canRequestLoan,
    this.branchModel,
    this.waitingMessage,
    this.vlenseStatus,
    this.vlenseMessage,
  });

  LoanRequestModel? loanRequest;
  List<OfferModel>? offers;
  List<ServiceDetailModel>? products;
  String? waitingMessage;
  bool? activeCustomer;
  bool? isSuccess;
  bool? canRequestLoan;
  BranchModel? branchModel;
  String? code;
  String? message;
  String? vlenseStatus;
  String? vlenseMessage;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        loanRequest: json["loanRequest"] != null ? LoanRequestModel.fromJson(json["loanRequest"]) : null,
        offers: json["offers"] != null
            ? List<OfferModel>.from(json["offers"].map((x) => OfferModel.fromJson(x)))
            : null,
        products: json["products"] != null
            ? List<ServiceDetailModel>.from(json["products"].map((x) => ServiceDetailModel.fromJson(x)))
            : null,
        activeCustomer: json["activeCustomer"],
        isSuccess: json["isSuccess"],
        code: json["code"],
        waitingMessage: json["waitingMessage"],
        branchModel: json["loanRequestBranch"] != null ? BranchModel.fromJson(json["loanRequestBranch"]) : null,
        message: json["message"],
        canRequestLoan: json["canRequestLoan"],
        vlenseStatus: json["vlenseStatus"]?.toString(),
        vlenseMessage: json["vlenseMessage"]?.toString(),
      );

  String? get vlenseStatusCode {
    final value = vlenseStatus?.trim();
    if (value == null || value.isEmpty || value.toLowerCase() == 'null') {
      return null;
    }
    return value;
  }

  bool get isVlenseCompleteData => vlenseStatusCode == '200';

  bool get isVlenseWaiting => vlenseStatusCode == '300';

  Map<String, dynamic> toJson() => {
        "loanRequest": loanRequest,
        "offers": offers != null ? List<dynamic>.from(offers!.map((x) => x.toJson())) : null,
        "products": products != null ? List<dynamic>.from(products!.map((x) => x.toJson())) : null,
        "activeCustomer": activeCustomer,
        "isSuccess": isSuccess,
        "loanRequestBranch": branchModel,
        "code": code,
        "message": message,
        "canRequestLoan": canRequestLoan,
        "waitingMessage": waitingMessage,
        "vlenseStatus": vlenseStatus,
        "vlenseMessage": vlenseMessage,
      };
}

class Info {
  Info({
    this.productId,
    this.infoKey,
    this.infoValue,
    this.imageUrl,
  });

  int? productId;
  String? infoKey;
  String? infoValue;
  String? imageUrl;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        productId: json["productId"],
        infoKey: json["infoKey"],
        infoValue: json["infoValue"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "infoKey": infoKey,
        "infoValue": infoValue,
        "imageUrl": imageUrl,
      };
}

class LoanRequestModel {
  double? totalAmount;
  double? paidAmount;
  String? nextInstallmentDate;
  int? numberOfpaidMonths;
  int? numberOfNotPaidMonths;
  double? totalDueAmount;
  double? dueInstallmentAmount;
  double? lastPaidInstallmentAmount;
  String? lastPaidInstallmentDate;

  LoanRequestModel(
      {this.totalAmount,
        this.paidAmount,
        this.nextInstallmentDate,
        this.numberOfpaidMonths,
        this.numberOfNotPaidMonths,
        this.totalDueAmount,
        this.dueInstallmentAmount,
        this.lastPaidInstallmentAmount,
        this.lastPaidInstallmentDate
      });

  LoanRequestModel.fromJson(Map<String, dynamic> json){
    totalAmount = json['totalAmount']?.toDouble();
    paidAmount = json['totalAmount'] != null ? json['paidAmount'].toDouble() : null;
    nextInstallmentDate = json['nextInstallmentDate'];
    numberOfpaidMonths = json['numberOfpaidMonths'];
    numberOfNotPaidMonths = json['numberOfNotPaidMonths'];
    totalDueAmount = json['totalAmount'] != null ? json['totalDueAmount'].toDouble(): null;
    dueInstallmentAmount = json['totalAmount'] != null ? json['dueInstallmentAmount'].toDouble() : null;
    lastPaidInstallmentAmount =  json["lastPaidInstallmentAmount"]?.toDouble();
    lastPaidInstallmentDate =  json["lastPaidInstallmentDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['paidAmount'] = paidAmount;
    data['nextInstallmentDate'] = nextInstallmentDate;
    data['numberOfpaidMonths'] = numberOfpaidMonths;
    data['numberOfNotPaidMonths'] = numberOfNotPaidMonths;
    data['totalDueAmount'] = totalDueAmount;
    data['dueInstallmentAmount'] = dueInstallmentAmount;
    data['lastPaidInstallmentAmount'] = lastPaidInstallmentAmount;
    data['lastPaidInstallmentDate'] = lastPaidInstallmentDate;
    return data;
  }
}


class Branch {
  int? id;
  String? nameAr;
  String? nameEn;
  String? address;
  double? latitude;
  double? longitude;
  String? location;
  int? governorateId;
  String? governorateName;
  double? distance;

  Branch({
     this.id,
     this.nameAr,
    this.nameEn,
     this.address,
     this.latitude,
     this.longitude,
     this.location,
     this.governorateId,
    this.governorateName,
     this.distance,
  });
}

class ServiceType {
  int? id;
  String? serviceTypeName;
  String? serviceTypeShortName;
  String? logoUrl;

  ServiceType({
    this.id,
    this.serviceTypeName,
    this.serviceTypeShortName,
    this.logoUrl,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json["id"],
    serviceTypeName: json["serviceTypeName"],
    serviceTypeShortName: json["serviceTypeShortName"],
    logoUrl: json["logoUrl"],
  );
}