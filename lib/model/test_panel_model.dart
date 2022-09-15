import 'package:flutter/material.dart';

class TestPanelModel {
  bool? status;
  String? message;
  String? instruction;
  String? title;
  String? totalTime;
  int? answered;
  int? unanswered;
  List<QuestionCollections>? questionCollections;

  TestPanelModel(
      {this.status,
        this.message,
        this.instruction,
        this.title,
        this.totalTime,
        this.answered,
        this.unanswered,
        this.questionCollections});

  TestPanelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    instruction = json['instruction'];
    title = json['title'];
    totalTime = json['total_time'];
    answered = json['answered'];
    unanswered = json['unanswered'];
    if (json['question_collections'] != null) {
      questionCollections = <QuestionCollections>[];
      json['question_collections'].forEach((v) {
        questionCollections!.add(new QuestionCollections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['instruction'] = this.instruction;
    data['title'] = this.title;
    data['total_time'] = this.totalTime;
    data['answered'] = this.answered;
    data['unanswered'] = this.unanswered;
    if (this.questionCollections != null) {
      data['question_collections'] =
          this.questionCollections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionCollections {
  int? id;
  int? testId;
  String? testTitle;
  String? testTime;
  String? packageId;
  String? questionType;
  dynamic answeredType;
  String? userAnswer;
  String? lang1Question;
  String? lang2Question;
  String? lang1OptionA;
  String? lang1OptionB;
  String? lang1OptionC;
  String? lang1OptionD;
  String? lang1OptionE;
  String? lang1OptionP;
  String? lang1OptionQ;
  String? lang1OptionR;
  String? lang1OptionS;
  String? lang1OptionT;
  String? lang2OptionA;
  String? lang2OptionB;
  String? lang2OptionC;
  String? lang2OptionD;
  String? lang2OptionE;
  String? lang2OptionP;
  String? lang2OptionQ;
  String? lang2OptionR;
  String? lang2OptionS;
  String? lang2OptionT;
  String? lang1QuestionImage;
  String? lang2QuestionImage;
  String? lang1OptionAImage;
  String? lang1OptionBImage;
  String? lang1OptionCImage;
  String? lang1OptionDImage;
  String? lang1OptionEImage;
  String? lang2OptionAImage;
  String? lang2OptionBImage;
  String? lang2OptionCImage;
  String? lang2OptionDImage;
  String? lang2OptionEImage;
  String? lang1AnswerA;
  String? lang1AnswerB;
  String? lang1AnswerC;
  String? lang1AnswerD;
  String? lang1AnswerE;
  String? lang2AnswerA;
  String? lang2AnswerB;
  String? lang2AnswerC;
  String? lang2AnswerD;
  String? lang2AnswerE;
  String? answer;
  String? mark;
  int? status;

  QuestionCollections(
      {this.id,
        this.testId,
        this.testTitle,
        this.testTime,
        this.packageId,
        this.questionType,
        this.answeredType,
        this.userAnswer,
        this.lang1Question,
        this.lang2Question,
        this.lang1OptionA,
        this.lang1OptionB,
        this.lang1OptionC,
        this.lang1OptionD,
        this.lang1OptionE,
        this.lang1OptionP,
        this.lang1OptionQ,
        this.lang1OptionR,
        this.lang1OptionS,
        this.lang1OptionT,
        this.lang2OptionA,
        this.lang2OptionB,
        this.lang2OptionC,
        this.lang2OptionD,
        this.lang2OptionE,
        this.lang2OptionP,
        this.lang2OptionQ,
        this.lang2OptionR,
        this.lang2OptionS,
        this.lang2OptionT,
        this.lang1QuestionImage,
        this.lang2QuestionImage,
        this.lang1OptionAImage,
        this.lang1OptionBImage,
        this.lang1OptionCImage,
        this.lang1OptionDImage,
        this.lang1OptionEImage,
        this.lang2OptionAImage,
        this.lang2OptionBImage,
        this.lang2OptionCImage,
        this.lang2OptionDImage,
        this.lang2OptionEImage,
        this.lang1AnswerA,
        this.lang1AnswerB,
        this.lang1AnswerC,
        this.lang1AnswerD,
        this.lang1AnswerE,
        this.lang2AnswerA,
        this.lang2AnswerB,
        this.lang2AnswerC,
        this.lang2AnswerD,
        this.lang2AnswerE,
        this.answer,
        this.mark,
        this.status
      });

  QuestionCollections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    testTitle = json['test_title'];
    testTime = json['test_time'];
    packageId = json['package_id'];
    questionType = json['question_type'];
    answeredType = json['answered_type'];
    userAnswer = json['user_answer'];
    lang1Question = json['lang1_question'];
    lang2Question = json['lang2_question'];
    lang1OptionA = json['lang1_optionA'];
    lang1OptionB = json['lang1_optionB'];
    lang1OptionC = json['lang1_optionC'];
    lang1OptionD = json['lang1_optionD'];
    lang1OptionE = json['lang1_optionE'];
    lang1OptionP = json['lang1_optionP'];
    lang1OptionQ = json['lang1_optionQ'];
    lang1OptionR = json['lang1_optionR'];
    lang1OptionS = json['lang1_optionS'];
    lang1OptionT = json['lang1_optionT'];
    lang2OptionA = json['lang2_optionA'];
    lang2OptionB = json['lang2_optionB'];
    lang2OptionC = json['lang2_optionC'];
    lang2OptionD = json['lang2_optionD'];
    lang2OptionE = json['lang2_optionE'];
    lang2OptionP = json['lang2_optionP'];
    lang2OptionQ = json['lang2_optionQ'];
    lang2OptionR = json['lang2_optionR'];
    lang2OptionS = json['lang2_optionS'];
    lang2OptionT = json['lang2_optionT'];
    lang1QuestionImage = json['lang1_question_image'];
    lang2QuestionImage = json['lang2_question_image'];
    lang1OptionAImage = json['lang1_optionA_image'];
    lang1OptionBImage = json['lang1_optionB_image'];
    lang1OptionCImage = json['lang1_optionC_image'];
    lang1OptionDImage = json['lang1_optionD_image'];
    lang1OptionEImage = json['lang1_optionE_image'];
    lang2OptionAImage = json['lang2_optionA_image'];
    lang2OptionBImage = json['lang2_optionB_image'];
    lang2OptionCImage = json['lang2_optionC_image'];
    lang2OptionDImage = json['lang2_optionD_image'];
    lang2OptionEImage = json['lang2_optionE_image'];
    lang1AnswerA = json['lang1_answerA'];
    lang1AnswerB = json['lang1_answerB'];
    lang1AnswerC = json['lang1_answerC'];
    lang1AnswerD = json['lang1_answerD'];
    lang1AnswerE = json['lang1_answerE'];
    lang2AnswerA = json['lang2_answerA'];
    lang2AnswerB = json['lang2_answerB'];
    lang2AnswerC = json['lang2_answerC'];
    lang2AnswerD = json['lang2_answerD'];
    lang2AnswerE = json['lang2_answerE'];
    answer = json['answer'];
    mark = json['mark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['test_title'] = this.testTitle;
    data['test_time'] = this.testTime;
    data['package_id'] = this.packageId;
    data['question_type'] = this.questionType;
    data['answered_type'] = this.answeredType;
    data['user_answer'] = this.userAnswer;
    data['lang1_question'] = this.lang1Question;
    data['lang2_question'] = this.lang2Question;
    data['lang1_optionA'] = this.lang1OptionA;
    data['lang1_optionB'] = this.lang1OptionB;
    data['lang1_optionC'] = this.lang1OptionC;
    data['lang1_optionD'] = this.lang1OptionD;
    data['lang1_optionE'] = this.lang1OptionE;
    data['lang1_optionP'] = this.lang1OptionP;
    data['lang1_optionQ'] = this.lang1OptionQ;
    data['lang1_optionR'] = this.lang1OptionR;
    data['lang1_optionS'] = this.lang1OptionS;
    data['lang1_optionT'] = this.lang1OptionT;
    data['lang2_optionA'] = this.lang2OptionA;
    data['lang2_optionB'] = this.lang2OptionB;
    data['lang2_optionC'] = this.lang2OptionC;
    data['lang2_optionD'] = this.lang2OptionD;
    data['lang2_optionE'] = this.lang2OptionE;
    data['lang2_optionP'] = this.lang2OptionP;
    data['lang2_optionQ'] = this.lang2OptionQ;
    data['lang2_optionR'] = this.lang2OptionR;
    data['lang2_optionS'] = this.lang2OptionS;
    data['lang2_optionT'] = this.lang2OptionT;
    data['lang1_question_image'] = this.lang1QuestionImage;
    data['lang2_question_image'] = this.lang2QuestionImage;
    data['lang1_optionA_image'] = this.lang1OptionAImage;
    data['lang1_optionB_image'] = this.lang1OptionBImage;
    data['lang1_optionC_image'] = this.lang1OptionCImage;
    data['lang1_optionD_image'] = this.lang1OptionDImage;
    data['lang1_optionE_image'] = this.lang1OptionEImage;
    data['lang2_optionA_image'] = this.lang2OptionAImage;
    data['lang2_optionB_image'] = this.lang2OptionBImage;
    data['lang2_optionC_image'] = this.lang2OptionCImage;
    data['lang2_optionD_image'] = this.lang2OptionDImage;
    data['lang2_optionE_image'] = this.lang2OptionEImage;
    data['lang1_answerA'] = this.lang1AnswerA;
    data['lang1_answerB'] = this.lang1AnswerB;
    data['lang1_answerC'] = this.lang1AnswerC;
    data['lang1_answerD'] = this.lang1AnswerD;
    data['lang1_answerE'] = this.lang1AnswerE;
    data['lang2_answerA'] = this.lang2AnswerA;
    data['lang2_answerB'] = this.lang2AnswerB;
    data['lang2_answerC'] = this.lang2AnswerC;
    data['lang2_answerD'] = this.lang2AnswerD;
    data['lang2_answerE'] = this.lang2AnswerE;
    data['answer'] = this.answer;
    data['mark'] = this.mark;
    data['status'] = this.status;
    return data;
  }
}