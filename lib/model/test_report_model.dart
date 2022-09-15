class TestReportModel {
  bool? status;
  String? message;
  Result? result;

  TestReportModel({this.status, this.message, this.result});

  TestReportModel.fromJson(Map<String, dynamic> json) {
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
  TestResult? testResult;

  Result({this.testResult});

  Result.fromJson(Map<String, dynamic> json) {
    testResult = json['test_result'] != null
        ? new TestResult.fromJson(json['test_result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testResult != null) {
      data['test_result'] = this.testResult!.toJson();
    }
    return data;
  }
}

class TestResult {
  int? id;
  String? category;
  String? packageNameLang1;
  String? testTitle;
  String? packageType;
  String? noOfTest;
  String? languages;
  String? examType;
  String? testNoQuestion;
  String? testDate;
  String? testTime;
  String? mcqPermanentAnsId;
  String? totalMark;
  String? negativeMarks;
  String? userRightansMarks;
  String? userWrongansMarks;
  String? userSkippedMarks;
  String? userNegativeMarks;
  String? userTotalMarks;
  String? userRank;
  String? createdAt;

  TestResult(
      {this.id,
        this.category,
        this.packageNameLang1,
        this.testTitle,
        this.packageType,
        this.noOfTest,
        this.languages,
        this.examType,
        this.testNoQuestion,
        this.testDate,
        this.testTime,
        this.mcqPermanentAnsId,
        this.totalMark,
        this.negativeMarks,
        this.userRightansMarks,
        this.userWrongansMarks,
        this.userSkippedMarks,
        this.userNegativeMarks,
        this.userTotalMarks,
        this.userRank,
        this.createdAt});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    packageNameLang1 = json['package_name_lang1'];
    testTitle = json['test_title'];
    packageType = json['package_type'];
    noOfTest = json['no_of_test'];
    languages = json['languages'];
    examType = json['exam_type'];
    testNoQuestion = json['test_no_question'];
    testDate = json['test_date'];
    testTime = json['test_time'];
    mcqPermanentAnsId = json['mcq_permanent_ans_id'];
    totalMark = json['total_mark'];
    negativeMarks = json['negative_marks'];
    userRightansMarks = json['user_rightans_marks'];
    userWrongansMarks = json['user_wrongans_marks'];
    userSkippedMarks = json['user_skipped_marks'];
    userNegativeMarks = json['user_negative_marks'];
    userTotalMarks = json['user_total_marks'];
    userRank = json['user_rank'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['package_name_lang1'] = this.packageNameLang1;
    data['test_title'] = this.testTitle;
    data['package_type'] = this.packageType;
    data['no_of_test'] = this.noOfTest;
    data['languages'] = this.languages;
    data['exam_type'] = this.examType;
    data['test_no_question'] = this.testNoQuestion;
    data['test_date'] = this.testDate;
    data['test_time'] = this.testTime;
    data['mcq_permanent_ans_id'] = this.mcqPermanentAnsId;
    data['total_mark'] = this.totalMark;
    data['negative_marks'] = this.negativeMarks;
    data['user_rightans_marks'] = this.userRightansMarks;
    data['user_wrongans_marks'] = this.userWrongansMarks;
    data['user_skipped_marks'] = this.userSkippedMarks;
    data['user_negative_marks'] = this.userNegativeMarks;
    data['user_total_marks'] = this.userTotalMarks;
    data['user_rank'] = this.userRank;
    data['created_at'] = this.createdAt;
    return data;
  }
}