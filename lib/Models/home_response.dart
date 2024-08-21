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
    required this.loanRequest,
    required this.offers,
    required this.products,
    required this.activeCustomer,
    required this.isSuccess,
    this.code,
    this.message,
    this.serviceTypes,
    required this.canRequestLoan,
    this.branches,
    this.waitingMessage,
  });

  LoanRequestModel? loanRequest;
  List<OfferModel> offers;
  List<ServiceDetailModel> products;
  List<BranchModel>? branches;
  String? waitingMessage;
  List<ServiceType>? serviceTypes;
  bool activeCustomer;
  bool isSuccess;
  bool canRequestLoan;
  String? code;
  String? message;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    loanRequest: json["loanRequest"] != null ? LoanRequestModel.fromJson(json["loanRequest"]) : null,
        offers: List<OfferModel>.from(json["offers"].map((x) => OfferModel.fromJson(x))),
        products: List<ServiceDetailModel>.from(
            json["products"].map((x) => ServiceDetailModel.fromJson(x))),
        branches: List<BranchModel>.from(json["branches"].map((x) => BranchModel.fromJson(x))),
        serviceTypes: List<ServiceType>.from(json["serviceTypes"].map((x) => ServiceType.fromJson(x))),
        activeCustomer: json["activeCustomer"],
        isSuccess: json["isSuccess"],
        code: json["code"],
        waitingMessage: json["waitingMessage"],
        message: json["message"],
        canRequestLoan: json["canRequestLoan"],
      );

  Map<String, dynamic> toJson() => {
        "loanRequest": loanRequest,
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "activeCustomer": activeCustomer,
        "isSuccess": isSuccess,
        "code": code,
        "message": message,
        "canRequestLoan" : canRequestLoan,
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
    totalAmount = json['totalAmount'].toDouble();
    paidAmount = json['paidAmount'].toDouble();
    nextInstallmentDate = json['nextInstallmentDate'];
    numberOfpaidMonths = json['numberOfpaidMonths'];
    numberOfNotPaidMonths = json['numberOfNotPaidMonths'];
    totalDueAmount = json['totalDueAmount'].toDouble();
    dueInstallmentAmount = json['dueInstallmentAmount'].toDouble();
    lastPaidInstallmentAmount =  json["lastPaidInstallmentAmount"] != null ? json["lastPaidInstallmentAmount"].toDouble() : null;
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