import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/screen/assessments/test_detail.dart';
import 'package:green_pen/screen/assessments/unit_test_detail.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class Assessments extends StatefulWidget {
  const Assessments({Key? key}) : super(key: key);

  @override
  State<Assessments> createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
  PageController pageController = PageController();
  int selectedTab = 0;

  List<TestCardModel> testCardListData = <TestCardModel>[
    TestCardModel(id: 1,title: 'GR- II & IIA Prelims General Studies + English',label: 'TNPSC'),
    TestCardModel(id: 2,title: 'GR- II & IIA Prelims General Studies + English',label: 'UPSC'),
    TestCardModel(id: 3,title: 'GR- II & IIA Prelims General Studies + English',label: 'TNUSRB'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Assessments'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: primaryLightColor,
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: size23, right: size23),
        child: Column(
          children: [
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              // Calendar
              calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  defaultDecoration: BoxDecoration(
                    border: Border.all(color: kShadowColor),
                    borderRadius: BorderRadius.circular(size4),
                  ),
                  todayDecoration: BoxDecoration(
                      color: kWhiteColor,
                      border: Border.all(color: kShadowColor),
                      borderRadius: BorderRadius.circular(size4),
                      boxShadow: const [  BoxShadow(
                        color: kShadowColor,
                        offset: Offset(0.0, 1.24),
                      ),]
                  ),
                  todayTextStyle: const TextStyle(
                    color: primaryLightColor,
                    fontSize: TextUtils.headerTextSize,
                    fontWeight: TextUtils.normalTextWeight,
                    fontFamily: 'Inter'
                  )
              ),
              // Header
              headerStyle: HeaderStyle(
                formatButtonDecoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
            ),
             SizedBox(height: size10,),
            const Divider(),
             SizedBox(height: size10,),
            Row(
              children: [
                tabBar(0, 'Test series'),
                 SizedBox(width: size25,),
                tabBar(1, 'Unit Test series'),
              ],
            ),
             SizedBox(
              height: size20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: TextUtils.commonTextSize18,
                    fontWeight: TextUtils.titleTextWeight,
                    fontFamily: 'Inter',
                  ),
                ),
                Icon(Icons.filter_alt_rounded),
              ],
            ),
             SizedBox(
              height: size10,
            ),

            Expanded(
              child: PageView(
                onPageChanged: (int index){
                  setState(() {
                    selectedTab = index;
                  });
                },
                controller: pageController,
                children: [
                  // Test Series
                  if (testCardListData.isEmpty) Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('assets/png_file/no_data.png',height: size153,width: size148),
                         SizedBox(height: size15),
                        const Text(
                         'No Tests Scheduled',
                          style:  TextStyle(
                            color: Colors.black,
                            fontSize: TextUtils.commonTextSize,
                            fontWeight: TextUtils.headerTextWeight,
                            fontFamily: 'Inter'
                          ),
                        ),
                         SizedBox(height: size15),
                        const Text(
                         'We will notify you once you get your \ntests scheduled.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.normalTextWeight,
                            fontFamily: 'Inter'
                          ),
                        ),
                      ],
                    ),
                  ) else ListView.builder(
                    itemCount: testCardListData.length,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: size8),
                        child: _assessmentContainer(testCardListData[index],index,selectedTab),
                      );
                    }
                  ),
                  // Unit Test Series
                  if (testCardListData.isEmpty) Center(
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
                  ) else
                  ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: size8),
                        child: _assessmentContainer(testCardListData[index],index,selectedTab),
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar(int index, String title){
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(size5),
        ),
        padding: const EdgeInsets.all(0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedTab = index;
              pageController.animateToPage(selectedTab, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            });
          },
          style: ElevatedButton.styleFrom(
            primary: selectedTab == index ? secondaryColor : kWhiteColor, // background
            onPrimary: Colors.white, // foreground
            fixedSize: const Size(200, 50),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selectedTab == index ? kWhiteColor : secondaryColor,
              fontSize: TextUtils.hintTextSize,
              fontWeight: TextUtils.titleTextWeight,
              fontFamily: 'Inter'
            ),
          ),
        ),
      ),
    );
  }

  Widget _assessmentContainer (TestCardModel data, int index, int selectedTab){
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size220,
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
                          fontFamily: 'Inter'
                        ),
                      ),
                    ]
                  ),),
                ),
              ),
              Container(
                height: size32,
                width: size78,
                color: index==0 ? unselectedBtnColor : index==1 ? primaryLightColor : kPinkBtnColor,
                alignment: AlignmentDirectional.center,
                child: Text(
                  data.label.toString(),
                  style: const TextStyle(
                      fontSize: TextUtils.hintTextSize,
                      fontWeight: TextUtils.normalTextWeight,
                      fontFamily: 'Inter'
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(size20),
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
                          children: [
                            const Icon(Icons.menu_book_outlined),
                            SizedBox(width: size10),
                            const Text(
                              'MCQ, Descriptive',
                              style: TextStyle(
                                fontSize: TextUtils.hintTextSize,
                                fontWeight: TextUtils.mediumtTextWeight,
                                fontFamily: 'Inter'
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            Image.asset('assets/png_file/test.png',height: size22,width: size22),
                             SizedBox(width: size10),
                            const Text(
                              '20 Test',
                              style: TextStyle(
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.mediumtTextWeight,
                                  fontFamily: 'Inter'
                              ),
                            ),
                          ]
                      ),
                    ]),
                const TableRow(
                    children: [
                      SizedBox(height: 5),//SizeBox Widget
                      SizedBox(height: 5),
                    ]
                ),
                TableRow( children: [
                  Row(
                    children:[
                      Image.asset('assets/png_file/book.png',height: size20,width: size22),
                       SizedBox(width: size10),
                      const Text(
                        '1 Test Available',
                        style:  TextStyle(
                          fontSize: TextUtils.hintTextSize,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: 'Inter'
                        ),
                      ),
                    ]
                  ),
                  Row(
                    children: const [
                      // Icon(Icons.people),
                      // SizedBox(width: 10),
                      // Text(
                      //   '200 Students Taking',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ]
                  ),
                ]),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: size12, left: size12, right: size12, bottom: size8),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(size3),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.transparent,
                        elevation: 0.5,
                        shadowColor: Colors.transparent,
                        fixedSize: const Size(200, 48),
                      ),
                      onPressed: () {
                        setState(() {
                          if(selectedTab==0){
                            Get.to(const TestDetail());
                          }else{
                            Get.to(const UnitTestDetail());
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'View details',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontFamily: 'Inter'
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, color: primaryColor,)
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: size25,),
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
                      elevation: 0.5,
                      fixedSize: const Size(200, 50),
                    ),
                    onPressed: () { },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Take Test',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.titleTextWeight,
                            fontFamily: 'Inter'
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
                      ],
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

class TestCardModel{
  int? id;
  String? title;
  String? label;

  TestCardModel({this.id,this.title,this.label});
}
