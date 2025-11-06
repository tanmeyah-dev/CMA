class GovernmentResponse {
  List<Governorates>? governorates;
  bool? isSuccess;
  String? code;
  String? message;

  GovernmentResponse(
      {this.governorates, this.isSuccess, this.code, this.message});

  GovernmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['governorates'] != null) {
      governorates = <Governorates>[];
      json['governorates'].forEach((v) {
        governorates!.add(new Governorates.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.governorates != null) {
      data['governorates'] = this.governorates!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Governorates {
  int? id;
  String? name;

  Governorates({this.id, this.name});

  Governorates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return 'Governorates{id: $id, name: $name}';
  }
}