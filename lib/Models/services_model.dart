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
       color: _asInt(json["color"]) ?? int.parse("0xFF092076"),
      id: _asInt(json["id"]) ?? 0,
      nameAr: json["nameAr"]?.toString(),
      title: json["title"]?.toString(),
      nameEn: json["nameEn"]?.toString() ?? "",
      descriptionAr: json["descriptionAr"]?.toString() ?? "",
      descriptionEn: json["descriptionEn"]?.toString() ?? "",
      imageUrl: (json["image"] ?? json["imageUrl"])?.toString() ?? "",
       logo: json["logo"]?.toString(),
       titleImg: json["titleImg"]?.toString(),
      info: json["info"] is List
          ? (json["info"] as List)
              .whereType<Map>()
              .map((x) => Info.fromJson(Map<String, dynamic>.from(x)))
              .toList()
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

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? "");
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
        productId: _asInt(json["productId"]) ?? 0,
        infoKey: json["infoKey"]?.toString(),
        infoValue: json["infoValue"]?.toString() ?? "",
        imageUrl: json["imageUrl"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "infoKey": infoKey,
        "infoValue": infoValue,
         "imageUrl" : imageUrl,
      };
}
