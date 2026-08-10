class LoanCheckoutModel {
  int? userId;
  int? productId;
  String? amountTitle;
  int? amount;
  int? installments;
  String? latitude;
  String? longitude;
  String? govId;
  String? govTitle;
  String? branchId;
  String? branchTitle;

  LoanCheckoutModel({
    this.amount,
    this.installments,
    this.productId,
    this.latitude,
    this.longitude,
    this.govId,
    this.branchId,
    this.amountTitle,
    this.branchTitle,
    this.govTitle,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "productId": productId,
      "amount": amount,
      "numberOfInstallments": installments, // عدد الأقساط ← مده التمويل
      "latitude": latitude,
      "longitude": longitude,
      "govId": govId,
      "branchId": branchId,
    };
  }
}
