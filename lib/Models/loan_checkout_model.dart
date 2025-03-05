class LoanCheckoutModel{
  int? userId;
  String? amountTitle;
  int? amount;
  String? latitude;
  String? longitude;
  String? govId;
  String? govTitle;
  String? branchId;
  String? branchTitle;

  LoanCheckoutModel({this.amount,this.latitude,this.longitude,this.govId,this.branchId,this.amountTitle,this.branchTitle,this.govTitle,this.userId});

  Map<String, dynamic> toJson() {
    return {
      "userId" : userId,
      "amount": amount,
      "latitude": latitude,
      "longitude": longitude,
      "govId": govId,
      "branchId": branchId,
    };
  }
}
