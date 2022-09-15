class BuyTestDetailsModel {
  bool? status;
  String? message;
  Result? result;

  BuyTestDetailsModel({this.status, this.message, this.result});

  BuyTestDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  PackageDetail? packageDetail;
  List<McqTest>? mcqTest;
 // List<Null>? desTest;

  Result({this.packageDetail, this.mcqTest,/* this.desTest*/});

  Result.fromJson(Map<String, dynamic> json) {
    packageDetail = json['package_detail'] != null
        ? new PackageDetail.fromJson(json['package_detail'])
        : null;
    if (json['mcq_test'] != null) {
      mcqTest = <McqTest>[];
      json['mcq_test'].forEach((v) {
        mcqTest!.add(new McqTest.fromJson(v));
      });
    }
    // if (json['des_test'] != null) {
    //   desTest = <Null>[];
    //   json['des_test'].forEach((v) {
    //     desTest!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packageDetail != null) {
      data['package_detail'] = this.packageDetail!.toJson();
    }
    if (this.mcqTest != null) {
      data['mcq_test'] = this.mcqTest!.map((v) => v.toJson()).toList();
    }
    // if (this.desTest != null) {
    //   data['des_test'] = this.desTest!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class PackageDetail {
  int? categoryId;
  String? courseCategoryLang1;
  int? packageId;
  String? packageNameLang1;
  String? languages;
  String? packageType;
  String? examType;
  String? noOfTest;
  String? startDate;
  String? packageVersion;
  int? feesForNew;
  String? cartStatus;
  int? orderStatus;

  PackageDetail(
      {this.categoryId,
        this.courseCategoryLang1,
        this.packageId,
        this.packageNameLang1,
        this.languages,
        this.packageType,
        this.examType,
        this.noOfTest,
        this.startDate,
        this.packageVersion,
        this.feesForNew,
        this.cartStatus,
        this.orderStatus});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    courseCategoryLang1 = json['course_category_lang1'];
    packageId = json['package_id'];
    packageNameLang1 = json['package_name_lang1'];
    languages = json['languages'];
    packageType = json['package_type'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    startDate = json['start_date'];
    packageVersion = json['package_version'];
    feesForNew = json['fees_for_new'];
    cartStatus = json['cart_status'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['course_category_lang1'] = this.courseCategoryLang1;
    data['package_id'] = this.packageId;
    data['package_name_lang1'] = this.packageNameLang1;
    data['languages'] = this.languages;
    data['package_type'] = this.packageType;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['start_date'] = this.startDate;
    data['package_version'] = this.packageVersion;
    data['fees_for_new'] = this.feesForNew;
    data['cart_status'] = this.cartStatus;
    data['order_status'] = this.orderStatus;
    return data;
  }
}

class McqTest {
  int? testWrittingType;
  int? noOfTimes;
  int? testId;
  String? packageId;
  String? testTitle;
  String? examType;
  int? noOfTest;
  String? testTime;
  int? totalMark;
  int? testNoQuestion;
  String? date;
  int? testStatus;

  McqTest(
      {this.testWrittingType,
        this.noOfTimes,
        this.testId,
        this.packageId,
        this.testTitle,
        this.examType,
        this.noOfTest,
        this.testTime,
        this.totalMark,
        this.testNoQuestion,
        this.date,
        this.testStatus});

  McqTest.fromJson(Map<String, dynamic> json) {
    testWrittingType = json['test_writting_type'];
    noOfTimes = json['no_of_times'];
    testId = json['test_id'];
    packageId = json['package_id'];
    testTitle = json['test_title'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    testTime = json['test_time'];
    totalMark = json['total_mark'];
    testNoQuestion = json['test_no_question'];
    date = json['date'];
    testStatus = json['test_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_writting_type'] = this.testWrittingType;
    data['no_of_times'] = this.noOfTimes;
    data['test_id'] = this.testId;
    data['package_id'] = this.packageId;
    data['test_title'] = this.testTitle;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['test_time'] = this.testTime;
    data['total_mark'] = this.totalMark;
    data['test_no_question'] = this.testNoQuestion;
    data['date'] = this.date;
    data['test_status'] = this.testStatus;
    return data;
  }
}
