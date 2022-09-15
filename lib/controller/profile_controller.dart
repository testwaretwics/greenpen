import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:dio/dio.dart' as api;
import 'package:green_pen/widgets/snackbar_message.dart';

class ProfileController extends GetxController{

  var profileDataList = [];
  var isLoading = false.obs;
  var profileImage = "";
  File? imageFile;

  bool isVisible = true;
  bool enableTextFiled = false;
  bool passwordVisible = false;
  TextEditingController fNameController = TextEditingController();

  TextEditingController lNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print("Clllee");
    fNameController = TextEditingController(text: "First Name");
    lNameController = TextEditingController(text: "Last Name");
    emailController = TextEditingController(text: "Email");
    mobileController = TextEditingController(text: "Mobile Number");
    passwordController = TextEditingController(text: "Password");
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> profileApiData()async {
    isLoading.value = true;
    await APIProvider().profileAPI(
      onSuccess: (data) {
        if(data.status == true) {
          profileImage = data.result!.studentImage.toString();
          fNameController.text = data.result!.firstName!;
          lNameController.text = data.result!.lastName!;
          print("last name on profile :- ${data.result!.lastName}");
          emailController.text = data.result!.email!;
          mobileController.text = data.result!.mobileNo.toString();
          // passwordController!.text = data.result!..toString();
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }

  Future<void> profileUpdateApiData() async {

    Map<String, dynamic> input = {
      'user_id': Preferences.getIntValuesSF(Preferences.USER_ID),
      'first_name': fNameController.text,
      'last_name': lNameController.text,
      'mobile_number': mobileController.text,
      'profile_image': imageFile == null ? imageFile :  await api.MultipartFile.fromFile(imageFile!.path, filename: "${DateTime.now()}.jpg"), // imageFile, //File(imageFile!.path), //profileImage,
    };
    isLoading.value = true;
    await APIProvider().profileUpdateAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print("called");
        print("called ${data.status}");
        print("called ${data.message}");
        // if(data.status != true) {
        //   profileImage = data.result!.studentImage.toString();
        //   fNameController.text = data.result!.firstName!;
        //   lNameController.text = data.result!.lastName!;
        //   emailController.text = data.result!.email!;
        //   mobileController.text = data.result!.mobileNo.toString();
        //   passwordController.text = data.result!.toString();
        // }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }

  Future<void> updateProfileValidation() async {
    if(fNameController.text.isEmpty){
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "First Name",
          msg: "First name is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    }else if(lNameController.text.isEmpty){
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "Last Name",
          msg: "Last name is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    }else if(emailController.text.isEmpty){
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "Email-Id",
          msg: "Email-Id is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    }else if(mobileController.text.isEmpty){
      snackBarMsg(
          bgColor: Colors.redAccent,
          title: "Mobile Number",
          msg: "Mobile number is required",
          colors: kWhiteColor,
          icon: Icons.warning);
    }else{
     await profileUpdateApiData();
    }
  }
}