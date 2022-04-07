import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/multipleCQ_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class QuestionController extends GetxController {
  // List<dynamic> ans = [].obs;
  getList() => questionList.obs;
  dynamic selectedAns;
  getSelectedAns() => selectedAns.obs;
  var index = 0.obs;
  var lang = ''.obs;
  late Color _color;
  Color _selected = Colors.green;
  Color _unSelected = Colors.transparent;
  late int questions;
  dynamic selectedVal = 5.obs;

  void assign(val) {
    selectedVal = val;
    update();
  }

  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  addAns(val) {
    // selectedAns.add(val);
    update();
  }

  next() {
    index++;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _color = _unSelected;
    questions = questionList[0].questions!.length;
  }

  @override
  void onClose() {
    stopWatchTimer.dispose();
    super.onClose();
  }

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(60),
  );

  void startTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void resetTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  final List<QuizPaperModel> questionList = [
    QuizPaperModel(
        questionsCount: 3,
        questions: [
          Question(
            id: "id1",
            question: "https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2020/09/sachin-tendulkar-1600928111.jpg",
            answers: [
              Answer(identifier: "0", answer: "10887"),
              Answer(identifier: "1", answer: "9383"),
              Answer(identifier: "2", answer: "13288"),
              Answer(identifier: "3", answer: "7065")
            ],
            correctAnswer: "1",
            // selectedAnswer: getSelectedAns(),
          ),
          Question(
            id: "id2",
            question: "https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2020/09/sachin-tendulkar-1600928111.jpg",
            answers: [
              Answer(identifier: "0", answer: "https://i.pinimg.com/236x/38/cf/b2/38cfb29f8fa42a7cbf7deba565c4e25c--sachin-tendulkar-the-class.jpg"),
              Answer(identifier: "1", answer: "https://i.pinimg.com/originals/21/c1/55/21c155e87f0f0b54cae08034cfc22f03.jpg"),
              Answer(identifier: "2", answer: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk6ZJMJStgmv2LgreDgMdrdjwa4v9iqLpf0GP5MaUY8mQowA7Rqhyd0zSMxVJLHQuZAhA&usqp=CAU"),
              Answer(identifier: "3", answer: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwRSkKM_mzigUx_hQwWvxVwjesXwjQfbitWwJcyJ77LDim8WyqDqw17Au-rItWCOE228M&usqp=CAU")
            ],
            correctAnswer: "2",
            selectedAnswer: null,
          ),
          Question(
            id: "id3",
            question:
                "Which player played most balls in test cricket and how many balls?",
            answers: [
              Answer(identifier: "0", answer: "Sachin Tendulkar, 30000 balls"),
              Answer(identifier: "1", answer: "Rahul Dravid, 31,027"),
              Answer(identifier: "2", answer: "ricky Ponting, 27000"),
              Answer(identifier: "3", answer: "Brain Lara, 35000")
            ],
            correctAnswer: "3",
            selectedAnswer: null,
          ),
        ],
        id: '1',
        title: 'General English')
  ];
  final List<QuizPaperModel> questionListTamil = [
    QuizPaperModel(
        questionsCount: 3,
        questions: [
          Question(
            id: "id1",
            question: "ராகுல் டிராவிட்டின் மொத்த டெஸ்ட் ஸ்கோர்",
            answers: [
              Answer(identifier: "0", answer: "10887"),
              Answer(identifier: "1", answer: "9383"),
              Answer(identifier: "2", answer: "13288"),
              Answer(identifier: "3", answer: "7065")
            ],
            correctAnswer: "1",
            // selectedAnswer: getSelectedAns(),
          ),
          Question(
            id: "id2",
            question: "சச்சின் டெண்டுல்கரின் முதல் ஒருநாள் போட்டியின் ரன்கள்",
            answers: [
              Answer(identifier: "0", answer: "10"),
              Answer(identifier: "1", answer: "00"),
              Answer(identifier: "2", answer: "40"),
              Answer(identifier: "3", answer: "105")
            ],
            correctAnswer: "3",
            selectedAnswer: null,
          ),
          Question(
            id: "id3",
            question:
                "டெஸ்ட் கிரிக்கெட்டில் எந்த வீரர் அதிக பந்துகளை விளையாடினார், எத்தனை பந்துகளில் விளையாடினார்?",
            answers: [
              Answer(identifier: "0", answer: "சச்சின் டெண்டுல்கரி, 30000"),
              Answer(identifier: "1", answer: "ராகுல் டிராவிட், 31,027"),
              Answer(identifier: "2", answer: "ரிக்கி பாண்டிங், 27000"),
              Answer(identifier: "3", answer: "பிரையன் லாரா, 35000")
            ],
            correctAnswer: "4",
            selectedAnswer: null,
          ),
        ],
        id: '1',
        title: 'General English')
  ];
}
