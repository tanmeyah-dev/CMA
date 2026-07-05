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
        services!.add(new Services.fromJson(v));
      });
    }
    perviousBillingAccounts = json['perviousBillingAccounts'].cast<String>();
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['perviousBillingAccounts'] = this.perviousBillingAccounts;
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
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
    timeout = json['timeout'] != null ? json['timeout'] : null;
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
        fees!.add(new Fees.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['billTypeCode'] = this.billTypeCode;
    data['billTypeAcctLabel'] = this.billTypeAcctLabel;
    data['billTypeDescription'] = this.billTypeDescription;
    data['isHidden'] = this.isHidden;
    data['billRefType'] = this.billRefType;
    data['receiptFooter'] = this.receiptFooter;
    data['allowRcptReprint'] = this.allowRcptReprint;
    data['otpEnabled'] = this.otpEnabled;
    data['validationEnabled'] = this.validationEnabled;
    data['timeout'] = this.timeout;
    data['pmtType'] = this.pmtType;
    data['otpRequired'] = this.otpRequired;
    data['serviceType'] = this.serviceType;
    data['isBAConfRequired'] = this.isBAConfRequired;
    data['isTermsConditionReq'] = this.isTermsConditionReq;
    data['isInQrQr'] = this.isInQrQr;
    data['isMobNtfy'] = this.isMobNtfy;
    data['isFracAcpt'] = this.isFracAcpt;
    data['isPrtAcpt'] = this.isPrtAcpt;
    data['isOvrAcpt'] = this.isOvrAcpt;
    data['isAdvAcpt'] = this.isAdvAcpt;
    data['isAcptCardPmt'] = this.isAcptCardPmt;
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v.toJson()).toList();
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
    fixedAmt = json['fixedAmt'] != null ? json['fixedAmt'].toDouble() : null;
    curCode = json['curCode'];
    isEmbeddedFees = json['isEmbeddedFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lowerAmt'] = this.lowerAmt;
    data['upperAmt'] = this.upperAmt;
    data['fixedAmt'] = this.fixedAmt;
    data['curCode'] = this.curCode;
    data['isEmbeddedFees'] = this.isEmbeddedFees;
    return data;
  }
}