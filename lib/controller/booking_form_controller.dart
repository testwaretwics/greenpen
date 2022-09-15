
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/model/booking_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:intl/intl.dart';

class Education {
  String? qualification;
  String? SchoolName;
  String? percentage;
  Education({
    this.qualification,
    this.SchoolName,
    this.percentage,
  });

  Education.fromJson(Map<String, dynamic> json) {
    qualification = json['qualification'];
    SchoolName = json['name'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qualification'] = qualification;
    data['name'] = SchoolName;
    data['percentage'] = percentage;

    return data;
  }
}

class BookingFormController extends GetxController{

  var genderDataList = List<Gender>.empty(growable: true).obs;
  var mediumDataList = List<Medium>.empty(growable: true).obs;
  var qualificationDataList = List<Qualification>.empty(growable: true).obs;
  var nameController = TextEditingController();
  var dobController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  // var genderController = TextEditingController();
  // var mediumController = TextEditingController();
  List<TextEditingController> schoolNameControllers = [];
  List<TextEditingController> percentageControllers = [];
  var educationList = List<Education>.empty(growable: true);
  var education = Education();
  var packageId;
  var price;
  var checked = false;
  String? image;
  DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());

  Package? packageData;
  StudentInformation? studentInformationData;
  var isLoading = false.obs;
  var selectedGender;
  var selectedMedium;
  var addMoreEducation = 1;
  List<String> selectedQualification = <String>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    packageId = Get.arguments[0];
    price = Get.arguments[1];

    print("price ${price}");

    print("Start");
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      getBookingApiData(packageId);
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    print("End");
    super.onInit();
  }

  Future<void> apiCallingMethod(int? packageId) async {
    await getBookingApiData(packageId);
  }

  Future<void> getBookingApiData(int? packageId) async {
    isLoading.value = true;
    genderDataList.clear();
    qualificationDataList.clear();
    mediumDataList.clear();
    await APIProvider().bookingAPI(
      id: packageId,
      onSuccess: (data) {
        print('Response 11 bookingAPI : ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          packageData = data.result!.package;
          packageId = data.result!.package!.id;
          print("package id :- ${packageId}");
          //Preferences.addDataToSF(Preferences.BOOKING_PACKAGE_ID, packageId);
          studentInformationData = data.result!.studentInformation;
          data.result!.gender!.forEach((element) {
            genderDataList.add(element);
          });
          data.result!.medium!.forEach((element) {
            mediumDataList.add(element);
          });
          data.result!.qualification!.forEach((element) {
            qualificationDataList.add(element);
          });
          print("Image : ${studentInformationData!.studentImage!}");
          image = studentInformationData!.studentImage!;
          nameController.text = studentInformationData!.name!;
          dobController.text = studentInformationData!.dob!;
          emailController.text = studentInformationData!.email!;
          phoneController.text = studentInformationData!.mobileNo.toString();
          selectedGender = studentInformationData!.gender!;
          selectedMedium = studentInformationData!.medium!;
          studentInformationData!.schoolName!.isNotEmpty || studentInformationData!.schoolName! == ""  ? schoolNameControllers.add(TextEditingController(text: studentInformationData!.schoolName!.toString())) : null;
          studentInformationData!.highSchoolName!.isNotEmpty || studentInformationData!.highSchoolName! == ""  ?  schoolNameControllers.add(TextEditingController(text: studentInformationData!.highSchoolName!.toString())) : null;
          studentInformationData!.ugDegree!.isNotEmpty || studentInformationData!.ugDegree! == ""  ?  schoolNameControllers.add(TextEditingController(text: studentInformationData!.ugDegree!.toString())) : null;

          percentageControllers.add(TextEditingController(text: studentInformationData!.schoolPercentage!.toString()));
          percentageControllers.add(TextEditingController(text: studentInformationData!.highSchoolPercentage!.toString()));
          percentageControllers.add(TextEditingController(text: studentInformationData!.ugPercentage!.toString()));
         // percentageControllers.add(TextEditingController(text: studentInformationData!.pgPercentage!.toString()));

          selectedQualification = ["SSLC","HSC","UG","PG"];
          //schoolNameControllers[0].text = studentInformationData!.schoolName!;
          // schoolNameControllers[1].text = studentInformationData!.highSchoolName!;
          // schoolNameControllers[2].text = studentInformationData!.ugDegree!;
         // schoolNameControllers[0].text = studentInformationData!.pg!;
          addMoreEducation = schoolNameControllers.length;//3;
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

  Future<void> bookingFormApiDataCalling() async {
    await bookingFormApiData();
  }

  Future<void> bookingFormApiData() async {
    // Map<String, dynamic> input ={
    //   "package_id" : "16",//packageId,
    //   "name" : "Gayathri",//nameController.text.toString(),
    //   "dob" : "21-07-2222",//dobController.text.toString(),
    //   "gender" : "Male",//selectedGender,
    //   "medium" : "Tamil",//selectedMedium,
    //   "qualification" : '[{"qualification":"SSLC","name":"corporation school","percentage":"10"}]',
    //     // {"qualification":"HSC","name":"corporation hr sec school","percentage":"10"},
    //     // {"qualification":"UG","name":"Collage Name","percentage":"10"},
    //     // {"qualification":"PG","name":"Collage Name","percentage":"10"}
    // //]',
    //   //educationList,
    //   "price" : "3000",//price,
    // };
    Map<String, dynamic> input ={
      "package_id" : "$packageId",
      "name" : nameController.text.toString(),
      "dob" : dobController.text.toString(),
      "gender" : selectedGender,
      "medium" : selectedMedium,
      "qualification" : jsonEncode(educationList),
      "price" : "$price",
    };
    isLoading.value = true;
    await APIProvider().bookingFormAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          Get.snackbar("Success", data.message.toString(),
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.toNamed(ROUTE_CART);
          Get.put(CartController()).apiCallingMethod(true);
        }else{
          Get.snackbar("Failed", data.message.toString(),
              backgroundColor: Colors.red, colorText: Colors.white);
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