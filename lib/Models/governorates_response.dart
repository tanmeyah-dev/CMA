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
        governorates!.add(Governorates.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (governorates != null) {
      data['governorates'] = governorates!.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = isSuccess;
    data['code'] = code;
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return 'Governorates{id: $id, name: $name}';
  }
}