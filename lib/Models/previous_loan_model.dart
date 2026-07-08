class PreviousLoanResponse {
  bool? haveHostoricalLoan;
  List<HistoricalDataBodies> historicalDataBodies = [];
  bool? isSuccess;
  String? code;
  String? message;

  PreviousLoanResponse(
      {this.haveHostoricalLoan,
        required this.historicalDataBodies,
        this.isSuccess,
        this.code,
        this.message});

  PreviousLoanResponse.fromJson(Map<String, dynamic> json) {
    haveHostoricalLoan = json['haveHostoricalLoan'];
    if (json['historicalDataBodies'] != null) {
      historicalDataBodies = <HistoricalDataBodies>[];
      json['historicalDataBodies'].forEach((v) {
        historicalDataBodies.add(HistoricalDataBodies.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['haveHostoricalLoan'] = haveHostoricalLoan;
    data['historicalDataBodies'] =
        historicalDataBodies.map((v) => v.toJson()).toList();
      data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class HistoricalDataBodies {
  String? busDate;
  String? expDate;
  int? approve;
  int? totalAmount;

  HistoricalDataBodies(
      {this.busDate, this.expDate, this.approve, this.totalAmount});

  HistoricalDataBodies.fromJson(Map<String, dynamic> json) {
    busDate = json['busDate'];
    expDate = json['expDate'];
    approve = json['approve'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['busDate'] = busDate;
    data['expDate'] = expDate;
    data['approve'] = approve;
    data['totalAmount'] = totalAmount;
    return data;
  }
}