class TakeTestDetailModel {
  bool? status;
  String? message;
  Result? result;

  TakeTestDetailModel({this.status, this.message, this.result});

  TakeTestDetailModel.fromJson(Map<String, dynamic> json) {
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
  Package? package;
  List<McqTest>? mcqTest;
 // List<Null>? desTest;

  Result({this.package, this.mcqTest/*, this.desTest*/});

  Result.fromJson(Map<String, dynamic> json) {
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
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
    if (this.package != null) {
      data['package'] = this.package!.toJson();
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

class Package {
  String? id;
  int? categoryId;
  String? courseCategoryLang1;
  String? languages;
  String? packageNameLang1;
  String? packageType;
  String? examType;
  String? noOfTest;
  int? packageMethod;
  int? feesForNew;

  Package(
      {this.id,
        this.categoryId,
        this.courseCategoryLang1,
        this.languages,
        this.packageNameLang1,
        this.packageType,
        this.examType,
        this.noOfTest,
        this.packageMethod,
        this.feesForNew});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    courseCategoryLang1 = json['course_category_lang1'];
    languages = json['languages'];
    packageNameLang1 = json['package_name_lang1'];
    packageType = json['package_type'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    packageMethod = json['package_method'];
    feesForNew = json['fees_for_new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['course_category_lang1'] = this.courseCategoryLang1;
    data['languages'] = this.languages;
    data['package_name_lang1'] = this.packageNameLang1;
    data['package_type'] = this.packageType;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['package_method'] = this.packageMethod;
    data['fees_for_new'] = this.feesForNew;
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
  int? resultId;

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
        this.testStatus,
        this.resultId});

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
    resultId = json['result_id'];
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
    data['result_id'] = this.resultId;
    return data;
  }
}