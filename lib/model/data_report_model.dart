class DataReportModel {
  bool? status;
  String? message;
  Result? result;

  DataReportModel({this.status, this.message, this.result});

  DataReportModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? percentage;
  num? mark;
  String? totalMark;
  String? negativeMarks;
  String? rightansMarks;
  String? wrongansMarks;
  String? skippedMarks;
  String? rank;
  List<SubjectWiseReport>? subjectWiseReport;

  Result(
      {this.id,
        this.percentage,
        this.mark,
        this.totalMark,
        this.negativeMarks,
        this.rightansMarks,
        this.wrongansMarks,
        this.skippedMarks,
        this.rank,
        this.subjectWiseReport});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    percentage = json['percentage'];
    mark = json['mark'];
    totalMark = json['total_mark'];
    negativeMarks = json['negative_marks'];
    rightansMarks = json['rightans_marks'];
    wrongansMarks = json['wrongans_marks'];
    skippedMarks = json['skipped_marks'];
    rank = json['rank'];
    if (json['subjectWiseReport'] != null) {
      subjectWiseReport = <SubjectWiseReport>[];
      json['subjectWiseReport'].forEach((v) {
        subjectWiseReport!.add(new SubjectWiseReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['percentage'] = this.percentage;
    data['mark'] = this.mark;
    data['total_mark'] = this.totalMark;
    data['negative_marks'] = this.negativeMarks;
    data['rightans_marks'] = this.rightansMarks;
    data['wrongans_marks'] = this.wrongansMarks;
    data['skipped_marks'] = this.skippedMarks;
    data['rank'] = this.rank;
    if (this.subjectWiseReport != null) {
      data['subjectWiseReport'] =
          this.subjectWiseReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectWiseReport {
  String? subject;
  int? negativeMarks;
  int? rightAns;
  int? wrongAns;
  int? skippedAns;

  SubjectWiseReport(
      {this.subject,
        this.negativeMarks,
        this.rightAns,
        this.wrongAns,
        this.skippedAns});

  SubjectWiseReport.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    negativeMarks = json['negative_marks'];
    rightAns = json['right_ans'];
    wrongAns = json['wrong_ans'];
    skippedAns = json['skipped_ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['negative_marks'] = this.negativeMarks;
    data['right_ans'] = this.rightAns;
    data['wrong_ans'] = this.wrongAns;
    data['skipped_ans'] = this.skippedAns;
    return data;
  }
}