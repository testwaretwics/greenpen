import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';

class TestDetail extends StatefulWidget {
  const TestDetail({Key? key}) : super(key: key);

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {

  PageController pageController = PageController();
  int selectedIndex = 0;
  DateTime selectedDate = DateTime.now();

  var testCardListData = <TestCardModel>[
    TestCardModel(id: 1,title: '05-Aptitude, Language\nStudies + English',label: 'MCQ'),
    TestCardModel(id: 2,title: '05-Aptitude, Language\nStudies + English',label: 'MCQ'),
    TestCardModel(id: 3,title: '05-Aptitude, Language\nStudies + English',label: 'Descriptive'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
                      tabList(0,'Today-1',kWhiteColor, kBlue1LightColor),
                      tabList(1,'Upcomming-3',kGreyColor, kWhiteColor),
                      tabList(2,'Skipped-2',kGreyColor, kWhiteColor),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: primaryLightColor,
                    elevation: 0.0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back,color: kWhiteColor),
                      onPressed: (){
                        Get.back();
                      },
                    ),
                    centerTitle: true,
                    title: const Text(
                      'Test Detail',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: TextUtils.commonTextSize18,
                        fontWeight: TextUtils.titleTextWeight,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size20,top: size35),
                    child: const Text(
                      'Test Series - TNPSC',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.normalTextWeight,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size20,top: size8),
                    child: const Text(
                      'GR- || & ||A Prelims General Studies + English',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: TextUtils.commonTextSize,
                        fontWeight: TextUtils.headerTextWeight,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: size30,),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int index){
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [
                // Today - 1
                ListView.builder(
                  itemCount: testCardListData.length-2,
                  itemBuilder: (BuildContext context, int index) {
                    return testCardList(testCardListData[index],index);
                  },
                ),

                // Upcoming - 3
                ListView.builder(
                  itemCount: testCardListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        testCardList(testCardListData[index],index),
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
                ListView.builder(
                  itemCount: testCardListData.length-1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        testCardList(testCardListData[index],index),
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
    );
  }

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: DateTime(2025),
      firstDate: DateTime(2010),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  Widget tabList(int index, String title,Color textColor, Color bgColor){
    return InkWell(
      onTap: (){
        setState(() {
          selectedIndex = index;
          pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          print('selectedIndex : $selectedIndex');
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
        child: Text(
          title,
          style: TextStyle(
            color: selectedIndex == index ? kWhiteColor : kGreyColor,
            fontSize: TextUtils.hintTextSize,
            fontWeight: TextUtils.mediumtTextWeight,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget testCardList(TestCardModel data, int index){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size20,right: size20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _selectDate(context);
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Image.asset('assets/png_file/calender.png',width: size22,height: size22),
                SizedBox(width: size10),
                Text(
                  selectedDate.toString().split(' ').first,
                  style: const TextStyle(
                    color: kBlueColor,
                    fontSize: TextUtils.hintTextSize,
                    fontWeight: TextUtils.titleTextWeight,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size220,
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
                                text: data.title.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontFamily: 'Inter',
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
                        data.label.toString(),
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: TextUtils.hintTextSize,
                          fontWeight: TextUtils.normalTextWeight,
                          fontFamily: 'Inter',
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
                                children:const [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    '90 mins',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: TextUtils.hintTextSize,
                                      fontWeight: TextUtils.mediumtTextWeight,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                children:const [
                                  Icon(Icons.list),
                                  SizedBox(width: 10),
                                  Text(
                                    '100 Questions',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: TextUtils.hintTextSize,
                                      fontWeight: TextUtils.mediumtTextWeight,
                                      fontFamily: 'Inter',
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
                            children:[
                              Image.asset('assets/png_file/note.png',height: 22,width: 22),
                              const SizedBox(width: 10),
                              const Text(
                                '200 Marks',
                                style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.mediumtTextWeight,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children:const [
                              Icon(Icons.people),
                              SizedBox(width: 10),
                              Text(
                                '200 Students Taking',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.mediumtTextWeight,
                                  fontFamily: 'Inter',
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
                        const Text(
                          'Take Test',
                          style:  TextStyle(
                            color: kWhiteColor,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.normalTextWeight,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(width: size10,),
                        Icon(Icons.arrow_circle_right_outlined, color: Colors.white,size: size15,)
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
