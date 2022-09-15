class TakeTestModel {
  bool? status;
  String? message;
  Result? result;

  TakeTestModel({this.status, this.message, this.result});

  TakeTestModel.fromJson(Map<String, dynamic> json) {
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
  List<Order>? order;
  List<Category>? category;

  Result({this.order, this.category});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? categoryId;
  String? packageNameLang1;
  String? languages;
  String? examType;
  String? noOfTest;
  String? startDate;

  Order(
      {this.id,
        this.categoryId,
        this.packageNameLang1,
        this.languages,
        this.examType,
        this.noOfTest,
        this.startDate});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    packageNameLang1 = json['package_name_lang1'];
    languages = json['languages'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['package_name_lang1'] = this.packageNameLang1;
    data['languages'] = this.languages;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['start_date'] = this.startDate;
    return data;
  }
}

class Category {
  String? courseCategoryLang1;
  int? id;

  Category({this.courseCategoryLang1, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    courseCategoryLang1 = json['course_category_lang1'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_category_lang1'] = this.courseCategoryLang1;
    data['id'] = this.id;
    return data;
  }
}