class AskQuestionModel {
  String? httpStatus;
  dynamic httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  List<AskModelData>? data;

  AskQuestionModel(
      {httpStatus,
      httpStatusCode,
      success,
      message,
      apiName,
      data});

  AskQuestionModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <AskModelData>[];
      json['data'].forEach((v) {
        data!.add( AskModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['httpStatus'] = httpStatus;
    data['httpStatusCode'] = httpStatusCode;
    data['success'] = success;
    data['message'] = message;
    data['apiName'] = apiName;
    if (data != (null)) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AskModelData {
  int? id;
  String? name;
  String? description;
  dynamic price;
  List<String>? suggestions;

  AskModelData(name,{id,  description, price, suggestions});

  AskModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    suggestions = json['suggestions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['suggestions'] = suggestions;
    return data;
  }
}
