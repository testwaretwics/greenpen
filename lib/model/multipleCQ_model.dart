import 'dart:convert';
import 'package:get/get.dart';

class QuizPaperModel {
  final String id;
  final String title;
  // String? imageUrl;
  // Rxn<String?>? url;
  // final String description;
  // final int timeSeconds;
  List<Question>? questions;
  final int questionsCount;

  QuizPaperModel({
    required this.id,
    required this.title,
    // this.imageUrl,
    // required this.description,
    // required this.timeSeconds,
    required this.questions,
    required this.questionsCount,
  });

  // String timeInMinits() => "${(timeSeconds / 60).ceil()} mins";

  factory QuizPaperModel.fromString(String jsonString) =>
      QuizPaperModel.fromJson(json.decode(jsonString));

  QuizPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] as String,
        // imageUrl = json['image_url'] as String?,
        // description = json['Description'] as String,
        // timeSeconds = json['time_seconds'] as int,
        questionsCount = 0,

        /// will be update in PapersDataUploader
        questions = json['questions'] == null
            ? []
            : (json['questions'] as List)
                .map(
                    (dynamic e) => Question.fromJson(e as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        // 'image_url': imageUrl,
        // 'Description': description,
        // 'time_seconds': timeSeconds,
        // 'questions':
        //     questions == null ? [] : questions!.map((e) => e.toJson()).toList()
      };
}

class Question {
  final String id;
  final String question;
  List<Answer> answers;
  final String? correctAnswer;
  String? selectedAnswer;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
    this.selectedAnswer,
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        question = json['question'] as String,
        answers =
            (json['answers'] as List).map((e) => Answer.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'] as String?,
        selectedAnswer = json['selected_answer'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        //'answers' : answers.toJson(),
        'correct_answer': correctAnswer,
        'selected_answer': selectedAnswer
      };
}

class Answer {
  final String? identifier;
  final String? answer;

  Answer({
    this.identifier,
    this.answer,
  });

  Answer.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        answer = json['Answer'] as String?;

  Map<String, dynamic> toJson() => {'identifier': identifier, 'Answer': answer};
}
