class LoanProductsResponse {
  bool? isSuccess;
  String? code;
  String? message;
  String? title;
  List<LoanRequestProducts>? loanRequestProducts;

  LoanProductsResponse(
      {this.isSuccess, this.code, this.message, this.loanRequestProducts,this.title});

  LoanProductsResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
    title = json['title'];
    if (json['loanRequestProducts'] != null) {
      loanRequestProducts = <LoanRequestProducts>[];
      json['loanRequestProducts'].forEach((v) {
        loanRequestProducts!.add(LoanRequestProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    data['title'] = title;
    if (loanRequestProducts != null) {
      data['loanRequestProducts'] =
          loanRequestProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanRequestProducts {
  int? id;
  String? name;

  LoanRequestProducts({this.id, this.name});

  LoanRequestProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}