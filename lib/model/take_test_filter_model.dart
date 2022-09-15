class TakeTestFilterModel {
  bool? status;
  String? message;
  Result? result;

  TakeTestFilterModel({this.status, this.message, this.result});

  TakeTestFilterModel.fromJson(Map<String, dynamic> json) {
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
  //List<Null>? order;
  List<Category>? category;

  Result({/*this.order,*/ this.category});

  Result.fromJson(Map<String, dynamic> json) {
    // if (json['order'] != null) {
    //  // order = <Null>[];
    //   json['order'].forEach((v) {
    //     order!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.order != null) {
    //   data['order'] = this.order!.map((v) => v!.toJson()).toList();
    // }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? courseCategoryLang1;

  Category({this.courseCategoryLang1});

  Category.fromJson(Map<String, dynamic> json) {
    courseCategoryLang1 = json['course_category_lang1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_category_lang1'] = this.courseCategoryLang1;
    return data;
  }
}