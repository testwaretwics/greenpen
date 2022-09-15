class MarkAnalysisModel {
  bool? status;
  String? message;
  Result? result;

  MarkAnalysisModel({this.status, this.message, this.result});

  MarkAnalysisModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionData>? questionData;

  Result({this.testResult, this.questionData});

  Result.fromJson(Map<String, dynamic> json) {
    testResult = json['test_result'] != null
        ? new TestResult.fromJson(json['test_result'])
        : null;
    if (json['question_data'] != null) {
      questionData = <QuestionData>[];
      json['question_data'].forEach((v) {
        questionData!.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testResult != null) {
      data['test_result'] = this.testResult!.toJson();
    }
    if (this.questionData != null) {
      data['question_data'] =
          this.questionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestResult {
  int? id;
  String? testNoQuestion;
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
        this.testNoQuestion,
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
    testNoQuestion = json['test_no_question'];
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
    data['test_no_question'] = this.testNoQuestion;
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

class QuestionData {
  String? queId;
  String? subjectName;
  String? topicName;
  String? question1;
  String? question2;
  String? mark;
  String? difficultyLevel;
  dynamic correctAnswer;
  String? userAnswer;
  int? status;
  String? answerEvaluation;
  String? timetaken;

  QuestionData(
      {this.queId,
        this.subjectName,
        this.topicName,
        this.question1,
        this.question2,
        this.mark,
        this.difficultyLevel,
        this.correctAnswer,
        this.userAnswer,
        this.status,
        this.answerEvaluation,
        this.timetaken});

  QuestionData.fromJson(Map<String, dynamic> json) {
    queId = json['queId'];
    subjectName = json['subjectName'];
    topicName = json['topicName'];
    question1 = json['question1'];
    question2 = json['question2'];
    mark = json['mark'];
    difficultyLevel = json['difficultyLevel'];
    correctAnswer = json['correctAnswer'];
    userAnswer = json['userAnswer'];
    status = json['status'];
    answerEvaluation = json['answerEvaluation'];
    timetaken = json['timetaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queId'] = this.queId;
    data['subjectName'] = this.subjectName;
    data['topicName'] = this.topicName;
    data['question1'] = this.question1;
    data['question2'] = this.question2;
    data['mark'] = this.mark;
    data['difficultyLevel'] = this.difficultyLevel;
    data['correctAnswer'] = this.correctAnswer;
    data['userAnswer'] = this.userAnswer;
    data['status'] = this.status;
    data['answerEvaluation'] = this.answerEvaluation;
    data['timetaken'] = this.timetaken;
    return data;
  }
}