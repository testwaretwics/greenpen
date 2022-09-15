// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/purchased_tests_controller.dart';
import 'package:green_pen/model/purchased_tests_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';

class PurchasedTests extends StatelessWidget {
  final purchasedTestsController = Get.put(PurchasedTestsController());
  final String amount = "INR 3000/-";
  final bool isDone = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text("Purchased Tests"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Obx(()=> purchasedTestsController.isLoading.value ?
          const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,strokeWidth: 1.5,)) :
         SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              CustomRadioButton(
                defaultSelected: purchasedTestsController.tabCategoryId,
                enableShape: true,
                unSelectedBorderColor: Colors.grey.shade200,
                selectedBorderColor: Colors.grey.shade200,
                padding: 12,
                spacing: 5,
                elevation: 0.0,
                absoluteZeroSpacing: false,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: List.generate(purchasedTestsController.categoryDataList.length, (index) => purchasedTestsController.categoryDataList[index].courseCategoryLang1!),
                buttonValues: List.generate(purchasedTestsController.categoryDataList.length, (index) => purchasedTestsController.categoryDataList[index].id!),
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Color(0xffB5B5B5),
                  textStyle: TextStyle(fontSize: 16),
                ),
                radioButtonValue: (value) async {
                  purchasedTestsController.tabCategoryId = value;
                  var result = await (Connectivity().checkConnectivity());
                  if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                    purchasedTestsController.getCategoryWithPackageDetailDataList(value);
                  } else {
                    Get.snackbar('Internet', 'No Internet Connection',
                        backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
                selectedColor: Color(0xff80B2FF),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Booked On :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width:10),
                    Text(
                      "20-Mar-2022",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              purchasedTestsController.categoryWithPackageDetailDataList.isEmpty ?
              Container(
                height: size.height/1.5,
                alignment: AlignmentDirectional.center,
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: purchasedTestsController.categoryWithPackageDetailDataList.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: examWidget(purchasedTestsController.categoryWithPackageDetailDataList[index], index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container examWidget(PackageDetail data, int index,) {
    return Container(
       height: 260,
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.withOpacity(0.5),width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                  data.languages.toString(),
                  //"General Tamil",
                  style: TextStyle(
                    color: Color(0xff1CBBA3),
                  ),
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.packageNameLang1.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "\u{20B9}  ${data.feesForNew.toString()}/-",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff296ACC),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset("assets/png_file/examtype.png",height: 22,width: 22)
                ),
                Container(
                  width: 120,
                  child: Text(
                    data.examType.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset("assets/png_file/test.png",height: 22,width: 22)
                ),
                Container(
                  width: 120,
                  child: Text(
                    "${data.noOfTest.toString()} Tests",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset("assets/png_file/online.png",height: 22,width: 22)
                ),
                Container(
                  width: 120,
                  child: Text(
                    data.packageType.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset("assets/png_file/date_range.png",height: 22,width: 22)
                ),
                Container(
                  width: 120,
                  child: Text(
                    data.startDate.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 10,right: 10),
            child: FlatButton(
              color: Colors.white,
              height: 50,
              onPressed: () {
                Get.toNamed(ROUTE_ABOUT_PURCHASED_TESTS,arguments: data.packageId);
              },
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "View Details",
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: primaryColor)),
                    child: Icon(
                      Icons.arrow_forward_sharp,
                      size: 16,
                      color: primaryColor,
                    ),
                  ),
                  Spacer()
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: primaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
