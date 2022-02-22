class AskQuestionModel {
  String? httpStatus;
  int? httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  List<AskModelData>? data;

  AskQuestionModel(
      {this.httpStatus,
      this.httpStatusCode,
      this.success,
      this.message,
      this.apiName,
      this.data});

  AskQuestionModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <AskModelData>[];
      json['data'].forEach((v) {
        data!.add(new AskModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpStatus'] = this.httpStatus;
    data['httpStatusCode'] = this.httpStatusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    data['apiName'] = this.apiName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AskModelData {
  int? id;
  String? name;
  String? description;
  int? price;
  List<String>? suggestions;

  AskModelData({this.id, this.name, this.description, this.price, this.suggestions});

  AskModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    suggestions = json['suggestions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['suggestions'] = this.suggestions;
    return data;
  }
}
