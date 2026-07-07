class BillInquiryResponse {
  BillInqRs? billInqRs;
  late bool isSuccess;
  String? code;
  String? message;

  BillInquiryResponse(
      {this.billInqRs, this.isSuccess = false, this.code, this.message});

  BillInquiryResponse.fromJson(Map<String, dynamic> json) {
    billInqRs = json['billInqRs'] != null
        ? BillInqRs.fromJson(json['billInqRs'])
        : null;
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billInqRs != null) {
      data['billInqRs'] = billInqRs!.toJson();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
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
        billRec!.add(BillRec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billRec != null) {
      data['billRec'] = billRec!.map((v) => v.toJson()).toList();
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
        ? BillInfo.fromJson(json['billInfo'])
        : null;
    billStatus = json['billStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billingAcct'] = billingAcct;
    data['billerId'] = billerId;
    data['billTypeCode'] = billTypeCode;
    data['billRefNumber'] = billRefNumber;
    if (billInfo != null) {
      data['billInfo'] = billInfo!.toJson();
    }
    data['billStatus'] = billStatus;
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
        billSummAmt!.add(BillSummAmt.fromJson(v));
      });
    }
    if (json['paymentRange'] != null) {
      paymentRange = <PaymentRange>[];
      json['paymentRange'].forEach((v) {
        paymentRange!.add(PaymentRange.fromJson(v));
      });
    }
    rulesAwareness = json['rulesAwareness'];
    extraBillInfo = json['extraBillInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billSummAmt != null) {
      data['billSummAmt'] = billSummAmt!.map((v) => v.toJson()).toList();
    }
    if (paymentRange != null) {
      data['paymentRange'] = paymentRange!.map((v) => v.toJson()).toList();
    }
    data['rulesAwareness'] = rulesAwareness;
    data['extraBillInfo'] = extraBillInfo;
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
    json['curAmt'] != null ? CurAmt.fromJson(json['curAmt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billSummAmtCode'] = billSummAmtCode;
    if (curAmt != null) {
      data['curAmt'] = curAmt!.toJson();
    }
    return data;
  }
}

class CurAmt {
  double? amt;
  String? curCode;

  CurAmt({this.amt, this.curCode});

  CurAmt.fromJson(Map<String, dynamic> json) {
    amt = json['amt'];
    curCode = json['curCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amt'] = amt;
    data['curCode'] = curCode;
    return data;
  }
}

class PaymentRange {
  CurAmt? lower;
  CurAmt? upper;

  PaymentRange({this.lower, this.upper});

  PaymentRange.fromJson(Map<String, dynamic> json) {
    lower = json['lower'] != null ? CurAmt.fromJson(json['lower']) : null;
    upper = json['upper'] != null ? CurAmt.fromJson(json['upper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lower != null) {
      data['lower'] = lower!.toJson();
    }
    if (upper != null) {
      data['upper'] = upper!.toJson();
    }
    return data;
  }
}