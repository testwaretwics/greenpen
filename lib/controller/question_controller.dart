import 'package:get/get.dart';
import 'package:green_pen/model/multipleCQ_model.dart';

class QuestionController extends GetxController {
  // List<dynamic> ans = [].obs;
  getList() => questionList.obs;
  dynamic selectedAns;
  getSelectedAns() => selectedAns.obs;

  addAns(val) {
    selectedAns = val;
    update();
    return selectedAns;
  }

  final List<QuizPaperModel> questionList = [
    QuizPaperModel(
        questionsCount: 3,
        questions: [
          Question(
            id: "id1",
            question: "Rahul Dravid's total Test score was",
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
            question: "Sachin Tendulkar's first Odi score was",
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
                "Which player played most balls in test cricket and how many balls?",
            answers: [
              Answer(identifier: "0", answer: "Sachin Tendulkar, 30000 balls"),
              Answer(identifier: "1", answer: "Rahul Dravid, 31,027"),
              Answer(identifier: "2", answer: "ricky Ponting, 27000"),
              Answer(identifier: "3", answer: "Brain Lara, 35000")
            ],
            correctAnswer: "4",
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
              Answer(
                  identifier: "0", answer: "சச்சின் டெண்டுல்கரி, 30000"),
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
