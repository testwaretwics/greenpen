import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/take_test_controller.dart';
import 'package:green_pen/model/take_test_model.dart';
import 'package:green_pen/screen/assessments/test_detail.dart';
import 'package:green_pen/screen/assessments/unit_test_detail.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';
// import 'package:table_calendar/table_calendar.dart';

class Assessments extends StatefulWidget {
  const Assessments({Key? key}) : super(key: key);

  @override
  State<Assessments> createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
  final takeTestController = Get.put(TakeTestController());

  PageController pageController = PageController();
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Assessments'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Obx(
          ()=> Padding(
              padding:  EdgeInsets.only(left: size23, right: size23),
              child: Column(
                children: [
                  // TableCalendar(
                  //   startingDayOfWeek: StartingDayOfWeek.monday,
                  //   // Calendar
                  //   calendarStyle: CalendarStyle(
                  //       outsideDaysVisible: false,
                  //       defaultDecoration: BoxDecoration(
                  //         border: Border.all(color: kShadowColor),
                  //         borderRadius: BorderRadius.circular(size4),
                  //       ),
                  //       todayDecoration: BoxDecoration(
                  //           color: kWhiteColor,
                  //           border: Border.all(color: kShadowColor),
                  //           borderRadius: BorderRadius.circular(size4),
                  //           boxShadow: const [  BoxShadow(
                  //             color: kShadowColor,
                  //             offset: Offset(0.0, 1.24),
                  //           ),]
                  //       ),
                  //       todayTextStyle:  TextStyle(
                  //         color: primaryLightColor,
                  //         fontSize: TextUtils.headerTextSize,
                  //         fontWeight: TextUtils.normalTextWeight,
                  //         fontFamily: TextUtils.interFontFamily
                  //       )
                  //   ),
                  //   // Header
                  //   headerStyle: HeaderStyle(
                  //     formatButtonDecoration: BoxDecoration(
                  //       color: Colors.grey[600],
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     formatButtonVisible: false,
                  //     titleCentered: true,
                  //   ),
                  //   firstDay: DateTime.utc(2010, 10, 16),
                  //   lastDay: DateTime.utc(2030, 3, 14),
                  //   focusedDay: DateTime.now(),
                  //   calendarFormat: CalendarFormat.week,
                  // ),
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
                    children:  [
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: TextUtils.commonTextSize18,
                          fontWeight: TextUtils.titleTextWeight,
                          fontFamily: TextUtils.interFontFamily,
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
                          if (takeTestController.orderDataList.isEmpty) Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Image.asset('assets/png_file/no_data.png',height: size153,width: size148),
                                 SizedBox(height: size15),
                                 Text(
                                 'No Tests Scheduled',
                                  style:  TextStyle(
                                    color: Colors.black,
                                    fontSize: TextUtils.commonTextSize,
                                    fontWeight: TextUtils.headerTextWeight,
                                    fontFamily: TextUtils.interFontFamily
                                  ),
                                ),
                                 SizedBox(height: size15),
                                 Text(
                                 'We will notify you once you get your \ntests scheduled.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextUtils.hintTextSize,
                                    fontWeight: TextUtils.normalTextWeight,
                                    fontFamily: TextUtils.interFontFamily
                                  ),
                                ),
                              ],
                            ),
                          ) else
                            takeTestController.isLoading.value ? CircularProgressIndicator() :
                            ListView.builder(
                            itemCount: takeTestController.orderDataList.length,
                            itemBuilder: (BuildContext context, int index){
                              var data = takeTestController.orderDataList;
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: size8),
                                child: _assessmentContainer(data[index],index,selectedTab),
                              );
                            }
                          ),
                          // Unit Test Series
                          if (takeTestController.orderDataList.isEmpty) Center(
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
                          ) else  takeTestController.isLoading.value ? CircularProgressIndicator() :
                          ListView.builder(
                            itemCount: takeTestController.orderDataList.length,
                            itemBuilder: (BuildContext context, int index){
                              var data = takeTestController.orderDataList;
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: size8),
                                child: _assessmentContainer(data[index],index,selectedTab),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                ],
              ),
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
              fontFamily: TextUtils.interFontFamily
            ),
          ),
        ),
      ),
    );
  }

  Widget _assessmentContainer (Order data, int index, int selectedTab ){
    final Size size = MediaQuery.of(context).size;
    return Container(
      //height: size220,
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
                        text:  data.packageNameLang1.toString(),
                        style:  TextStyle(
                          color: Colors.red,
                          fontSize: TextUtils.commonTextSize,
                          fontWeight: TextUtils.titleTextWeight,
                          fontFamily: TextUtils.interFontFamily
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
                 "lable",// data.label.toString(),
                  style:  TextStyle(
                      fontSize: TextUtils.hintTextSize,
                      fontWeight: TextUtils.normalTextWeight,
                      fontFamily: TextUtils.interFontFamily
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
                             Text(
                              data.examType.toString(), //'MCQ, Descriptive',
                              style: TextStyle(
                                fontSize: TextUtils.hintTextSize,
                                fontWeight: TextUtils.mediumtTextWeight,
                                fontFamily: TextUtils.interFontFamily
                              ),
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            Image.asset('assets/png_file/test.png',height: size22,width: size22),
                             SizedBox(width: size10),
                             Text(
                              data.noOfTest.toString() + " Test",//'20 Test',
                              style: TextStyle(
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.mediumtTextWeight,
                                  fontFamily: TextUtils.interFontFamily
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
                       Text(
                        '1 Test Available',
                        style:  TextStyle(
                          fontSize: TextUtils.hintTextSize,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily
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
                            Get.toNamed(ROUTE_TEST_DETAILS);
                          }else{
                            Get.toNamed(ROUTE_UNIT_TEST_DETAILS);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(
                            'View details',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontFamily: TextUtils.interFontFamily
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
                      children:  [
                        Text(
                          'Take Test',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.titleTextWeight,
                            fontFamily: TextUtils.interFontFamily
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
