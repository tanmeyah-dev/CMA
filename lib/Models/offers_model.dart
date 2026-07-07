// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromJson(jsonString);

import 'dart:convert';

OffersResponse offersResponseFromJson(String str) => OffersResponse.fromJson(json.decode(str));

String offersResponseToJson(OffersResponse data) => json.encode(data.toJson());

class OffersResponse {
  OffersResponse({
    required this.offers,
    required this.isSuccess,
    required this.code,
    this.message,
  });

  List<OfferModel> offers;
  bool isSuccess;
  String code;
  String? message;

  factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
    offers: List<OfferModel>.from(json["offers"].map((x) => OfferModel.fromJson(x))),
    isSuccess: json["isSuccess"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    "isSuccess": isSuccess,
    "code": code,
    "message": message,
  };
}

class OfferModel {
  OfferModel({
    required this.id,
    required this.nameAr,
    this.nameEn,
    required this.descriptionAr,
     this.descriptionEn,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
     this.title,
  });

  int id;
  String nameAr;
  String? nameEn;
  String descriptionAr;
  String? descriptionEn;
  DateTime startDate;
  DateTime endDate;
  String? imageUrl;
  String? title;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json["id"],
    nameAr: json["nameAr"],
    nameEn: json["nameEn"],
    descriptionAr: json["descriptionAr"],
    descriptionEn: json["descriptionEn"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    imageUrl: json["imageUrl"] ,
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameAr": nameAr,
    "nameEn": nameEn,
    "descriptionAr": descriptionAr,
    "descriptionEn": descriptionEn,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "imageUrl": imageUrl,
    "title" : title,
  };
}
