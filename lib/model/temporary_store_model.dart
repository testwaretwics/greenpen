class TemporaryStoreModel {
  bool? status;
  String? message;
  int? answeredCount;
  int? unansweredCount;

  TemporaryStoreModel(
      {this.status, this.message, this.answeredCount, this.unansweredCount});

  TemporaryStoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    answeredCount = json['answered_count'];
    unansweredCount = json['unanswered_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['answered_count'] = answeredCount;
    data['unanswered_count'] = unansweredCount;
    return data;
  }
}
