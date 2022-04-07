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
  dynamic selectedVal = 5;
  var index = 0;
  String lang = '';
  var val;
  late Color _color;
  Color _selected = Colors.green;
  Color _unSelected = Colors.transparent;

  void initState() {
    super.initState();
    _color = _unSelected;
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    questions = _controller.questionList[0].questions!.length;
  }

  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  next() {
    if (mounted)
      setState(() {
        index++;
      });
  }

  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(60),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 180),
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
                    Column(children:[
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Time Left :",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: 3600,
                          builder: (context, snap) {
                            final value = snap.data;
                            final displayTime = StopWatchTimer.getDisplayTime(
                                value!,
                                milliSecond: false);
                            return Text(
                              displayTime,
                              style: TextStyle(
                                  color: Color(0xffF97171),
                                  fontSize: 18,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                    ),
                    ]),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FlatButton(color: Color(0xff42E784),
                        height: 40,minWidth: 140,
                        onPressed: (){}, child: Text("Submit Test"),textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    )
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
                    if (index < questions - 1) {
                      next();
                      _controller.addAns(selectedVal);
                    } else {
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
                                print(_controller.getSelectedAns(),);
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
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
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Answered - 50",
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Unanswered - 150",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                lang = "english";
                              });
                          },
                          icon: Text(
                            "A",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Visibility(
                          visible:
                              lang == '' || lang == 'english' ? true : false,
                          child: Positioned(
                            bottom: 8.0,
                            right: 15,
                            child: Container(
                                height: 4, width: 20, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.compare_arrows_rounded),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                lang = "tamil";
                              });
                          },
                          icon: Text(
                            "அ",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Visibility(
                          visible:
                              lang == '' || lang == 'english' ? false : true,
                          child: Positioned(
                            bottom: 8.0,
                            right: 15,
                            child: Container(
                                height: 4, width: 20, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     Text("<"),
              //     ListView.builder(itemBuilder: (context, index){return Container();},itemCount: ,),
              //     Text(">"),
              //   ],
              // ),
              Container(
                child: qstnWidget(
                    lang == '' || lang == 'english'
                        ? _controller.questionList[0].questions![index]
                        : _controller.questionListTamil[0].questions![index],
                    selectedVal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container qstnWidget(dynamic qstn, dynamic selectedVal) {
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
                    Row(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Color(0xffF2D925),
                          size: 24,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Question ${qstn.id} of 200",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0,left: 40),
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
                        color: Color(0xffCC2929),),
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
                  child:
                  qstn.id != "id2"?Text(
                    qstn.question,
                    style: TextStyle(fontSize: 16),
                  ): Image.network(qstn.question,height: 200,width:200,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: qstn.answers.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          toggleable: true,
                          value: index,
                          title: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: selectedVal == index
                                          ? _selected
                                          : _unSelected),),
                              child: qstn.id != "id2"? Text(qstn.answers[index].answer):Image.network(qstn.answers[index].answer)),
                          groupValue: selectedVal,
                          onChanged: (value) {
                            // if (mounted)
                            setState(
                              () {
                                selectedVal = value;
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


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:green_pen/controller/question_controller.dart';
// import 'package:green_pen/model/multipleCQ_model.dart';
// import 'package:green_pen/utils/custColors.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';

// class TestPage extends StatelessWidget {
//   final _controller = Get.put(QuestionController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, 160),
//         child: Container(
//           padding: EdgeInsets.all(15),
//           color: secondaryColor,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 50.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "GR- II & IIA Prelims General Studies",
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                         Spacer(),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "+ English",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Icon(Icons.timer, color: Colors.white),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Time Left :",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Obx(
//                       () => StreamBuilder<int>(
//                         stream: _controller.stopWatchTimer.rawTime,
//                         initialData: 3600,
//                         builder: (context, snap) {
//                           final value = snap.data;
//                           final displayTime = StopWatchTimer.getDisplayTime(
//                               value!,
//                               milliSecond: false);
//                           return Text(
//                             displayTime,
//                             style: TextStyle(
//                                 color: Color(0xffF97171),
//                                 fontSize: 18,
//                                 fontFamily: 'Helvetica',
//                                 fontWeight: FontWeight.bold),
//                           );
//                         },
//                       ),
//                     ),
//                     Spacer(),
//                     Icon(
//                       Icons.info_rounded,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       bottomSheet: Container(
//         height: 70,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: Color(0xff296ACC),
//                       ),
//                     ),
//                     height: 40,
//                     child: Center(
//                       child: Text(
//                         "Mark for View & Next",
//                         style: TextStyle(color: secondaryColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Obx(
//                 () => Expanded(
//                   flex: 1,
//                   child: InkWell(
//                     onTap: () {
//                       if (_controller.index < _controller.questions - 1) {
//                         // next();
//                         _controller.addAns(_controller.selectedVal);
//                       } else {
//                         Get.defaultDialog(
//                           contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//                           title: "Do you want to End the test ?",
//                           content: Text(
//                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elit sed sit dui amet aliquam id. Rhoncus sit tempor sed sed felis. Quisque in bibendum et at. Eu in dapibus vitae mattis arcu. "),
//                           actions: [
//                             Container(
//                               height: 40,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(
//                                   color: Color(0xff296ACC),
//                                 ),
//                               ),
//                               child: FlatButton(
//                                 onPressed: () {
//                                   Get.back();
//                                 },
//                                 child: Text(
//                                   "Cancel",
//                                   style: TextStyle(color: secondaryColor),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 40,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(
//                                   color: Color(0xff296ACC),
//                                 ),
//                               ),
//                               child: FlatButton(
//                                 color: secondaryColor,
//                                 onPressed: () {
//                                   Get.back();
//                                   print(_controller.getSelectedAns());
//                                   _controller.stopTimer();
//                                 },
//                                 child: Text(
//                                   "End Test",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xff296ACC),
//                         border: Border.all(
//                           color: Color(0xff296ACC),
//                         ),
//                       ),
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           "Save & Next",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Obx(
//                 () => Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Subject name - 20 Questions",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       Spacer(),
//                       Stack(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               // if (mounted)
//                               //   setState(() {
//                               _controller.lang = "english" as RxString;
//                               // });
//                             },
//                             icon: Text(
//                               "A",
//                               style: TextStyle(fontSize: 24),
//                             ),
//                           ),
//                           Visibility(
//                             visible: _controller.lang == '' as RxString ||
//                                     _controller.lang == 'english' as RxString
//                                 ? true
//                                 : false,
//                             child: Positioned(
//                               bottom: 8.0,
//                               right: 15,
//                               child: Container(
//                                   height: 4, width: 20, color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Icon(Icons.compare_arrows_rounded),
//                       Stack(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               // if (mounted)
//                               //   setState(() {
//                               _controller.lang = "tamil" as RxString;
//                               // });
//                             },
//                             icon: Text(
//                               "அ",
//                               style: TextStyle(fontSize: 24),
//                             ),
//                           ),
//                           Visibility(
//                             visible: _controller.lang == '' as RxString ||
//                                     _controller.lang == 'english' as RxString
//                                 ? false
//                                 : true,
//                             child: Positioned(
//                               bottom: 8.0,
//                               right: 15,
//                               child: Container(
//                                   height: 4, width: 20, color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Obx(
//                 () => Container(
//                   child: qstnWidget(_controller.lang == '' as RxString ||
//                           _controller.lang == 'english' as RxString
//                       ? _controller
//                           .questionList[0].questions![_controller.index.toInt()]
//                       : _controller.questionListTamil[0]
//                           .questions![_controller.index.toInt()]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Container qstnWidget(dynamic qstn) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Question ${qstn.id} of 200",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5.0),
//                       child: Text(
//                         "⚈  Mark 5",
//                         style:
//                             TextStyle(fontSize: 16, color: Color(0xff1CBBA3)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     "Clear Response",
//                     style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xffCC2929)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     qstn.question,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: 300,
//                     child: ListView.builder(
//                       itemCount: qstn.answers.length,
//                       itemBuilder: (context, index) {
//                         return Obx(
//                           () => RadioListTile(
//                             toggleable: true,
//                             value: index,
//                             title: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(
//                                         color: _controller.selectedVal == index
//                                             ? Colors.green
//                                             : Colors.transparent)),
//                                 child: Text(qstn.answers[index].answer!)),
//                             groupValue: _controller.selectedVal,
//                             onChanged: (value) {
//                               // if (mounted)
//                               // setState(
//                               //       () {
//                               _controller.assign(value);
//                               // val== index? _color = _selected:_color = _unSelected;
//                               //   },
//                               // );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
