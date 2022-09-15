// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/booking_form_controller.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  BookingForm({Key? key}) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final bookingFormController = Get.put(BookingFormController());
  late Widget _widget;

  String buttonText = "Next";
  var index = 0;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic pickImageError;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();
    _widget = first();
  }

  void firstNext() {
    setState(() {
      if (bookingFormController.nameController.text.isEmpty) {
        Get.snackbar('Enter Name', 'Please Enter Name',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.dobController.text.isEmpty) {
        Get.snackbar('Enter DOB', 'Please Enter DOB',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.emailController.text.isEmpty) {
        Get.snackbar('Enter Email', 'Please Enter Email',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.phoneController.text.isEmpty) {
        Get.snackbar('Enter Phone', 'Please Enter Phone',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.selectedGender==null) {
        Get.snackbar('Select Gender', 'Please Select Gender',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.selectedMedium==null) {
        Get.snackbar('Select Medium', 'Please Select Medium',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        index++;
      }
    });
  }

  void secondNext() {
    setState(() {
      if (bookingFormController.schoolNameControllers[0].text.isEmpty) {
        Get.snackbar('School Name', 'Please Enter School Name',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (bookingFormController.percentageControllers[0].text.isEmpty) {
        Get.snackbar('Percentage', 'Please Enter Percentage',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        index++;
      }
    });
  }

  Future<void> _onPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 200,
        maxHeight: 200,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile;
        bookingFormController.image = pickedFile!.name;
      });
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: Container(
          padding: EdgeInsets.all(15),
          color: primaryColor,
          child: GetBuilder<BookingFormController>(
              builder: (bookingFormController) {
            return bookingFormController.packageData == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        backgroundColor: primaryColor,
                        title: Text(
                          "Booking Form",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true,
                        actions: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "General English",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "GR- II & IIA Prelims General Studies",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "+ English",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 10),
                        child: Row(
                          children: [
                            Image.asset("assets/png_file/mcq_outline.png",
                                height: 22, width: 22),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "MCQ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                            Image.asset("assets/png_file/test.png",
                                height: 22, width: 22, color: Colors.white),
                            //Icon(Icons.timer, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "20 Tests",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        backgroundColor: primaryColor,
                        title: Text(
                          "Booking Form",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true,
                        actions: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        bookingFormController.packageData!.languages.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        bookingFormController.packageData!.packageNameLang1
                            .toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 10),
                        child: Row(
                          children: [
                            Image.asset("assets/png_file/mcq_outline.png",
                                height: 22, width: 22),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              bookingFormController.packageData!.examType
                                  .toString()
                                  .toUpperCase(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                            Image.asset("assets/png_file/test.png",
                                height: 22, width: 22, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${bookingFormController.packageData!.noOfTest.toString()} Tests",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
      body: Obx(
        () => bookingFormController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: Offset(0.0, 4.0))
                                        ],
                                        color: Color(0xffEEB6CC)),
                                  ),
                                ),
                                Visibility(
                                  visible: index > 0 ? true : false,
                                  child: Positioned(
                                    top: -5,
                                    left: 0,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: 150,
                              lineThickness: 3.0,
                              dashLength: 4.0,
                              dashColor: Color(0xffDBDBDB),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: index > 1 ? 2 : 1,
                                          color: Colors.white),
                                      boxShadow: [
                                        index > 0
                                            ? BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 3,
                                                spreadRadius: 1,
                                                offset: Offset(0.0, 4.0))
                                            : BoxShadow()
                                      ],
                                      color: index > 0
                                          ? Color(0xffEEB6CC)
                                          : Color(0xffDBDBDB),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: index > 1 ? true : false,
                                  child: Positioned(
                                    top: -5,
                                    left: 0,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: 150,
                              lineThickness: 3.0,
                              dashLength: 4.0,
                              dashColor: Color(0xffDBDBDB),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width:
                                                bookingFormController.checked ==
                                                        true
                                                    ? 2
                                                    : 1,
                                            color: Colors.white),
                                        boxShadow: [
                                          bookingFormController.checked == true
                                              ? BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 3,
                                                  spreadRadius: 1,
                                                  offset: Offset(0.0, 4.0))
                                              : BoxShadow()
                                        ],
                                        color: bookingFormController.checked ==
                                                true
                                            ? Color(0xffEEB6CC)
                                            : Color(0xffDBDBDB),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bookingFormController.checked,
                                  child: Positioned(
                                    top: -5,
                                    left: 0,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: index == 1
                              ? second()
                              : index == 2
                                  ? third()
                                  : first()),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget first() {
    return SingleChildScrollView(
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Student Details",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Student Image",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Text(
                "000px*8000px - jpg only",
                style: TextStyle(fontSize: 14, color: Color(0xff8F9394)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 3.0,
          dashLength: 4.0,
          dashColor: Color(0xffB5B5B5),
        ),
        InkWell(
          onTap: () {
            _onPressed(ImageSource.gallery);
          },
          child: Container(
            color: Color(0xffF5F5F5),
            child: Row(
              children: [
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 60,
                  lineThickness: 3.0,
                  dashLength: 4.0,
                  dashColor: Color(0xffB5B5B5),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          color: Color(0xffA6A6A6),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                       bookingFormController.image == null || bookingFormController.image == ""
                            ? Text(
                                "Upload image",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA6A6A6),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              )
                            : Container(
                              width: 300,
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                bookingFormController.image!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffA6A6A6),
                                      decoration: TextDecoration.underline),
                                ),
                            ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 60,
                  lineThickness: 3.0,
                  dashLength: 4.0,
                  dashColor: Color(0xffB5B5B5),
                ),
              ],
            ),
          ),
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 3.0,
          dashLength: 4.0,
          dashColor: Color(0xffB5B5B5),
        ),
        SizedBox(
          height: 20,
        ),
        textFieldWidget(bookingFormController.nameController, "Name"),
        textFieldWidget(bookingFormController.dobController, "Date of Birth"),
        textFieldWidget(bookingFormController.emailController, "Email Id"),
        textFieldWidget(bookingFormController.phoneController, "Mobile Number"),
        textFieldWidget(null, "Gender"),
        textFieldWidget(null, "Medium"),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FlatButton(
            color: secondaryColor,
            height: 50,
            minWidth: 140,
            onPressed: () {
              setState(() {
                firstNext();
              });
              print("firstNext ${bookingFormController.nameController.text}");
              print("firstNext ${bookingFormController.dobController.text}");
              print("firstNext ${bookingFormController.emailController.text}");
              print("firstNext ${bookingFormController.phoneController.text}");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ]),
    );
  }

  Widget second() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Educational Details",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 260.0 * bookingFormController.addMoreEducation.toDouble(),
            child: ListView.builder(
                itemCount: bookingFormController.addMoreEducation,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  bookingFormController.schoolNameControllers
                      .add(new TextEditingController());
                  bookingFormController.percentageControllers
                      .add(new TextEditingController());
                  for (int i = 0;
                      i < bookingFormController.addMoreEducation;
                      i++) {
                    bookingFormController.selectedQualification.add("SSLC");
                  }
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Education ${index + 1}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            index + 1 == bookingFormController.addMoreEducation
                                ? InkWell(
                                    onTap: () {
                                      if (bookingFormController
                                                  .addMoreEducation <=
                                              4 &&
                                          bookingFormController
                                                  .addMoreEducation >
                                              1)
                                        bookingFormController
                                            .addMoreEducation -= 1;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ))
                                : Container(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text("Qualification"),
                            value: bookingFormController
                                .selectedQualification[index],
                            items: _dropDownItem(),
                            onChanged: (val) {
                              setState(() {
                                bookingFormController
                                        .selectedQualification[index] =
                                    val.toString();
                                bookingFormController.update();
                              });
                            },
                          ),
                        ),
                        textFieldWidget(
                            bookingFormController.schoolNameControllers[index],
                            "School / College Name"),
                        textFieldWidget(
                            bookingFormController.percentageControllers[index],
                            "Percentage"),
                        SizedBox(height: size12),
                      ],
                    ),
                  );
                }),
          ),
          bookingFormController.addMoreEducation < 4 ?
          TextButton(
            onPressed: () {
              if (bookingFormController.addMoreEducation < 4)
                bookingFormController.addMoreEducation += 1;
              setState(() {});
            },
            child: Text(
              "Add More Education",
              style: TextStyle(
                  color: Color(0xff296ACC),
                  decoration: TextDecoration.underline),
            ),
          ) : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FlatButton(
              color: secondaryColor,
              height: 50,
              minWidth: 140,
              onPressed: () {
                setState(() {
                  secondNext();
                });
                print("index $index");

                print(
                    "bookingFormController.addMoreEducation :- ${bookingFormController.addMoreEducation}");
                bookingFormController.educationList.clear();
                for (int i = 0;
                    i < bookingFormController.addMoreEducation;
                    i++) {
                  print("check $i");
                  try {
                    bookingFormController.education.qualification =
                        bookingFormController.selectedQualification[i];
                    bookingFormController.education.SchoolName =
                        bookingFormController.schoolNameControllers[i].text
                            .toString();
                    bookingFormController.education.percentage =
                        bookingFormController.percentageControllers[i].text
                            .toString();
                  } on Exception catch (e, s) {
                    print(s);
                  }
                  print(
                      "secondNext ${bookingFormController.education.qualification}");
                  print(
                      "secondNext ${bookingFormController.education.SchoolName}");
                  print(
                      "secondNext ${bookingFormController.education.percentage}");
                  bookingFormController.educationList.add(Education(
                    qualification:
                        bookingFormController.education.qualification,
                    SchoolName: bookingFormController.education.SchoolName,
                    percentage: bookingFormController.education.percentage,
                  ));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget third() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Details Review",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Student Image",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Text(
                  "000px*8000px - jpg only",
                  style: TextStyle(fontSize: 14, color: Color(0xff8F9394)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 3.0,
            dashLength: 4.0,
            dashColor: Color(0xffB5B5B5),
          ),
          Container(
            color: Color(0xffF5F5F5),
            child: Row(
              children: [
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 60,
                  lineThickness: 3.0,
                  dashLength: 4.0,
                  dashColor: Color(0xffB5B5B5),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          color: Color(0xffA6A6A6),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        bookingFormController.image == null || bookingFormController.image == ""
                            ? Text(
                          "Upload image",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffA6A6A6),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ) : Container(
                          width: 300,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            bookingFormController.image!,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffA6A6A6),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 60,
                  lineThickness: 3.0,
                  dashLength: 4.0,
                  dashColor: Color(0xffB5B5B5),
                ),
              ],
            ),
          ),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 3.0,
            dashLength: 4.0,
            dashColor: Color(0xffB5B5B5),
          ),
          SizedBox(
            height: 20,
          ),
          textWidget(
              bookingFormController.nameController.text.toString(), 18, true),
          textWidget(
              bookingFormController.dobController.text.toString(), 16, false),
          textWidget(
              bookingFormController.emailController.text.toString(), 16, false),
          textWidget(
              bookingFormController.phoneController.text.toString(), 16, false),
          textWidget(
              bookingFormController.selectedGender.toString(), 16, false),
          textWidget(
              bookingFormController.selectedMedium.toString(), 16, false),
          SizedBox(height: 20),
          Container(
            height: 120 * bookingFormController.addMoreEducation.toDouble(),
            child: ListView.builder(
                itemCount: bookingFormController.addMoreEducation,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Education ${index + 1}", 18, true),
                      textWidget("${bookingFormController.selectedQualification[index].toString()}", 16, false),
                      textWidget("${bookingFormController.schoolNameControllers[index].text.toString()}", 16, false),
                      textWidget("${bookingFormController.percentageControllers[index].text.toString()}%", 16, false),
                    ],
                  );
                }),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        bookingFormController.checked = value!;
                      });
                    },
                    value: bookingFormController.checked,
                  ),
                  textWidget("I’m not a robot", 18, true),
                  SizedBox(width: 8),
                  Image.asset(
                    "assets/png_file/recaptcha.png",
                    height: 30,
                    width: 30,
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FlatButton(
              color: secondaryColor,
              height: 50,
              minWidth: 140,
              onPressed: () {
                setState(() {
                  if (bookingFormController.checked != true) {
                    Get.snackbar('Checkbox', 'Please Check Your Checkbox',
                        backgroundColor: Colors.red, colorText: Colors.white);
                  } else {
                    bookingFormController.bookingFormApiDataCalling();
                  }
                  print("index $index");
                  print("Submit");

                  print(
                      "firstNext 1 ${bookingFormController.nameController.text}");
                  print(
                      "firstNext 1 ${bookingFormController.dobController.text}");
                  print(
                      "firstNext 1 ${bookingFormController.emailController.text}");
                  print(
                      "firstNext 1 ${bookingFormController.phoneController.text}");

                  print(
                      "educationList ${bookingFormController.educationList.length}");
                  bookingFormController.educationList.forEach((element) {
                    print("educationList ${element.percentage}");
                    print("educationList ${element.qualification}");
                    print("educationList ${element.SchoolName}");
                  });

                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookingFormController.selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100), //DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: Container(
            child: child,
          ),
        );
      },
    );
    if (picked != null && picked != bookingFormController.selectedDate) {
      setState(() {
        bookingFormController.selectedDate = picked;
        print(
            "Date : ${DateFormat('dd-MM-yyyy').parse(DateTime.now().toString())}");
        bookingFormController.dobController.text =
            bookingFormController.selectedDate.toString().split(" ").first;
      });
    }
  }

  /// This builds cupertino date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size10),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontWeight: TextUtils.normalTextWeight,
                          fontSize:
                              TextUtils.hintTextSize / Get.textScaleFactor,
                          fontFamily: TextUtils.interFontFamily,
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[300],
                      minimumSize: const Size(70, 30),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (picked) {
                        if (picked != bookingFormController.selectedDate) {
                          setState(() {
                            bookingFormController.selectedDate = picked;
                            bookingFormController.dobController.text =
                                bookingFormController.selectedDate
                                    .toString()
                                    .split(" ")
                                    .first;
                          });
                        }
                      },
                      minimumYear: 1950,
                      maximumYear: 2100 //DateTime.now().year,
                      ),
                ),
              ],
            ),
          );
        });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    return bookingFormController.qualificationDataList
        .map((value) => DropdownMenuItem(
              value: value.name,
              child: Text(value.name.toString()),
            ))
        .toList();
  }

  Widget textFieldWidget(
      [TextEditingController? _controller,
      String? hintText,
      String? selectedQualification,
      List<DropdownMenuItem<String>>? itemList]) {
    return GetBuilder<BookingFormController>(builder: (bookingFormController) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: hintText == "Gender"
            ? DropdownButton<String>(
                isExpanded: true,
                hint: Text(hintText!),
                icon: Icon(Icons.keyboard_arrow_down),
                value: bookingFormController.selectedGender,
                items:
                    bookingFormController.genderDataList.map((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value.genderName,
                    child: Text(value.genderName.toString()),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    print("Id : ${val}");
                    bookingFormController.selectedGender = val;
                    bookingFormController.update();
                  });
                },
              )
            : hintText == "Medium"
                ? DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(hintText!),
                    value: bookingFormController.selectedMedium,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: bookingFormController.mediumDataList
                        .map((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value.medium,
                        child: Text(value.medium.toString()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        bookingFormController.selectedMedium = val;
                        bookingFormController.update();
                      });
                    },
                  )
                : hintText == "Qualification"
                    ? DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(hintText!),
                        value: selectedQualification,
                        items: itemList,
                        icon: Icon(Icons.keyboard_arrow_down),
                        onChanged: (val) {
                          setState(() {
                            selectedQualification = val;
                            bookingFormController.update();
                          });
                        },
                      )
                    : TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _controller,
                        cursorColor: primaryColor,
                        maxLength: hintText == "Mobile Number" ? 10 : 100,
                        decoration: InputDecoration(
                            hintText: hintText,
                            counterText: "",
                            border: UnderlineInputBorder(),
                            suffixIcon: hintText == "Date of Birth"
                                ? InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                          "assets/png_file/date_range.png",
                                          height: 22,
                                          width: 22),
                                    ),
                                  )
                                : SizedBox.shrink()),
                      ),
      );
    });
  }

  List<String> selectedItemValue = <String>[];

  Widget textWidget(String data, double size, bool weight) =>
      GetBuilder<BookingFormController>(builder: (bookingFormController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            data,
            style: TextStyle(
                fontSize: size,
                fontWeight: weight ? FontWeight.bold : FontWeight.normal),
          ),
        );
      });
}

class ImageForm extends StatefulWidget {
  const ImageForm({Key? key}) : super(key: key);

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return Container();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        // await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Form"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                children: [
                  Text("K"),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: 150,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.black,
                    dashGradient: [Colors.red, Colors.blue],
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapGradient: [Colors.red, Colors.blue],
                    dashGapRadius: 0.0,
                  ),
                  Text("K"),
                ],
              ),
            ),
            Center(
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _handlePreview();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _handlePreview(),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: Container(),
      );
    } else {
      return Container();
    }
  }
}
