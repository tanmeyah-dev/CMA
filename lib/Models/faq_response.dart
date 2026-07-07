class FAQResponse {
  List<Faqs>? faqs;
  bool? isSuccess;
  String? code;
  Null message;

  FAQResponse({this.faqs, this.isSuccess, this.code, this.message});

  FAQResponse.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (faqs != null) {
      data['faqs'] = faqs!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Faqs {
  String? question;
  String? answer;

  Faqs({this.question, this.answer});

  Faqs.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}