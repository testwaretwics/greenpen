import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';

import 'cart_page.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key? key}) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  late Widget _widget;
  String buttonText = "Next";
  var index = 0;
  var _nameController = TextEditingController();
  var _dobController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _genderController = TextEditingController();
  var _mediumController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  String? _image;

  dynamic pickImageError;
  bool isVideo = false;

  String? _retrieveDataError;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widget = first();
  }

  void next() {
    setState(() {
      index++;
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
        _image = pickedFile!.name;
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
          child: Column(
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
                    Icon(Icons.timer, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "MCQ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Spacer(),
                    Icon(Icons.timer, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "20 Tests",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Spacer(),
                  ],
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
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 60,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEEB6CC)),
                            ),
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
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index > 0
                                    ? Color(0xffEEB6CC)
                                    : Color(0xffDBDBDB),
                              ),
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
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffEFF1FA)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(child: _widget),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FlatButton(
                  color: primaryColor,
                  height: 50,
                  minWidth: 140,
                  onPressed: () {
                    index < 2 ? next() : Get.to(() => CartPage());
                    setState(() {
                      index == 1
                          ? _widget = second()
                          : index == 2
                              ? {_widget = third(), buttonText = "Submit"}
                              : _widget = first();
                    });
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
            ],
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
                        _image == null
                            ? Text(
                                "Upload image",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA6A6A6),
                                    decoration: TextDecoration.underline),
                              )
                            : Text(
                                _image!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA6A6A6),
                                    decoration: TextDecoration.underline),
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
        textFieldWidget(_nameController, "Name"),
        textFieldWidget(_dobController, "Date of Birth"),
        textFieldWidget(_emailController, "Email Id"),
        textFieldWidget(_phoneController, "Mobile Number"),
        textFieldWidget(_genderController, "Gender"),
        textFieldWidget(_mediumController, "Medium"),
      ]),
    );
  }

  Padding textFieldWidget(TextEditingController _controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          // icon: Icon(
          //   icon,
          //   color: primaryColor,
          // ),
          hintText: hintText,
          border: UnderlineInputBorder(),
        ),
      ),
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Education 1",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          textFieldWidget(_nameController, "Name"),
          textFieldWidget(_nameController, "Name"),
          textFieldWidget(_nameController, "Name"),
          TextButton(
            onPressed: () {},
            child: Text(
              "Add More Education",
              style: TextStyle(
                  color: Color(0xff296ACC),
                  decoration: TextDecoration.underline),
            ),
          )
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
                        Text(
                          "Upload image",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffA6A6A6),
                              decoration: TextDecoration.underline),
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
          textWidget("Abhirami Balamurugan", 18, true),
          textWidget("02-Jun-1997", 16, false),
          textWidget("abhi@gmail.com", 16, false),
          textWidget("+1234567890", 16, false),
          textWidget("Female", 16, false),
          textWidget("English", 16, false),
          SizedBox(height: 20),
          textWidget("Education 1", 18, true),
          textWidget("UG", 16, false),
          textWidget("St. Joseph’s Institute of Technology", 16, false),
          textWidget("89%", 16, false),
          Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (bool? value) {},
                    value: false,
                  ),
                  textWidget("I’m not a robot", 18, true),
                ],
              ))
        ],
      ),
    );
  }

  Padding textWidget(String data, double size, bool weight) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          data,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight ? FontWeight.bold : FontWeight.normal),
        ),
      );
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
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
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
