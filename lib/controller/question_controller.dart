import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/test_instructions_controller.dart';
import 'package:green_pen/model/multipleCQ_model.dart';
import 'package:green_pen/model/test_panel_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class QuestionController extends GetxController {
  // List<dynamic> ans = [].obs;
  var testInstructionsController = Get.put(TestInstructionsController());
  var questionCollectionDataList = List<QuestionCollections>.empty(growable: true).obs;
  var instruction = ''.obs;
  var title = ''.obs;
  var total_time = ''.obs;
  var answered = ''.obs;
  var unanswered = ''.obs;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  getList() => questionList.obs;
  dynamic selectedAns;
  var selectedAnswer = ''.obs;
  getSelectedAns() => selectedAns.obs;
  var index = 0.obs;
  var scrollIndex = 0.obs;
  var lang = ''.obs;
  late Color _color;
  Color _selected = Colors.green;
  Color _unSelected = Colors.transparent;
  late int questions;
  dynamic selectedVal = 5;
  var isLoading = false.obs;
  var optionList = ["A","B","C","D"];
  var matchOptionList = ["A","B","C","D","E"];
  var choiceOptionList = ["A","B","C","D","E"];
  var selectedIndex = 0;
  var scrollIndexPosition = 0;
  String choiceLanguage = '';

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
  scrollTo(index){
    itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }
  scrollForward(){
    itemScrollController.scrollTo(
        index: scrollIndex.toInt(),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  void onInit() {
    //getTestPanelData();
    super.onInit();
    questionCollectionDataList.addAll(testInstructionsController.questionCollectionDataList);
    title = testInstructionsController.title;
    total_time = testInstructionsController.total_time;
    answered = testInstructionsController.answered;
    unanswered = testInstructionsController.unanswered;
    _color = _unSelected;
    questions = questionList[0].questions!.length;
    print("answered.value : ${answered.value}");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => itemScrollController.scrollTo(index: int.parse(answered.value), duration: Duration(seconds: 1)));
    scrollIndexPosition = int.parse(answered.value);
    selectedIndex = int.parse(answered.value);
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
          Question(
            id: "id4",
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
            id: "id5",
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
            id: "id6",
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
          Question(
            id: "id7",
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
            id: "id8",
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
            id: "id9",
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


  Future<void> apiCallingMethod(int? testId, String? packageId) async {
    await permanentStoreApiData(testId,packageId);
  }

  Future<void> permanentStoreApiData(int? testId, String? packageId) async {
    Map<String, dynamic> input = {
      'test_id': testId,
      'user_id': Preferences.getIntValuesSF(Preferences.USER_ID),
      'package_id': packageId,
    };
    isLoading.value = true;
    await APIProvider().permanentStoreAPI(
      params: input,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          Get.offAndToNamed(ROUTE_TEST_REPORT,arguments: [data.result!.resultId,true]);
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }

  Future<void> temporaryStoreApiData(int? testId, String? packageId, int? id, String? answer, selectedAns, String totalTime, String? testTime, answeredType) async {
    Map<String, dynamic> input = {
      'package_id': packageId,
      'test_id': testId,
      'ques_id': id,
      'correct_answer': answer,
      'user_ans_id': selectedAns,
      'answered_time': totalTime,
      'timetaken': testTime,
      'answered_type': answeredType,
    };
    isLoading.value = true;
    await APIProvider().temporaryStoreAPI(
      params: input,
      onSuccess: (data) async {
        print('Response 11 temporaryStoreAPI : ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          //await testPanelApiData(packageId,testId);
          answered.value = data.answeredCount!.toString();
          unanswered.value = data.unansweredCount!.toString();
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => itemScrollController.jumpTo(index: selectedIndex));
          scrollIndexPosition = selectedIndex;
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }


  Future<void> testPanelApiData(String? packageId, int? testId,) async {
    isLoading.value = true;
    questionCollectionDataList.clear();
    await APIProvider().testPanelAPI(
      id: [int.parse(packageId.toString()),testId],
      onSuccess: (data) {
        print('Response 11 testPanelAPI: ${data.status}');
        print('Response 22 : ${data.message}');
        if (data.status!){
          data.questionCollections!.forEach((element) {
            questionCollectionDataList.add(element);
          });
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }

}
