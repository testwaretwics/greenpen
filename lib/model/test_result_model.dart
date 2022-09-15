class TestResultModel {
  bool? status;
  String? message;
  Result? result;

  TestResultModel({this.status, this.message, this.result});

  TestResultModel.fromJson(Map<String, dynamic> json) {
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
  List<TestResult>? testResult;
  List<CategoryList>? categoryList;

  Result({this.testResult, this.categoryList});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['test_result'] != null) {
      testResult = <TestResult>[];
      json['test_result'].forEach((v) {
        testResult!.add(new TestResult.fromJson(v));
      });
    }
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testResult != null) {
      data['test_result'] = this.testResult!.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestResult {
  int? id;
  String? category;
  int? categoryId;
  String? packageNameLang1;
  String? testTitle;
  String? packageType;
  String? noOfTest;
  String? languages;
  String? examType;
  String? testNoQuestion;
  String? testDate;
  String? testTime;
  String? userTotalMarks;
  String? userRank;
  String? createdAt;

  TestResult(
      {this.id,
        this.category,
        this.categoryId,
        this.packageNameLang1,
        this.testTitle,
        this.packageType,
        this.noOfTest,
        this.languages,
        this.examType,
        this.testNoQuestion,
        this.testDate,
        this.testTime,
        this.userTotalMarks,
        this.userRank,
        this.createdAt});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryId = json['category_id'];
    packageNameLang1 = json['package_name_lang1'];
    testTitle = json['test_title'];
    packageType = json['package_type'];
    noOfTest = json['no_of_test'];
    languages = json['languages'];
    examType = json['exam_type'];
    testNoQuestion = json['test_no_question'];
    testDate = json['test_date'];
    testTime = json['test_time'];
    userTotalMarks = json['user_total_marks'];
    userRank = json['user_rank'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['package_name_lang1'] = this.packageNameLang1;
    data['test_title'] = this.testTitle;
    data['package_type'] = this.packageType;
    data['no_of_test'] = this.noOfTest;
    data['languages'] = this.languages;
    data['exam_type'] = this.examType;
    data['test_no_question'] = this.testNoQuestion;
    data['test_date'] = this.testDate;
    data['test_time'] = this.testTime;
    data['user_total_marks'] = this.userTotalMarks;
    data['user_rank'] = this.userRank;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CategoryList {
  int? id;
  String? courseCategoryLang1;

  CategoryList({this.id, this.courseCategoryLang1});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCategoryLang1 = json['course_category_lang1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_category_lang1'] = this.courseCategoryLang1;
    return data;
  }
}