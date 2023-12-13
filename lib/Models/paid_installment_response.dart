class PaidInstallmentResponse {
  List<PaidInstallment>? paidInstallment;
  bool? isSuccess;
  String? code;
  String? message;

  PaidInstallmentResponse(
      {this.paidInstallment, this.isSuccess, this.code, this.message});

  PaidInstallmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['paidIsntallment'] != null) {
      paidInstallment = <PaidInstallment>[];
      json['paidIsntallment'].forEach((v) {
        paidInstallment!.add(PaidInstallment.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paidInstallment != null) {
      data['paidIsntallment'] =
          paidInstallment!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class PaidInstallment {
  int? instalmentAmount;
  String? dateOfPayment;
  String? paymentMethod;
  int? numberOfTransaction;
  String? month;

  PaidInstallment(
      {this.instalmentAmount,
        this.dateOfPayment,
        this.paymentMethod,
        this.numberOfTransaction,
        this.month});

  PaidInstallment.fromJson(Map<String, dynamic> json) {
    instalmentAmount = json['instalmentAmount'];
    dateOfPayment = json['dateOfPayment'];
    paymentMethod = json['paymentMethod'];
    numberOfTransaction = json['numberOfTransaction'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instalmentAmount'] = instalmentAmount;
    data['dateOfPayment'] = dateOfPayment;
    data['paymentMethod'] = paymentMethod;
    data['numberOfTransaction'] = numberOfTransaction;
    data['month'] = month;
    return data;
  }
}