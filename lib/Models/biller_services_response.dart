class BillerServicesResponse {
  List<Services>? services;
  List<String>? perviousBillingAccounts;
  bool? isSuccess;
  String? code;
  Null message;

  BillerServicesResponse(
      {this.services,
        this.perviousBillingAccounts,
        this.isSuccess,
        this.code,
        this.message});

  BillerServicesResponse.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    perviousBillingAccounts = json['perviousBillingAccounts'].cast<String>();
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['perviousBillingAccounts'] = perviousBillingAccounts;
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Services {
  int? id;
  String? serviceName;
  String? billTypeCode;
  String? serviceType;
  String? billTypeAcctLabel;
  String? billTypeDescription;
  bool? isHidden;
  String? billRefType;
  String? receiptFooter;
  bool? allowRcptReprint;
  bool? otpEnabled;
  bool? validationEnabled;
  String? timeout;
  String? pmtType;
  bool? otpRequired;
  bool? isBAConfRequired;
  bool? isTermsConditionReq;
  bool? isInQrQr;
  bool? isMobNtfy;
  bool? isFracAcpt;
  bool? isPrtAcpt;
  bool? isOvrAcpt;
  bool? isAdvAcpt;
  bool? isAcptCardPmt;
  List<Fees>? fees;
  List<Null>? billTypeExtraRefKeys;

  Services(
      {this.id,
        this.serviceName,
        this.billTypeCode,
        this.billTypeAcctLabel,
        this.billTypeDescription,
        this.isHidden,
        this.billRefType,
        this.receiptFooter,
        this.allowRcptReprint,
        this.otpEnabled,
        this.validationEnabled,
        this.timeout,
        this.pmtType,
        this.otpRequired,
        this.isBAConfRequired,
        this.isTermsConditionReq,
        this.isInQrQr,
        this.isMobNtfy,
        this.isFracAcpt,
        this.isPrtAcpt,
        this.isOvrAcpt,
        this.isAdvAcpt,
        this.isAcptCardPmt,
        this.fees,
        this.serviceType,
        this.billTypeExtraRefKeys});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    billTypeCode = json['billTypeCode'];
    billTypeAcctLabel = json['billTypeAcctLabel'];
    billTypeDescription = json['billTypeDescription'];
    isHidden = json['isHidden'];
    billRefType = json['billRefType'];
    receiptFooter = json['receiptFooter'];
    allowRcptReprint = json['allowRcptReprint'];
    otpEnabled = json['otpEnabled'];
    validationEnabled = json['validationEnabled'];
    timeout = json['timeout'];
    pmtType = json['pmtType'];
    otpRequired = json['otpRequired'];
    serviceType = json['serviceType'];
    isBAConfRequired = json['isBAConfRequired'];
    isTermsConditionReq = json['isTermsConditionReq'];
    isInQrQr = json['isInQrQr'];
    isMobNtfy = json['isMobNtfy'];
    isFracAcpt = json['isFracAcpt'];
    isPrtAcpt = json['isPrtAcpt'];
    isOvrAcpt = json['isOvrAcpt'];
    isAdvAcpt = json['isAdvAcpt'];
    isAcptCardPmt = json['isAcptCardPmt'];
    if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) {
        fees!.add(Fees.fromJson(v));
      });
    }
    // if (json['billTypeExtraRefKeys'] != null) {
    //   billTypeExtraRefKeys = <Null>[];
    //   json['billTypeExtraRefKeys'].forEach((v) {
    //     billTypeExtraRefKeys!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceName'] = serviceName;
    data['billTypeCode'] = billTypeCode;
    data['billTypeAcctLabel'] = billTypeAcctLabel;
    data['billTypeDescription'] = billTypeDescription;
    data['isHidden'] = isHidden;
    data['billRefType'] = billRefType;
    data['receiptFooter'] = receiptFooter;
    data['allowRcptReprint'] = allowRcptReprint;
    data['otpEnabled'] = otpEnabled;
    data['validationEnabled'] = validationEnabled;
    data['timeout'] = timeout;
    data['pmtType'] = pmtType;
    data['otpRequired'] = otpRequired;
    data['serviceType'] = serviceType;
    data['isBAConfRequired'] = isBAConfRequired;
    data['isTermsConditionReq'] = isTermsConditionReq;
    data['isInQrQr'] = isInQrQr;
    data['isMobNtfy'] = isMobNtfy;
    data['isFracAcpt'] = isFracAcpt;
    data['isPrtAcpt'] = isPrtAcpt;
    data['isOvrAcpt'] = isOvrAcpt;
    data['isAdvAcpt'] = isAdvAcpt;
    data['isAcptCardPmt'] = isAcptCardPmt;
    if (fees != null) {
      data['fees'] = fees!.map((v) => v.toJson()).toList();
    }
    // if (this.billTypeExtraRefKeys != null) {
    //   data['billTypeExtraRefKeys'] =
    //       this.billTypeExtraRefKeys!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Fees {
  double? lowerAmt;
  double? upperAmt;
  double? fixedAmt;
  String? curCode;
  bool? isEmbeddedFees;

  Fees(
      {this.lowerAmt,
        this.upperAmt,
        this.fixedAmt,
        this.curCode,
        this.isEmbeddedFees});

  Fees.fromJson(Map<String, dynamic> json) {
    lowerAmt = json['lowerAmt'].toDouble();
    upperAmt = json['upperAmt'].toDouble();
    fixedAmt = json['fixedAmt']?.toDouble();
    curCode = json['curCode'];
    isEmbeddedFees = json['isEmbeddedFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lowerAmt'] = lowerAmt;
    data['upperAmt'] = upperAmt;
    data['fixedAmt'] = fixedAmt;
    data['curCode'] = curCode;
    data['isEmbeddedFees'] = isEmbeddedFees;
    return data;
  }
}