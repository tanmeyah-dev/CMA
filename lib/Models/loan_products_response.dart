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
        loanRequestProducts!.add(new LoanRequestProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    data['title'] = this.title;
    if (this.loanRequestProducts != null) {
      data['loanRequestProducts'] =
          this.loanRequestProducts!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}