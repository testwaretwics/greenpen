class PermanentStoreModel {
  bool? status;
  String? message;
  Result? result;

  PermanentStoreModel({this.status, this.message, this.result});

  PermanentStoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? resultId;

  Result({this.resultId});

  Result.fromJson(Map<String, dynamic> json) {
    resultId = json['result_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_id'] = resultId;
    return data;
  }
}