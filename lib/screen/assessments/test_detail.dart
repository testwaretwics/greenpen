import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/take_test_detail_controller.dart';
import 'package:green_pen/model/take_test_detail_model.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:intl/intl.dart';

class TestDetail extends StatefulWidget {
  const TestDetail({Key? key}) : super(key: key);

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  final takeTestDetail4Controller = Get.put(TakeTestDetailController());
  PageController pageController = PageController();
  int selectedIndex = 0;

  var testCardListData = <TestCardModel>[
    TestCardModel(id: 1,title: '05-Aptitude, Language\nStudies + English',label: 'MCQ'),
    TestCardModel(id: 2,title: '05-Aptitude, Language\nStudies + English',label: 'MCQ'),
    TestCardModel(id: 3,title: '05-Aptitude, Language\nStudies + English',label: 'Descriptive'),
  ];

  @override
  void initState() {
    // TODO: implement initState
   // takeTestDetail4Controller.takeTestDetailApiDataCalling();
    super.initState();
  }

  // timingList (int selectedIndexInTab){
  //   takeTestDetail4Controller.mcqTestTimingList.clear();
  //   takeTestDetail4Controller.currentDate = DateFormat('dd-MMM-yyyy').parse(DateFormat("dd-MMM-yyyy").format(DateTime.now()));
  //   // DT1 is after DT2
  //   for(int i = 0; takeTestDetail4Controller.mcqTestDataList.length > i; i++){
  //     takeTestDetail4Controller.apiDateTime = DateFormat("dd-MMM-yyyy").parse(takeTestDetail4Controller.mcqTestDataList[i].date.toString());
  //     print(" $i For : ${takeTestDetail4Controller.apiDateTime}");
  //     // DT1 is after DT2
  //     if(takeTestDetail4Controller.currentDate!.compareTo(takeTestDetail4Controller.apiDateTime!) > 0 && selectedIndexInTab == 2){
  //       takeTestDetail4Controller.mcqTestTimingList.add(takeTestDetail4Controller.mcqTestDataList[i]);
  //       takeTestDetail4Controller.mcqTestTimingSkippedListLength = takeTestDetail4Controller.mcqTestTimingList.length;
  //     } else
  //       // DT1 is after DT2
  //       if(takeTestDetail4Controller.currentDate!.compareTo(takeTestDetail4Controller.apiDateTime!) < 0 && selectedIndexInTab == 3){
  //         takeTestDetail4Controller.mcqTestTimingList.add(takeTestDetail4Controller.mcqTestDataList[i]);
  //         takeTestDetail4Controller.mcqTestTimingUpComingListLength = takeTestDetail4Controller.mcqTestTimingList.length;
  //       } else
  //         // DT1 is DT2
  //         if(takeTestDetail4Controller.currentDate!.compareTo(takeTestDetail4Controller.apiDateTime!) == 0 && selectedIndexInTab == 0){
  //           takeTestDetail4Controller.mcqTestTimingList.add(takeTestDetail4Controller.mcqTestDataList[i]);
  //           takeTestDetail4Controller.mcqTestTimingTodayListLength = takeTestDetail4Controller.mcqTestTimingList.length;
  //         }
  //   }
  //    print("takeTestDetail4Controller.upCommingList :- ${takeTestDetail4Controller.mcqTestTimingList.length}");
  // }




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size192,
                  color: primaryLightColor,
                  child: Baseline(
                    baseline: size195,
                    baselineType: TextBaseline.alphabetic,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        tabList(0,'Today- ${takeTestDetail4Controller.mcqTestTimingTodayListLength}',kWhiteColor, kBlue1LightColor),
                        tabList(1,'UpComing-${takeTestDetail4Controller.mcqTestTimingUpComingListLength}',kGreyColor, kWhiteColor),
                        tabList(2,'Skipped-${takeTestDetail4Controller.mcqTestTimingSkippedListLength}',kGreyColor, kWhiteColor),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: primaryColor,
                      elevation: 0.0,
                      leading: Padding(
                        padding:  EdgeInsets.only(left: size22,right: 10),
                        child: InkWell(
                          onTap: (){
                            Get.back();
                          },
                            child: Image.asset("assets/png_file/arrowLeft.png",height: size19,)),
                      ),
                      centerTitle: true,
                      title:  Text(
                        'Test Detail',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: TextUtils.commonTextSize18,
                          fontWeight: TextUtils.titleTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size20,top: size35),
                      child:  Text(
                        'Test Series - TNPSC',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: TextUtils.hintTextSize,
                          fontWeight: TextUtils.normalTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size20,top: size8),
                      child:  Text(
                        'GR- || & ||A Prelims General Studies + English',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: TextUtils.commonTextSize,
                          fontWeight: TextUtils.headerTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size30,),
             Expanded(
              child: takeTestDetail4Controller.isLoading.value  ?
              const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,strokeWidth: 1.5,)) :
              PageView(
                controller: pageController,
                onPageChanged: (int index){
                  setState(() {
                    selectedIndex = index;
                    takeTestDetail4Controller.timingList(selectedIndex);
                  });
                },
                children: [
                  // Today - 1
                  takeTestDetail4Controller.mcqTestTimingList.isEmpty ?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('assets/png_file/no_data.png',height: 153,width: 148),
                        const SizedBox(height: 15),
                        const Text(
                          'No Tests Scheduled',
                          style:  TextStyle(
                              fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'We will notify you once you get your \ntests scheduled.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ) :
                  ListView.builder(
                    itemCount: takeTestDetail4Controller.mcqTestTimingList.length,
                    itemBuilder: (BuildContext context, int index) {

                      var data = takeTestDetail4Controller.mcqTestTimingList;
                      //print("Date  ${DateTime.parse(takeTestDetail4Controller.mcqTestDataList[index].date.toString())}");
                      //print("Date  ${DateTime.parse(takeTestDetail4Controller.mcqTestDataList[index].date.toString())}");
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: size12),
                        child: testCardList(data[index],index),
                      );
                    },
                  ),

                  // Upcoming - 3
                  takeTestDetail4Controller.mcqTestTimingList.isEmpty ?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('assets/png_file/no_data.png',height: 153,width: 148),
                        const SizedBox(height: 15),
                        const Text(
                          'No Tests Scheduled',
                          style:  TextStyle(
                              fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'We will notify you once you get your \ntests scheduled.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ) :
                  ListView.builder(
                    itemCount: takeTestDetail4Controller.mcqTestTimingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = takeTestDetail4Controller.mcqTestTimingList;
                      return Column(
                        children: [
                          testCardList(data[index],index),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size20,vertical: size10),
                            child: Divider(
                              height: size10,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Skipped - 2
                  takeTestDetail4Controller.mcqTestTimingList.isEmpty ?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('assets/png_file/no_data.png',height: 153,width: 148),
                        const SizedBox(height: 15),
                        const Text(
                          'No Tests Scheduled',
                          style:  TextStyle(
                              fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'We will notify you once you get your \ntests scheduled.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ) :
                  ListView.builder(
                    itemCount: takeTestDetail4Controller.mcqTestTimingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = takeTestDetail4Controller.mcqTestTimingList;
                      return Column(
                        children: [
                          testCardList(data[index],index),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size20,vertical: size10),
                            child: Divider(
                              height: size10,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: takeTestDetail4Controller.selectedDate,
      lastDate: DateTime(2025),
      firstDate: DateTime(2010),
    );
    if (selected != null && selected != takeTestDetail4Controller.selectedDate)
      setState(() {
        takeTestDetail4Controller.selectedDate = selected;
      });
  }

  Widget tabList(int index, String title,Color textColor, Color bgColor){
    return InkWell(
      onTap: (){
        setState(() {
          selectedIndex = index;
          pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          print('selectedIndex : $selectedIndex');
          takeTestDetail4Controller.timingList(selectedIndex);
        });
      },
      child: Container(
        height: size40,width: size95,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: selectedIndex == index ? kBlue1LightColor : kWhiteColor,
          borderRadius: BorderRadius.circular(size30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0.0,2.0),
              spreadRadius: 0.5
            )
          ],
        ),
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(
              color: selectedIndex == index ? kWhiteColor : kGreyColor,
              fontSize: TextUtils.hintTextSize,
              fontWeight: TextUtils.mediumtTextWeight,
              fontFamily: TextUtils.interFontFamily,
            ),
          ),
        ),
      ),
    );
  }

  Widget testCardList(McqTest data, int index){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size20,right: size20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
              //  _selectDate(context);
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Image.asset('assets/png_file/calender.png',width: size22,height: size22),
                SizedBox(width: size10),
                Text(
                  data.date.toString(),  //selectedDate.toString().split(' ').first,
                  style:  TextStyle(
                    color: kBlueColor,
                    fontSize: TextUtils.hintTextSize,
                    fontWeight: TextUtils.titleTextWeight,
                    fontFamily: TextUtils.interFontFamily,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // height: size220,
            margin: EdgeInsets.only(top: size20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: kShadowColor,
                ),
                borderRadius: BorderRadius.circular(size5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size18, left: size12),
                      child: Container(
                        width: size.width / 1.8,
                        child: RichText(text:  TextSpan(
                            children: [
                              TextSpan(
                                text: data.testTitle.toString(),
                                style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontFamily: TextUtils.interFontFamily,
                                ),
                              ),
                            ]
                        ),),
                      ),
                    ),
                    Container(
                      height: size32,
                      width: size78,
                      alignment: AlignmentDirectional.center,
                      decoration:  BoxDecoration(
                          color: index==2 ? kBlueLabelColor : kOranageBtnColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(size5))
                      ),
                      child: Text(
                       "lable",// data.label.toString(),
                        style:  TextStyle(
                          color: kWhiteColor,
                          fontSize: TextUtils.hintTextSize,
                          fontWeight: TextUtils.normalTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Table(
                    //defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.none,
                        width: 0),
                    children: [
                      TableRow(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '90 mins',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextUtils.hintTextSize,
                                        fontWeight: TextUtils.mediumtTextWeight,
                                        fontFamily: TextUtils.interFontFamily,
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.list),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '100 Questions',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextUtils.hintTextSize,
                                        fontWeight: TextUtils.mediumtTextWeight,
                                        fontFamily: TextUtils.interFontFamily,
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ]),
                      const TableRow(
                          children: [
                            SizedBox(height: 4),//SizeBox Widget
                            SizedBox(height: 4),
                          ]
                      ),
                      TableRow( children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Image.asset('assets/png_file/note.png',height: 22,width: 22),
                              const SizedBox(width: 10),
                               Expanded(
                                 child: Text(
                                  '200 Marks',
                                  style:  TextStyle(
                                    color: Colors.black,
                                    fontSize: TextUtils.hintTextSize,
                                    fontWeight: TextUtils.mediumtTextWeight,
                                    fontFamily: TextUtils.interFontFamily,
                                  ),
                              ),
                               ),
                            ]
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '200 Students Taking',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextUtils.hintTextSize,
                                    fontWeight: TextUtils.mediumtTextWeight,
                                    fontFamily: TextUtils.interFontFamily,
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ]),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: size12, left: size12, right: size12, bottom: size8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
                      fixedSize: Size(size.width, size50),
                    ),
                    onPressed: () { },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'Take Test',
                          style:  TextStyle(
                            color: kWhiteColor,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.normalTextWeight,
                            fontFamily: TextUtils.interFontFamily,
                          ),
                        ),
                        SizedBox(width: size10,),
                        Image.asset("assets/png_file/right_arrow_circle.png",height: 22,),
                        //Icon(Icons.arrow_right_alt_outlined, color: Colors.white,size: size15,)
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class TestCardModel{
  int? id;
  String? title;
  String? label;

  // ignore: sort_constructors_first
  TestCardModel({this.id,this.title,this.label});
}
