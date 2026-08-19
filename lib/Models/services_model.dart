// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'dart:convert';

ServicesResponse servicesResponseFromJson(String str) =>
    ServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(ServicesResponse data) =>
    json.encode(data.toJson());

class ServicesResponse {
  ServicesResponse({
    this.products,
    required this.isSuccess,
    required this.code,
    this.message,
  });

  List<ServiceDetailModel>? products;
  bool isSuccess;
  String code;
  String? message;

  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      ServicesResponse(
        products: json["products"] != null
            ? List<ServiceDetailModel>.from(
                json["products"].map((x) => ServiceDetailModel.fromJson(x)))
            : null,
        isSuccess: json["isSuccess"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "code": code,
        "message": message,
      };
}

class ServiceDetailModel {


  ServiceDetailModel({
    required this.id,
    this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.imageUrl,
    this.logo,
    this.titleImg,
    this.info,
    this.color,
    this.title,
    // this.productColor,
  });

  int id;
  String? nameAr;
  String? nameEn;
  String? title;
  String? descriptionAr;
  String? descriptionEn;
  String? imageUrl;
  String? logo;
  String? titleImg;
  // Color? productColor;
  List<Info>? info;
  int? color;


  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) =>
     ServiceDetailModel(
      // productColor:  list,
       color: json["color"] == null ? int.parse("0xFF092076")  : int.parse(json["color"]),
      id: json["id"],
      nameAr: json["nameAr"],
      title: json["title"],
      nameEn: json["nameEn"],
      descriptionAr: json["descriptionAr"],
      descriptionEn:
          json["descriptionEn"],
      imageUrl: json["image"] ?? json["imageUrl"],
       logo: json["logo"],
       titleImg: json["titleImg"],
      info: json["info"] != null
          ? List<Info>.from(json["info"].map((x) => Info.fromJson(x)))
          : null,
      );


  Map<String, dynamic> toJson() => {
        "color" : color,
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "logo" : logo,
        "titleImg" : titleImg,
        "imageUrl": imageUrl,
        "info": List<Info>.from(info!.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.productId,
    this.infoKey,
    required this.infoValue,
    required this.imageUrl,
  });

  int productId;
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
         "imageUrl" : imageUrl,
      };
}
