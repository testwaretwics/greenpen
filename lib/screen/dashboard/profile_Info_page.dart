import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/profile_controller.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  var profileController = Get.put(ProfileController());


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    profileController.profileApiData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getInternetConnection();
    super.initState();
    profileController.enableTextFiled = false;
  }

  getInternetConnection() async{
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      profileController.profileApiData();
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: size22, right: 10),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/png_file/arrowLeft.png",
                height: size19,
              )),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  profileController.enableTextFiled =
                      !profileController.enableTextFiled;
                });
              },
              icon: Image.asset(
                "assets/png_file/editProfileIcon.png",
                height: size19,
              ))
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SafeArea(
            child: Obx(() => profileController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ))
                : Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 150,
                                color: primaryColor,
                              ),
                              Positioned(
                                top: 30,
                                left: 30,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                  ),
                                  child: ClipOval(
                                      child: profileController.imageFile == null
                                          ?  Image.network(
                                              profileController.profileImage,
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit.cover)
                                          : Image.file(
                                              profileController.imageFile!,
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit.cover)),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                left: 90,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 140,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _getFromGallery();
                                                  },
                                                  child:
                                                      Text("PICK FROM GALLERY"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _getFromCamera();
                                                  },
                                                  child: Text("PICK FROM CAMERA"),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 20),
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Image.asset(
                                      "assets/png_file/profileIcon.png",
                                      height: 170))
                            ],
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                textFieldWidget(
                                    profileController.fNameController),
                                textFieldWidget(
                                    profileController.lNameController),
                                textFieldWidget(
                                    profileController.emailController),
                                textFieldWidget(
                                    profileController.mobileController),
                                // passwordFieldWidget(
                                //   onChanged: (value) {},
                                //   press: () {
                                //     setState(() {
                                //       profileController.isVisible =
                                //           !profileController.isVisible;
                                //     });
                                //   },
                                //   passwordVisible: profileController.isVisible,
                                //   controller:
                                //       profileController.passwordController,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))),
      ),
      bottomNavigationBar: Container(
        height: 70,
        // color: Colors.red,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10),
          child: RoundedButton(
            text: "Save",
            press: () async {
              if (profileController.enableTextFiled == true) {
                var result = await (Connectivity().checkConnectivity());
                if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                  profileController.updateProfileValidation();
                } else {
                  Get.snackbar('Internet', 'No Internet Connection',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              }
            },
            color:
                profileController.enableTextFiled ? secondaryColor : kGreyColor,
          ),
        ),
      ),
    );
  }

  /// Get from gallery
  Future<File?> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      setState(() {
        profileController.imageFile = File(pickedFile.path);
        print("imageFile :- ${profileController.imageFile}");
      });
      Get.back();
    }
    return null;
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      setState(() {
        profileController.imageFile = File(pickedFile.path);
        print("imageFile :- ${profileController.imageFile}");
      });

      Get.back();
    }
  }

  Widget passwordFieldWidget(
      {required bool passwordVisible,
      required dynamic onChanged,
      required TextEditingController? controller,
      required dynamic press,
      required}) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: TextFormField(
        obscureText: passwordVisible,
        onChanged: onChanged,
        controller: controller,
        cursorColor: primaryColor,
        enabled: profileController.enableTextFiled,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB5B5B5)),
          suffixIcon: IconButton(
            icon: profileController.enableTextFiled == true
                ? Icon(
                    !passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  )
                : Container(),
            onPressed: press,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget textFieldWidget(TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          enabled: profileController.enableTextFiled,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
