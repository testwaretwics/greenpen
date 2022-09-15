// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/data_report_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataReports extends StatelessWidget {
  DataReports({Key? key}) : super(key: key);
  final resultController = Get.put(DataReportController());

  TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    resultController.apiCallingMethod();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Reports"),
        backgroundColor: primaryColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: Obx(
          () => resultController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: Text(
                            "Overall Report",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20),
                          child: Container(
                            height: 160,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 160,
                                  width: 160,
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        SfCircularChart(
                                          palette: [
                                            Color(0xff60B687),
                                            Color(0xffE30211),
                                            Color(0xffEB996E),
                                            Color(0xffC7C7C7),
                                          ],
                                          tooltipBehavior: _tooltip,
                                          series: <
                                              CircularSeries<CircularChartData,
                                                  String>>[
                                            DoughnutSeries<CircularChartData,
                                                String>(
                                              radius: "60",
                                              innerRadius: "50",
                                              dataSource: resultController
                                                  .circularChartData,
                                              xValueMapper:
                                                  (CircularChartData data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (CircularChartData data, _) =>
                                                      data.y1,
                                              name: 'Mark',
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          left: 65,
                                          top: 70,
                                          child: Text(
                                            "${resultController.resultData!.percentage.toString()} %",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                    padding: EdgeInsets.only(right: 20),
                                    height: 120,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: <InlineSpan>[
                                              WidgetSpan(
                                                child: Container(
                                                  width: 150,
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    'Total Questions : ',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: GetBuilder<
                                                          DataReportController>(
                                                      builder: (contrtoller) =>
                                                          Text(
                                                            resultController
                                                                .resultData!
                                                                .totalMark
                                                                .toString(),
                                                            //resultController.qstnCount,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: <InlineSpan>[
                                              WidgetSpan(
                                                child: Container(
                                                  width: 150,
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    'Mark Scored : ',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: GetBuilder<
                                                      DataReportController>(
                                                    builder: (contrtoller) =>
                                                        Text(
                                                      resultController
                                                          .resultData!.mark
                                                          .toString(),
                                                      //resultController.markGain,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 150,
                            child: Row(
                              children: [
                                GetBuilder<DataReportController>(
                                    builder: (contrtoller) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            resultWidget(
                                              Color(0xff60B687),
                                              "Correct :",
                                              resultController
                                                  .resultData!.rightansMarks
                                                  .toString(),
                                            ),
                                            resultWidget(
                                              Color(0xffE30211),
                                              "Wrong :",
                                              resultController
                                                  .resultData!.wrongansMarks
                                                  .toString(),
                                            ),
                                            resultWidget(
                                              Color(0xffEB996E),
                                              "Negative :",
                                              resultController
                                                  .resultData!.negativeMarks
                                                  .toString(),
                                            ),
                                            resultWidget(
                                              Color(0xffC7C7C7),
                                              "Unanswered :",
                                              resultController
                                                  .resultData!.skippedMarks
                                                  .toString(),
                                            ),
                                          ],
                                        )),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      child: Center(
                                          child: Image.asset(
                                              "assets/png_file/profileIcon.png",
                                              height: 120))),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: Text(
                            "Subjectwise Report",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    subjectWiseWidget(
                                        Color(0xff60B687), "Correct", 90),
                                    subjectWiseWidget(
                                        Color(0xffE30211), "Wrong", 90),
                                    subjectWiseWidget(
                                        Color(0xffEB996E), "Negative", 100),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: subjectWiseWidget(
                                      Color(0xffC7C7C7), "Unanswered", 110),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            height: 350,
                            child: GetBuilder<DataReportController>(
                                builder: (contrtoller) => SfCartesianChart(
                                      plotAreaBorderColor: Colors.transparent,
                                      primaryYAxis: CategoryAxis(
                                          maximum: double.parse(resultController
                                              .resultData!.totalMark
                                              .toString()),
                                          minimum: 0,
                                          interval: 25,
                                          majorGridLines: MajorGridLines(
                                              color: Colors.transparent),
                                          minorGridLines: MinorGridLines(
                                              color: Colors.transparent),
                                          majorTickLines: MajorTickLines(
                                              color: Colors.transparent),
                                          minorTickLines: MinorTickLines(
                                            color: Colors.transparent,
                                          )),
                                      primaryXAxis: CategoryAxis(
                                          majorGridLines: MajorGridLines(
                                              color: Colors.transparent),
                                          minorGridLines: MinorGridLines(
                                              color: Colors.transparent),
                                          majorTickLines: MajorTickLines(
                                              color: Colors.transparent),
                                          minorTickLines: MinorTickLines(
                                            color: Colors.transparent,
                                          )),
                                      series: <ChartSeries>[
                                        StackedColumnSeries<ChartData, String>(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20)),
                                            color: Color(0xff60B687),
                                            width: 0.15,
                                            groupName: 'Group A',
                                            dataLabelSettings: DataLabelSettings(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                angle: 270,
                                                isVisible: false,
                                                showCumulativeValues: false),
                                            dataSource:
                                                resultController.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y1),
                                        StackedColumnSeries<ChartData, String>(
                                            color: Color(0xffE30211),
                                            width: 0.15,
                                            groupName: 'Group A',
                                            dataLabelSettings: DataLabelSettings(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                angle: 270,
                                                isVisible: false,
                                                showCumulativeValues: false),
                                            dataSource:
                                                resultController.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y2),
                                        StackedColumnSeries<ChartData, String>(
                                            color: Color(0xffE3E3E3),
                                            width: 0.15,
                                            groupName: 'Group A',
                                            dataLabelSettings: DataLabelSettings(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                angle: 270,
                                                isVisible: false,
                                                showCumulativeValues: false),
                                            dataSource:
                                                resultController.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y3),
                                        StackedColumnSeries<ChartData, String>(
                                            color: Color(0xffEB996E),
                                            width: 0.15,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            groupName: 'Group A',
                                            dataLabelSettings: DataLabelSettings(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                angle: 270,
                                                isVisible: false,
                                                showCumulativeValues: false),
                                            dataSource:
                                                resultController.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y4),
                                      ],
                                    )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: Text(
                            "Timebased Report",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                "Topics : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 100,
                                child: GetBuilder<DataReportController>(
                                  builder: (controller) => DropdownButton(
                                    hint: controller.currentSubject == ''
                                        ? Text(
                                            controller.subject[0],
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: TextUtils.commonTextSize,
                                              fontWeight:
                                                  TextUtils.normalTextWeight,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          )
                                        : Text(
                                            controller.currentSubject,
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: TextUtils.commonTextSize,
                                              fontWeight:
                                                  TextUtils.normalTextWeight,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    iconSize: 24,
                                    underline: SizedBox(),
                                    style: TextStyle(color: textColor),
                                    items: controller.subject.map(
                                      (val) {
                                        return DropdownMenuItem(
                                          value: val.toString(),
                                          child: Text(
                                            val.toString(),
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: TextUtils.commonTextSize,
                                              fontWeight:
                                                  TextUtils.titleTextWeight,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      controller.updateSubjectValue(val as String);
                                      controller.update();
                                      controller.getTimeBasedReportApiData();
                                    },
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Q.Nos : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  width: 90,
                                  child: GetBuilder<DataReportController>(
                                    builder: (controller) => DropdownButton(
                                      hint: controller.currentRange == ''
                                          ? Text(
                                              controller.questionFilter[0],
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.normalTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )
                                          : Text(
                                              controller.currentRange,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.normalTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                      isExpanded: true,
                                      icon:
                                          Icon(Icons.keyboard_arrow_down_rounded),
                                      iconSize: 24,
                                      underline: SizedBox(),
                                      style: TextStyle(color: textColor),
                                      items: controller.questionFilter.map(
                                        (val) {
                                          return DropdownMenuItem(
                                            value: val.toString(),
                                            child: Text(
                                              val.toString(),
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.titleTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        controller.updateTimeValue(val as String);
                                        controller.update();
                                        controller.getTimeBasedReportApiData();
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                "Time in mins",
                                style: TextStyle(
                                    color: primaryLightColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  height: 300,
                                  child: GetBuilder<DataReportController>(
                                    builder: (contrtoller) => SfCartesianChart(
                                      plotAreaBorderColor: Colors.transparent,
                                      tooltipBehavior: _tooltip,
                                      palette: resultController.timesheetColor,
                                      onTooltipRender: (TooltipArgs args) {
                                        args.header =
                                            'Question ${args.pointIndex! + 1}';
                                      },
                                      primaryXAxis: CategoryAxis(
                                        labelPlacement: LabelPlacement.onTicks,
                                        title: AxisTitle(
                                          text: "Question Nos",
                                          textStyle:
                                              TextStyle(color: primaryLightColor),
                                        ),
                                      ),
                                      series: <ChartSeries>[
                                        StackedAreaSeries<TimeChartData, String>(
                                            enableTooltip: true,
                                            markerSettings: MarkerSettings(
                                              isVisible: true,
                                              //color: Colors.green,
                                              borderWidth: 5,height: 5,width: 5
                                            ),
                                            color: Color(0xffD2DCFF),
                                            groupName: 'Group A',
                                            dataLabelSettings: DataLabelSettings(
                                                isVisible: false,
                                                useSeriesColor: true),
                                            pointColorMapper:  (TimeChartData data, _) => data.color,
                                            dataSource:
                                                resultController.timeChartData,
                                            xValueMapper:
                                                (TimeChartData data, _) => data.x,
                                            yValueMapper:
                                                (TimeChartData data, _) =>
                                                    data.y),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  dynamicColors(){

    for(int i = 0; i < resultController.timesheetData.length; i++){
      if(resultController.timesheetData[i].answerEvaluation=="1"){
        return Colors.green;
      }else if(resultController.timesheetData[i].answerEvaluation=="2"){
        return Colors.red;
      }
    }

    // if(resultController.timesheetData[0].answerEvaluation=="2"){
    //   return Colors.green;
    // }else if(resultController.timesheetData[1].answerEvaluation=="2"){
    //   return Colors.red;
    // }else if(resultController.timesheetData[2].answerEvaluation=="3"){
    // return Colors.grey;
    // }else if(resultController.timesheetData[3].answerEvaluation=="0"){
    //   return Colors.blue;
    // }else if(resultController.timesheetData[4].answerEvaluation=="1"){
    //   return Colors.orange;
    // }

  }

  Text resultWidget(Color color, String title, String mark) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  '⚈',
                  style: TextStyle(color: color, fontSize: 16),
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: Container(
              width: 110,
              padding: EdgeInsets.only(left: 10),
              child: Text(title),
            ),
          ),
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(mark),
            ),
          ),
        ],
      ),
    );
  }

  Text subjectWiseWidget(Color color, String title, double size) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '⚈',
                style: TextStyle(color: color, fontSize: 14),
              ),
            ),
          ),
          WidgetSpan(
            child: Container(
              width: size,
              padding: EdgeInsets.only(left: 10),
              child: Text(title),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.date, this.sales);

  final DateTime date;
  final double sales;
}
