import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/data_report_model.dart' as dataReport;
import 'package:green_pen/model/timebased_report_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataReportController extends GetxController {

  dataReport.Result? resultData;
  var subjectWiseReportDataList = List<dataReport.SubjectWiseReport>.empty(growable: true).obs;
  var timesheetData = List<Timesheet>.empty(growable: true).obs;
  var isLoading = false.obs;
  var id;
  var questionFilter = [];
  var subject = [];
  var timesheetColor = <Color>[];
  var question =[];

  var selctedSubject = ''.obs;
  var selctedQstnNos = ''.obs;
  var totalQstns = ''.obs;
  var markScroed = ''.obs;
  var correctAns = ''.obs;
  var wrongAns = ''.obs;
  var negativeAns = ''.obs;
  var unAnswered = ''.obs;
  var subjectList = ["Tamil", "English", "Science", "Social"].obs;

  var qstnNoList = ["1-10", "10-20", "20-30", "30-40"].obs;

  String get currentSubject => selctedSubject.value;
  String get currentRange => selctedQstnNos.value;
  String get qstnCount => totalQstns.value;
  String get markGain => markScroed.value;
  String get crctAns => correctAns.value;
  String get wrngAns => wrongAns.value;
  String get negAns => negativeAns.value;
  String get unAns => unAnswered.value;

  final List<ChartData> chartData = [
    // ChartData('Tamil', 90, 30, 60, 20),
    // ChartData('English', 14, 11, 18, 23),
    // ChartData('Aptitude', 16, 10, 15, 20),
    // ChartData('Reasoning', 18, 16, 18, 24),
    // ChartData('Science', 55, 30, 18, 33)
  ];

  final List<CircularChartData> circularChartData = [
    // CircularChartData('Correct', 102),
    // CircularChartData('Wrong', 30),
    // CircularChartData('Negative', 22),
    // CircularChartData('Unanswered', 13)
  ];

  final List<TimeChartData> timeChartData = [
    // TimeChartData('Q1', 2),
    // TimeChartData('Q2', 5),
    // TimeChartData('Q3', 3),
    // TimeChartData('Q4', 6),
    // TimeChartData('Q5', 1),
    // TimeChartData('Q6', 5),
    // TimeChartData('Q7', 4),
    // TimeChartData('Q8', 6),
    // TimeChartData('Q9', 7),
    // TimeChartData('Q10', 10),
  ];
  final List<MarkerSettings> markerSettingsData = [
    MarkerSettings(isVisible: true, color: Colors.red),
    MarkerSettings(isVisible: true, color: Colors.green),
    MarkerSettings(isVisible: true, color: Colors.blue),
    MarkerSettings(isVisible: true, color: Colors.yellow),
    MarkerSettings(isVisible: true, color: Colors.orange),
    MarkerSettings(isVisible: true, color: Colors.grey),
    MarkerSettings(isVisible: true, color: Colors.white),
    MarkerSettings(isVisible: true, color: Colors.teal),
    MarkerSettings(isVisible: true, color: Colors.blueGrey),
    MarkerSettings(isVisible: true, color: Colors.black),
  ];

  @override
  Future<void> onInit() async {
    id = Get.arguments;
    print("Start");
    await apiCallingMethod();
    print("End");
    super.onInit();
    totalQstns = '200'.obs;
    markScroed = '185'.obs;
    correctAns = '102'.obs;
    wrongAns = '28'.obs;
    negativeAns = '31'.obs;
    unAnswered = '39'.obs;
    super.onInit();
  }

  @override
  void onClose() {
    // areaTextController.clear();
    // areaTextController.dispose();
    super.onClose();
  }

  Future<void> updateSubjectValue(String value) async {
    selctedSubject = value.obs;
    update();
  }

  Future<void> updateTimeValue(String value) async {
    selctedQstnNos = value.obs;
    update();
  }

  Future<void> apiCallingMethod() async {
    await getDataReportApiData();
    await getTimeBasedReportApiData();
  }

  Future<void> getDataReportApiData() async {
    isLoading.value = true;
    subjectWiseReportDataList.clear();
    chartData.clear();
    circularChartData.clear();
    await APIProvider().dataReportAPI(
      id: id,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status==true){
          resultData = data.result!;

          data.result!.subjectWiseReport!.forEach((element) {
            subjectWiseReportDataList.add(element);
            chartData.add(ChartData(element.subject.toString(), element.rightAns!.toDouble(), element.wrongAns!.toInt(),element.skippedAns!.toInt(), element.negativeMarks!.toInt()));
          });

          circularChartData.add(CircularChartData("Correct", double.parse(resultData!.rightansMarks!)));
          circularChartData.add(CircularChartData("Wrong", double.parse(resultData!.wrongansMarks!)));
          circularChartData.add(CircularChartData("Negative", double.parse(resultData!.negativeMarks!)));
          circularChartData.add(CircularChartData("Unanswered", double.parse(resultData!.skippedMarks!)));

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

  Future<void> getTimeBasedReportApiData() async {
    isLoading.value = true;
    questionFilter.clear();
    subject.clear();
    timesheetData.clear();
    question.clear();
    timeChartData.clear();
    timesheetColor.clear();
    Map<String, dynamic> input = {
      "result_id": id,
      "sortorder": selctedQstnNos.value,
      "subject": selctedSubject.value
    };
    await APIProvider().timeBasedReportAPI(
      id: id,
      params: input,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22 11: ${data.message}');
        if (data.status!) {
          data.result!.questionFilter!.forEach((element) {
            questionFilter.add(element);
          });

          data.result!.subject!.forEach((element) {
            subject.add(element);
          });

          data.result!.timesheet!.forEach((element) {
            timesheetData.add(element);
          });

          data.result!.question!.forEach((element) {
            question.add(element);
          });

          print("Time length : ${timesheetData.length}");
          for(int i = 0;i< timesheetData.length; i++){

            var time = timesheetData[i].answeredTime.toString().split(":");
            var hour = int.parse(time[0]) * 60;
            var sec = int.parse(time[2]) / 60;
            // print("Time : ${time[0]}, ${time[1]}, ${time[2]}");
            // print("hour : ${hour}");
            // print("min : ${time[1]}");
            // print("sec : ${sec}");
            var minute = hour + int.parse(time[1]) + sec;
            print("minute minute : ${minute} - ${hour} - ${time[1]} - $sec");
            print("minute minute : ${question[i].toString()}");

            if(timesheetData[i].answerEvaluation=="0"){
              timesheetColor.add(Color(0xffC7C7C7));
            }else if(timesheetData[i].answerEvaluation=="1"){
              timesheetColor.add(Colors.green);
            }else if(timesheetData[i].answerEvaluation=="2"){
              timesheetColor.add(Colors.red);
            }

            print("Colors : ${timesheetColor.length}");


            timeChartData.add(TimeChartData(question[i].toString(),minute.toInt(),timesheetColor[i]));

             // MarkerSettings(color: Colors.red,isVisible: true);
          }


          // for(int i =0; i< data.result!.question!.length; i++){
          //   timeChartData.add(TimeChartData(timesheet[i],question[i]));
          // }

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

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final double y1;
  final int y2;
  final int y3;
  final int y4;
}

class CircularChartData {
  CircularChartData(this.x, this.y1);
  final String x;
  final double y1;
}

class TimeChartData {
  TimeChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
