class BillInquiryResponse {
  BillInqRs? billInqRs;
  bool? isSuccess;
  String? code;
  String? message;

  BillInquiryResponse(
      {this.billInqRs, this.isSuccess, this.code, this.message});

  BillInquiryResponse.fromJson(Map<String, dynamic> json) {
    billInqRs = json['billInqRs'] != null
        ? new BillInqRs.fromJson(json['billInqRs'])
        : null;
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billInqRs != null) {
      data['billInqRs'] = this.billInqRs!.toJson();
    }
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class BillInqRs {
  List<BillRec>? billRec;

  BillInqRs({this.billRec});

  BillInqRs.fromJson(Map<String, dynamic> json) {
    if (json['billRec'] != null) {
      billRec = <BillRec>[];
      json['billRec'].forEach((v) {
        billRec!.add(new BillRec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billRec != null) {
      data['billRec'] = this.billRec!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillRec {
  String? billingAcct;
  String? billerId;
  int? billTypeCode;
  String? billRefNumber;
  BillInfo? billInfo;
  String? billStatus;

  BillRec(
      {this.billingAcct,
        this.billerId,
        this.billTypeCode,
        this.billRefNumber,
        this.billInfo,
        this.billStatus});

  BillRec.fromJson(Map<String, dynamic> json) {
    billingAcct = json['billingAcct'];
    billerId = json['billerId'];
    billTypeCode = json['billTypeCode'];
    billRefNumber = json['billRefNumber'];
    billInfo = json['billInfo'] != null
        ? new BillInfo.fromJson(json['billInfo'])
        : null;
    billStatus = json['billStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billingAcct'] = this.billingAcct;
    data['billerId'] = this.billerId;
    data['billTypeCode'] = this.billTypeCode;
    data['billRefNumber'] = this.billRefNumber;
    if (this.billInfo != null) {
      data['billInfo'] = this.billInfo!.toJson();
    }
    data['billStatus'] = this.billStatus;
    return data;
  }
}

class BillInfo {
  List<BillSummAmt>? billSummAmt;
  List<PaymentRange>? paymentRange;
  String? rulesAwareness;
  String? extraBillInfo;

  BillInfo(
      {this.billSummAmt,
        this.paymentRange,
        this.rulesAwareness,
        this.extraBillInfo});

  BillInfo.fromJson(Map<String, dynamic> json) {
    if (json['billSummAmt'] != null) {
      billSummAmt = <BillSummAmt>[];
      json['billSummAmt'].forEach((v) {
        billSummAmt!.add(new BillSummAmt.fromJson(v));
      });
    }
    if (json['paymentRange'] != null) {
      paymentRange = <PaymentRange>[];
      json['paymentRange'].forEach((v) {
        paymentRange!.add(new PaymentRange.fromJson(v));
      });
    }
    rulesAwareness = json['rulesAwareness'];
    extraBillInfo = json['extraBillInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billSummAmt != null) {
      data['billSummAmt'] = this.billSummAmt!.map((v) => v.toJson()).toList();
    }
    if (this.paymentRange != null) {
      data['paymentRange'] = this.paymentRange!.map((v) => v.toJson()).toList();
    }
    data['rulesAwareness'] = this.rulesAwareness;
    data['extraBillInfo'] = this.extraBillInfo;
    return data;
  }
}

class BillSummAmt {
  String? billSummAmtCode;
  CurAmt? curAmt;

  BillSummAmt({this.billSummAmtCode, this.curAmt});

  BillSummAmt.fromJson(Map<String, dynamic> json) {
    billSummAmtCode = json['billSummAmtCode'];
    curAmt =
    json['curAmt'] != null ? new CurAmt.fromJson(json['curAmt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billSummAmtCode'] = this.billSummAmtCode;
    if (this.curAmt != null) {
      data['curAmt'] = this.curAmt!.toJson();
    }
    return data;
  }
}

class CurAmt {
  int? amt;
  String? curCode;

  CurAmt({this.amt, this.curCode});

  CurAmt.fromJson(Map<String, dynamic> json) {
    amt = json['amt'];
    curCode = json['curCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amt'] = this.amt;
    data['curCode'] = this.curCode;
    return data;
  }
}

class PaymentRange {
  CurAmt? lower;
  CurAmt? upper;

  PaymentRange({this.lower, this.upper});

  PaymentRange.fromJson(Map<String, dynamic> json) {
    lower = json['lower'] != null ? new CurAmt.fromJson(json['lower']) : null;
    upper = json['upper'] != null ? new CurAmt.fromJson(json['upper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lower != null) {
      data['lower'] = this.lower!.toJson();
    }
    if (this.upper != null) {
      data['upper'] = this.upper!.toJson();
    }
    return data;
  }
}