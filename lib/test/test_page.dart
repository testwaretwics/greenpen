import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/question_controller.dart';
import 'package:green_pen/model/multipleCQ_model.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// class QuestionPaper {
//   final int number;
//   final String question;
//   final List answers;
//
//   QuestionPaper(this.number, this.question, this.answers);
// }
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _controller = Get.put(QuestionController());
  late var questions;
  var index = 0;
  String lang = '';

  void initState() {
    super.initState();
    questions = _controller.questionList[0].questions!.length;
  }

  next() {
    setState(() {
      index++;
    });
  }

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond:
        StopWatchTimer.getMilliSecFromMinute(1), // millisecond => minute.
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 160),
        child: Container(
          padding: EdgeInsets.all(15),
          color: secondaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "GR- II & IIA Prelims General Studies",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "+ English",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.timer, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Time Left :",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "60:00:00",
                      style: TextStyle(fontSize: 18, color: Color(0xffF97171)),
                    ),
                    Spacer(),
                    Icon(
                      Icons.info_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xff296ACC),
                      ),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Mark for View & Next",
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (index < questions - 1)
                      next();
                    else {
                      Get.defaultDialog(
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        title: "Do you want to End the test ?",
                        content: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elit sed sit dui amet aliquam id. Rhoncus sit tempor sed sed felis. Quisque in bibendum et at. Eu in dapibus vitae mattis arcu. "),
                        actions: [
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xff296ACC),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xff296ACC),
                              ),
                            ),
                            child: FlatButton(
                              color: secondaryColor,
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "End Test",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff296ACC),
                      border: Border.all(
                        color: Color(0xff296ACC),
                      ),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Save & Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "Subject name - 20 Questions",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                lang = "english";
                              },
                            );
                          },
                          icon: Text(
                            "A",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Visibility(visible: lang == '' || lang == 'english'?true:false,
                          child: Positioned(
                              bottom:8.0,
                              right: 15,
                              child: Container(height:4,width: 20,color:Colors.blue),),
                        ),
                      ],
                    ),
                    Icon(Icons.compare_arrows_rounded),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                lang = "tamil";
                              },
                            );
                          },
                          icon: Text(
                            "அ",
                            style:TextStyle(fontSize: 24),
                          ),
                        ),
                        Visibility(visible: lang == '' || lang == 'english'?false:true,
                          child: Positioned(
                            bottom:8.0,
                            right: 15,
                            child: Container(height:4,width: 20,color:Colors.blue),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: QuestionWidget(
                  question: lang == '' || lang == 'english'
                      ? _controller.questionList[0].questions![index]
                      : _controller.questionListTamil[0].questions![index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  var val;
  late Color _color;
  Color _selected = Colors.green;
  Color _unSelected = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = _unSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${widget.question.id} of 200",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "⚈  Mark 5",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff1CBBA3)),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Clear Response",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xffCC2929)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.question.question,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: widget.question.answers.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          toggleable: true,
                          value: index,
                          title: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: val == index
                                          ? _selected
                                          : _unSelected)),
                              child:
                                  Text(widget.question.answers[index].answer!)),
                          groupValue: val,
                          onChanged: (value) {
                            setState(
                              () {
                                val = value;
                                // val== index? _color = _selected:_color = _unSelected;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
