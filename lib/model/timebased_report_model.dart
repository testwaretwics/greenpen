class TimeBasedReportModel {
  bool? status;
  String? message;
  Result? result;

  TimeBasedReportModel({this.status, this.message, this.result});

  TimeBasedReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<String>? questionFilter;
  List<String>? subject;
  List<Timesheet>? timesheet;
  List<int>? question;

  Result({this.questionFilter, this.subject, this.timesheet, this.question});

  Result.fromJson(Map<String, dynamic> json) {
    questionFilter = json['question_filter'].cast<String>();
    subject = json['subject'].cast<String>();
    if (json['timesheet'] != null) {
      timesheet = <Timesheet>[];
      json['timesheet'].forEach((v) {
        timesheet!.add(new Timesheet.fromJson(v));
      });
    }
    question = json['question'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_filter'] = this.questionFilter;
    data['subject'] = this.subject;
    if (this.timesheet != null) {
      data['timesheet'] = this.timesheet!.map((v) => v.toJson()).toList();
    }
    data['question'] = this.question;
    return data;
  }
}

class Timesheet {
  String? answerEvaluation;
  String? answer;
  String? answeredTime;

  Timesheet({this.answerEvaluation, this.answer, this.answeredTime});

  Timesheet.fromJson(Map<String, dynamic> json) {
    answerEvaluation = json['answer_evaluation'];
    answer = json['answer'];
    answeredTime = json['answered_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_evaluation'] = this.answerEvaluation;
    data['answer'] = this.answer;
    data['answered_time'] = this.answeredTime;
    return data;
  }
}